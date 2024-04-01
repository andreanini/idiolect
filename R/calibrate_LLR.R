#' Calibrate scores into Log-Likelihood Ratios
#'
#' This function is used to transform the scores returned by any of the authorship analysis functions into a Log-Likelihood Ratio (LLR).
#'
#' @param calibration.dataset A data frame containing the calibration data, typically the output of an authorship analysis function like [impostors()].
#' @param dataset A data frame containing the scores that have to be calibrated into LLRs using the calibration data. This is typically the result of applying a function like [impostors()] to the Q texts.
#' @references Marquis, Raymond, Alex Biedermann, Liv Cadola, Christophe Champod, Line Gueissaz, Geneviève Massonnet, Williams David Mazzella, Franco Taroni & Tacha Hicks. 2016. Discussion on how to implement a verbal scale in a forensic laboratory: Benefits, pitfalls and suggestions to avoid misunderstandings. Science & Justice 56(5). 364–370. https://doi.org/10.1016/j.scijus.2016.05.009.
#'
#' @return The function returns a data frame with the LLRs, as well as the verbal label according to Marquis et al (2016) and a verbal interpretation of the results.
#'
#'@examples
#'calib <- data.frame(score = c(0.5, 0.2, 0.8, 0.01, 0.6), target = c(TRUE, FALSE, TRUE, FALSE, TRUE))
#'q <- data.frame(score = c(0.6, 0.002))
#'calibrate_LLR(calib, q)
#'
#' @export
calibrate_LLR = function(calibration.dataset, dataset){

  llr.table <- data.frame()

  suppressWarnings(ROC::train.logreg(calibration.dataset) -> calibration.model)

  LLR <- stats::predict(calibration.model, newdata = dataset)/log(10)

  dataset |>
    dplyr::mutate(LLR = round(LLR, 3),
      `Verbal label` = dplyr::case_when(LLR > 4 ~ "Extremely strong support for $H_p$",
                                     LLR <= 4 & LLR >= 3 ~ "Very strong support for $H_p$",
                                     LLR < 3 & LLR >= 2 ~ "Strong support for $H_p$",
                                     LLR < 2 & LLR >= 1 ~ "Moderate support for $H_p$",
                                     LLR < 1 & LLR > 0 ~ "Weak support for $H_p$",
                                     LLR == 0 ~ "$H_p$ as likely as $H_d$",
                                     LLR < 0 & LLR >= -1 ~ "Weak support for $H_d$",
                                     LLR < -1 & LLR >= -2 ~ "Moderate support for $H_d$",
                                     LLR < -2 & LLR >= -3 ~ "Strong support for $H_d$",
                                     LLR < -3 & LLR >= -4 ~ "Very strong support for $H_d$",
                                     LLR < -4 ~ "Extremely strong support for $H_d$"),
           Interpretation = dplyr::case_when(LLR > 0 ~ paste("The similarity is", round(10^LLR, 2), "times more likely to be observed in the case of $H_p$ than in the case of $H_d$"),
                                            LLR == 0 ~ "$H_p$ is as likely as $H_d$",
                                            LLR < 0 ~ paste("The similarity is", round(10^abs(LLR), 2), "times more likely to be observed in the case of $H_d$ than in the case of $H_p$"))) -> newdata

  return(newdata)

}
