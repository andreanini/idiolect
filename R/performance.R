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
#' This function is used to the test the performance of an authorship analysis method, such as the *Impostors Method*.
#'
#' Before applying a method to a real authorship case, it is good practice to test it known ground truth data. This function performs this test by taking as input a table of results or two tables, one for training and one for the test, and then returning as output a list with the following performance statistics: the log-likelihood ratio cost (both Cllr and Cllr-min), Equal Error Rate (ERR), the mean values of the log-likelihood ratio for both the same-author (TRUE) and different-author (FALSE) cases, the Area Under the Curve (AUC), Balanced Accuracy, Precision, Recall, F1, and the full confusion matrix. The binary classification statistics are all calculated considering a Log-Likelihood Ratio score of 0 as a threshold.
#'
#' @param training The data frame with the results to evaluate, typically the output of an authorship analysis function, such as [impostors()]. If only training is present then the function will perform a leave-one-out cross-validation.
#' @param test Optional data frame of results. If present then a calibration model is extracted from training and its performance is evaluated on this data set.
#'
#' @return The function returns a list containing a data frame with performance statistics, including an object that can be used to make a tippet plot using the [ROC::tippet.plot()] function from [ROC].
#'
#' @examples
#' results <- data.frame(score = c(0.5, 0.2, 0.8, 0.01), target = c(TRUE, FALSE, TRUE, FALSE))
#' perf <- performance(results)
#' perf$evaluation
#' ROC::tippet.plot(perf$roc)
#'
#' @export
performance = function(training, test = NULL){

  if(is.null(test)){

    res.llr = leave_one_out_llr(training)

    res.llr |>
      dplyr::select(llr, target) |>
      dplyr::rename(score = llr) |>
      ROC::roc() -> roc.object

    roc.object |>
      ROC::summary.roc() -> roc.res

    res.llr |>
      dplyr::mutate(predicted = dplyr::if_else(llr > 0, T, F)) -> res.res

    AUC <- pROC::roc(res.llr$target, res.llr$llr) |> pROC::auc()

    cm = caret::confusionMatrix(as.factor(res.res$predicted),
                                as.factor(res.res$target),
                                positive = "TRUE")

  }else{

    training.model = suppressWarnings(ROC::train.logreg(training))

    res.llr = dplyr::mutate(test, llr = stats::predict(training.model, test))

    res.llr |>
      dplyr::select(llr, target) |>
      dplyr::rename(score = llr) |>
      ROC::roc() -> roc.object

    roc.object |>
      ROC::summary.roc() -> roc.res

    res.llr |>
      dplyr::mutate(predicted = dplyr::if_else(llr > 0, T, F)) -> res.res

    AUC <- pROC::roc(res.llr$target, res.llr$llr) |> pROC::auc()

    cm = caret::confusionMatrix(as.factor(res.res$predicted),
                                as.factor(res.res$target),
                                positive = "TRUE")

  }

  evaluation.res = data.frame()
  evaluation.res[1, "Cllr"] = roc.res$Cllr
  evaluation.res[1, "Cllr_min"] = roc.res$Cllr.min
  evaluation.res[1, "EER"] = roc.res$eer
  evaluation.res[1, "Mean TRUE LLR"] = roc.res$mt
  evaluation.res[1, "Mean FALSE LLR"] = roc.res$mn
  evaluation.res[1, "TRUE trials"] = roc.res$nt
  evaluation.res[1, "FALSE trials"] = roc.res$nn
  evaluation.res[1, "AUC"] = AUC
  evaluation.res[1, "Balanced Accuracy"] = as.numeric(cm$byClass["Balanced Accuracy"])
  evaluation.res[1, "Precision"] = as.numeric(cm$byClass["Precision"])
  evaluation.res[1, "Recall"] = as.numeric(cm$byClass["Recall"])
  evaluation.res[1, "F1"] = as.numeric(cm$byClass["F1"])
  evaluation.res[1, "TP"] = cm$table[2,2]
  evaluation.res[1, "FN"] = cm$table[1,2]
  evaluation.res[1, "FP"] = cm$table[2,1]
  evaluation.res[1, "TN"] = cm$table[1,1]

  result.list <- list(evaluation = evaluation.res, roc = roc.object)

  return(result.list)

}
