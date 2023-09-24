#' Calibrate scores into Log-Likelihood Ratios
#'
#' This function is used to transform the scores returned by a verification function into a Log-Likelihood Ratio (LLR).
#'
#' More details here.
#'
#' @param calibration.dataset A data frame containing only one score to calibrate. This is the result of a function like [impostors()].
#' @param dataset A data frame containing only one row with the score that will be calibrated into a LLR using the calibration data. This is typically the result of applying a function like [impostors()] to the Q text.
#'
#' @return The function returns a list containing two data frames: a first data frame with the LLR, as well as the verbal label according to Marquis et al (2016) and a verbal interpretation of the results; and a second data frame showing some hypothetical scenarios with prior probabilities/odds being turned into posterior probabilities/odds according to the likelihood ratio obtained.
#' @export
#'
#' @examples
#'calib <- data.frame(score = c(0.5, 0.2, 0.8, 0.01, 0.6), target = c(TRUE, FALSE, TRUE, FALSE, TRUE))
#'q <- data.frame(score = c(0.35))
#'calibrate_LLR(calib, q)
calibrate_LLR = function(calibration.dataset, dataset){

  if(nrow(dataset) > 1){

    stop("Only one row containing one score is accepted.")

  }

  llr.table <- data.frame()

  suppressWarnings(ROC::train.logreg(calibration.dataset) -> calibration.model)

  LLR <- stats::predict(calibration.model, newdata = dataset)/log(10)

  dataset |>
    dplyr::mutate(llr = LLR[[1]],
           Verbal = dplyr::case_when(llr > 4 ~ "Extremely strong support for Hp",
                                     llr <= 4 & llr >= 3 ~ "Very strong support for Hp",
                                     llr < 3 & llr >= 2 ~ "Strong support for Hp",
                                     llr < 2 & llr >= 1 ~ "Moderate support for Hp",
                                     llr < 1 & llr > 0 ~ "Weak support for Hp",
                                     llr == 0 ~ "Hp as likely as Hd",
                                     llr < 0 & llr >= -1 ~ "Weak support for Hd",
                                     llr < -1 & llr >= -2 ~ "Moderate support for Hd",
                                     llr < -2 & llr >= -3 ~ "Strong support for Hd",
                                     llr < -3 & llr >= -4 ~ "Very strong support for Hd",
                                     llr < -4 ~ "Extremely strong support for Hd"),
           Intepretation = dplyr::case_when(llr > 0 ~ paste("The similarity is", round(10^llr, 2), "times more likely to be observed in the case of Hp than in the case of Hd"),
                                            llr == 0 ~ "Hp is as likely as Hd",
                                            llr < 0 ~ paste("The similarity is", round(10^abs(llr), 2), "times more likely to be observed in the case of Hd than in the case of Hp"))) -> newdata

  dplyr::tibble(prosecution_prior_probs = seq(0.1, 0.9, 0.1),) |>
    dplyr::mutate(prior_odds = prosecution_prior_probs/(1-prosecution_prior_probs)) |>
    dplyr::mutate(LLR = as.numeric(newdata$llr)) |>
    dplyr::mutate(LR = 10^LLR) |>
    dplyr::mutate(post_odds = LR*prior_odds) |>
    dplyr::mutate(prosecution_post_probs = post_odds/(1+post_odds)) -> post.table

  result.list = list(calibrated.data = newdata, post.odds.table = post.table)

  return(result.list)

}
