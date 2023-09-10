#' Calibrate scores into Log-Likelihood Ratios
#'
#' This function is used to transform the scores returned by a verification function into a Log-Likelihood Ratio (LLR).
#'
#' More details here.
#'
#' @param calibration.dataset A data frame containing scores to calibrate. This is the result of a function like [impostors()].
#' @param dataset A data frame containing only one row with the score that will be calibrated into a LLR using the calibration data. This is typically the result of applying a function like [impostors()] to the Q text.
#'
#' @return The function returns a list containing two data frames: the LLR for the Q text and a table showing some hypothetical scenarios with prior probabilities/odds being turned into posterior probabilities/odds according to the likelihood ratio obtained.
#' @export
#'
#' @examples
#'calib <- data.frame(score = c(0.5, 0.2, 0.8, 0.01, 0.6), target = c(TRUE, FALSE, TRUE, FALSE, TRUE))
#'q <- data.frame(score = c(0.35))
#'calibrate_LLR(calib, q)
calibrate_LLR = function(calibration.dataset, dataset){

  suppressWarnings(ROC::train.logreg(calibration.dataset) -> calibration.model)

  stats::predict(calibration.model, newdata = dataset) -> logit

  llr = logit/log(10)

  newdata = cbind(dataset, llr)

  dplyr::tibble(prosecution_prior_probs = seq(0.1, 0.9, 0.1),) |>
    dplyr::mutate(prior_odds = prosecution_prior_probs/(1-prosecution_prior_probs)) |>
    dplyr::mutate(LLR = as.numeric(newdata$llr)) |>
    dplyr::mutate(LR = 10^LLR) |>
    dplyr::mutate(post_odds = LR*prior_odds) |>
    dplyr::mutate(prosecution_post_probs = post_odds/(1+post_odds)) -> post.table

  result.list = list(calibrated.data = newdata, post.odds.table = post.table)

  return(result.list)

}
