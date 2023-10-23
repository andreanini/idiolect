#' Calibrate scores into Log-Likelihood Ratios
#'
#' This function is used to transform the scores returned by a verification function into a Log-Likelihood Ratio (LLR).
#'
#' More details here.
#'
#' @param calibration.dataset A data frame containing the calibration data, typically the output of an authorship analysis function like [impostors()].
#' @param dataset A data frame containing the scores that will be calibrated into LLRs using the calibration data. This is typically the result of applying a function like [impostors()] to the Q texts.
#'
#' @return The function returns a data frame with the LLRs, as well as the verbal label according to Marquis et al (2016) and a verbal interpretation of the results.
#' @export
#'
#' @examples
#'calib <- data.frame(score = c(0.5, 0.2, 0.8, 0.01, 0.6), target = c(TRUE, FALSE, TRUE, FALSE, TRUE))
#'q <- data.frame(score = c(0.6, 0.002))
#'calibrate_LLR(calib, q)
calibrate_LLR = function(calibration.dataset, dataset){

  llr.table <- data.frame()

  suppressWarnings(ROC::train.logreg(calibration.dataset) -> calibration.model)

  LLR <- stats::predict(calibration.model, newdata = dataset)/log(10)

  dataset |>
    dplyr::mutate(llr = LLR,
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

  return(newdata)

}
