#' Performance evaluation
#'
#' This function is used to the test the performance of an authorship analysis method.
#'
#' Before applying a method to a real authorship case, it is good practice to test it on known ground truth data. This function performs this test by taking as input either a single table of results or two tables, one for training and one for the test, and then returning as output a list with the following performance statistics: the log-likelihood ratio cost (both \eqn{C_{llr}} and \eqn{C_{llr}^{min}}), Equal Error Rate (ERR), the mean values of the log-likelihood ratio (base 10) for both the same-author (TRUE) and different-author (FALSE) cases, the Area Under the Curve (AUC), Balanced Accuracy, Precision, Recall, F1, and the full confusion matrix. The binary classification statistics are all calculated considering a Log-Likelihood Ratio score of 0 as a threshold.
#'
#' @param training The data frame with the results to evaluate, typically the output of an authorship analysis function, such as [impostors()]. If only training is present then the function will perform a leave-one-out cross-validation.
#' @param test Optional data frame of results. If present then a calibration model is extracted from training and its performance is evaluated on this data set.
#' @param progress Logical. If TRUE (default) then a progress bar is diplayed.
#' @param by Either "case" or "author". If the performance is evaluated leave-one-out, then "case" would go through the table row by row while, if "author" is selected, then the performance is calculated after taking out each author (identified as a value of the K column).
#'
#' @return The function returns a list containing a data frame with performance statistics, including an object that can be used to make a tippet plot using the `tippet.plot()` function of the `ROC` package (https://github.com/davidavdav/ROC).
#'
#' @examples
#' results <- data.frame(score = c(0.5, 0.2, 0.8, 0.01), target = c(TRUE, FALSE, TRUE, FALSE))
#' perf <- performance(results)
#' perf$evaluation
#'
#' @export
performance <- function(training, test = NULL, by = "case", progress = TRUE) {
  if (is.null(test)) {
    if (by == "case") {
      res.llr <- leave_one_out_llr(training, progress)
    } else if (by == "author") {
      res.llr <- leave_one_author_out_llr(training, progress)
    }

    res.llr |>
      dplyr::select(llr, target) |>
      dplyr::rename(score = llr) |>
      roc() -> roc.object

    roc.object |>
      summaryroc() -> roc.res

    res.llr |>
      dplyr::mutate(predicted = dplyr::if_else(llr > 0, TRUE, FALSE)) -> res.res

    AUC <- pROC::roc(res.llr$target, res.llr$llr, quiet = TRUE) |> pROC::auc()

    cm <- caret::confusionMatrix(as.factor(res.res$predicted),
      as.factor(res.res$target),
      positive = "TRUE"
    )
  } else {
    training.model <- suppressWarnings(train.logreg(training))

    res.llr <- dplyr::mutate(test, llr = stats::predict(training.model, test))

    res.llr |>
      dplyr::select(llr, target) |>
      dplyr::rename(score = llr) |>
      roc() -> roc.object

    roc.object |>
      summaryroc() -> roc.res

    res.llr |>
      dplyr::mutate(predicted = dplyr::if_else(llr > 0, TRUE, FALSE)) -> res.res

    AUC <- pROC::roc(res.llr$target, res.llr$llr, quiet = TRUE) |> pROC::auc()

    cm <- caret::confusionMatrix(as.factor(res.res$predicted),
      as.factor(res.res$target),
      positive = "TRUE"
    )
  }

  evaluation.res <- data.frame()
  evaluation.res[1, "Cllr"] <- roc.res$Cllr
  evaluation.res[1, "Cllr_min"] <- roc.res$Cllr.min
  evaluation.res[1, "EER"] <- roc.res$eer
  evaluation.res[1, "Mean TRUE LLR10"] <- roc.res$mt/log(10)
  evaluation.res[1, "Mean FALSE LLR10"] <- roc.res$mn/log(10)
  evaluation.res[1, "TRUE cases"] <- cm$table[2, 2]+cm$table[1, 2]
  evaluation.res[1, "FALSE cases"] <- cm$table[2, 1]+cm$table[1, 1]
  evaluation.res[1, "AUC"] <- AUC
  evaluation.res[1, "Balanced Accuracy"] <- as.numeric(cm$byClass["Balanced Accuracy"])
  evaluation.res[1, "Precision"] <- as.numeric(cm$byClass["Precision"])
  evaluation.res[1, "Recall"] <- as.numeric(cm$byClass["Recall"])
  evaluation.res[1, "F1"] <- as.numeric(cm$byClass["F1"])
  evaluation.res[1, "TP"] <- cm$table[2, 2]
  evaluation.res[1, "FN"] <- cm$table[1, 2]
  evaluation.res[1, "FP"] <- cm$table[2, 1]
  evaluation.res[1, "TN"] <- cm$table[1, 1]

  result.list <- list(evaluation = evaluation.res, roc = roc.object)

  return(result.list)
}

leave_one_out_llr <- function(df, progress) {
  final.llr <- data.frame()

  if (progress == TRUE) {
    pb <- utils::txtProgressBar(min = 1, max = nrow(df), initial = 0, style = 3)
  }

  for (i in 1:nrow(df)) {
    left <- df[i, ]
    rest <- df[-i, ]

    suppressWarnings(train.logreg(rest) -> calibration.model)

    final.llr[i, "llr"] <- stats::predict(calibration.model, newdata = left)

    if (progress == TRUE) {
      utils::setTxtProgressBar(pb, i)
    }
  }

  if (progress == TRUE) {
    close(pb)
  }

  final.llr <- cbind(df, final.llr)

  return(final.llr)
}

leave_one_author_out_llr <- function(df, progress) {
  final.llr <- data.frame()

  unique.ks <- dplyr::pull(df, K) |> unique()

  if (progress == TRUE) {
    pb <- utils::txtProgressBar(min = 1, max = length(unique.ks), initial = 0, style = 3)
  }

  for (i in 1:length(unique.ks)) {
    left <- dplyr::filter(df, K == unique.ks[i])
    rest <- dplyr::filter(df, K != unique.ks[i])

    suppressWarnings(train.logreg(rest) -> calibration.model)

    llr <- stats::predict(calibration.model, newdata = left)

    left.llr <- dplyr::mutate(left, llr = llr)

    final.llr <- rbind(final.llr, left.llr)

    if (progress == TRUE) {
      utils::setTxtProgressBar(pb, i)
    }
  }

  if (progress == TRUE) {
    close(pb)
  }

  return(final.llr)
}
