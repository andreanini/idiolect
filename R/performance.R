leave_one_out_llr = function(df){

  final.llr = data.frame()

  pb = utils::txtProgressBar(min = 1, max = nrow(df), initial = 0, style = 3)

  for (i in 1:nrow(df)) {

    left = df[i,]
    rest = df[-i,]

    suppressWarnings(ROC::train.logreg(rest) -> calibration.model)

    stats::predict(calibration.model, newdata = left) -> llr

    final.llr[i, "llr"] = llr/log(10)

    utils::setTxtProgressBar(pb, i)

  }

  close(pb)

  final.llr = cbind(df, final.llr)

  return(final.llr)

}
#' Performance evaluation
#'
#' This function is used to the test the performance of a verification function, such as the *Impostors Method*.
#'
#' More details here.
#'
#' @param training The data frame with the results to evaluate, typically the output of an authorship verification function, such as [impostors()]. If only training is present then the function will perform a leave-one-out cross-validation.
#' @param test Optional data frame of results. If present then a calibration model is extracted from training and its performance is evaluated on this data set.
#'
#' @return The function returns a data frame with performance statistics, including the C_llr. The binary classification statistics are all calculated considering a Log-Likelihood Ratio score of 0 as a threshold.
#' @export
#'
#' @examples
#' results <- data.frame(score = c(0.5, 0.2, 0.8, 0.01), target = c(TRUE, FALSE, TRUE, FALSE))
#' performance(results)
performance = function(training, test = NULL){

  if(is.null(test)){

    res.llr = leave_one_out_llr(training)

    res.llr |>
      dplyr::select(llr, target) |>
      dplyr::rename(score = llr) |>
      ROC::roc() |>
      ROC::summary.roc() -> roc.res

    res.llr |>
      dplyr::mutate(predicted = dplyr::if_else(llr > 0, T, F)) -> res.res

    cm = caret::confusionMatrix(as.factor(res.res$predicted), as.factor(res.res$target), positive = "TRUE")

  }else{

    training.model = suppressWarnings(ROC::train.logreg(training))

    res.llr = dplyr::mutate(test, llr = stats::predict(training.model, test))

    res.llr |>
      dplyr::select(llr, target) |>
      dplyr::rename(score = llr) |>
      ROC::roc() |>
      ROC::summary.roc() -> roc.res

    res.llr |>
      dplyr::mutate(predicted = dplyr::if_else(llr > 0, T, F)) -> res.res

    cm = caret::confusionMatrix(as.factor(res.res$predicted), as.factor(res.res$target), positive = "TRUE")

  }

  evaluation.res = data.frame()
  evaluation.res[1, "Cllr"] = roc.res$Cllr
  evaluation.res[1, "Cllr_min"] = roc.res$Cllr.min
  evaluation.res[1, "EER"] = roc.res$eer
  evaluation.res[1, "Mean TRUE LLR"] = roc.res$mt
  evaluation.res[1, "Mean FALSE LLR"] = roc.res$mn
  evaluation.res[1, "TRUE cases"] = roc.res$nt
  evaluation.res[1, "FALSE cases"] = roc.res$nn
  evaluation.res[1, "Accuracy"] = as.numeric(cm$overall["Accuracy"])
  evaluation.res[1, "Precision"] = as.numeric(cm$byClass["Precision"])
  evaluation.res[1, "Recall"] = as.numeric(cm$byClass["Recall"])
  evaluation.res[1, "F1"] = as.numeric(cm$byClass["F1"])
  evaluation.res[1, "TP"] = cm$table[2,2]
  evaluation.res[1, "FN"] = cm$table[1,2]
  evaluation.res[1, "FP"] = cm$table[2,1]
  evaluation.res[1, "TN"] = cm$table[1,1]

  return(evaluation.res)

}
