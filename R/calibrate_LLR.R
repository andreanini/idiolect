#' Calibrate scores into Log-Likelihood Ratios
#'
#' This function is used to transform the scores returned by any of the authorship analysis functions into a Log-Likelihood Ratio (LLR) using the logistic regression calibration method.
#'
#' @param dataset A data frame containing the scores that have to be calibrated into LLRs. This is typically the result of applying a function like [impostors()] to the Q texts.
#' @param calibration.dataset A data frame containing the calibration dataset, typically the output of an authorship analysis function like [impostors()]. If absent, then the dataset is calibrated using leave-one-out.
#' @param latex A logical value. If FALSE (default), then the hypothesis labels are printed as plain text (Hp/Hd). If TRUE the labels are written to be read in LaTeX ($H_p$/$H_d$).
#'
#' @references Marquis, Raymond, Alex Biedermann, Liv Cadola, Christophe Champod, Line Gueissaz, Geneviève Massonnet, Williams David Mazzella, Franco Taroni & Tacha Hicks. 2016. Discussion on how to implement a verbal scale in a forensic laboratory: Benefits, pitfalls and suggestions to avoid misunderstandings. Science & Justice 56(5). 364–370. https://doi.org/10.1016/j.scijus.2016.05.009.
#'
#' @return The function returns a data frame with the LLRs (base 10), as well as the verbal label according to Marquis et al (2016) and a verbal interpretation of the results.
#'
#' @examples
#' calib <- data.frame(score = c(0.5, 0.2, 0.8, 0.01, 0.6), target = c(TRUE, FALSE, TRUE, FALSE, TRUE))
#' q <- data.frame(score = c(0.6, 0.002))
#' calibrate_LLR(q, calib)
#'
#' calibrate_LLR(calib)
#'
#' @export
calibrate_LLR <- function(dataset, calibration.dataset = NULL, latex = FALSE) {
  if (is.null(calibration.dataset)) {
    final.llr <- data.frame()
    for (i in 1:nrow(dataset)) {
      left <- dataset[i, ]
      rest <- dataset[-i, ]
      suppressWarnings(calibration.model <- train.logreg(rest))
      final.llr[i, "LLR"] <- stats::predict(calibration.model, newdata = left) / log(10)
    }
    newdata <- cbind(dataset, final.llr) |>
      add_interpretations(latex)
  } else {
    suppressWarnings(calibration.model <- train.logreg(calibration.dataset))
    LLR <- stats::predict(calibration.model, newdata = dataset) / log(10)
    newdata <- dataset |>
      dplyr::mutate(LLR = LLR) |>
      add_interpretations(latex)
  }
  return(newdata)
}

add_interpretations <- function(table, latex){
  if (latex == TRUE) {
    hp <- "$H_p$"
    hd <- "$H_d$"
  } else {
    hp <- "Hp"
    hd <- "Hd"
  }
  newtable <- table |>
    dplyr::mutate(
      LLR = round(LLR, 3),
      `Verbal label` = dplyr::case_when(
        LLR > 4 ~ paste0("Extremely strong support for ", hp),
        LLR <= 4 & LLR >= 3 ~ paste0("Very strong support for ", hp),
        LLR < 3 & LLR >= 2 ~ paste0("Strong support for ", hp),
        LLR < 2 & LLR >= 1 ~ paste0("Moderate support for ", hp),
        LLR < 1 & LLR > 0 ~ paste0("Weak support for ", hp),
        LLR == 0 ~ paste0(hp, " as likely as ", hd),
        LLR < 0 & LLR >= -1 ~ paste0("Weak support for ", hd),
        LLR < -1 & LLR >= -2 ~ paste0("Moderate support for ", hd),
        LLR < -2 & LLR >= -3 ~ paste0("Strong support for ", hd),
        LLR < -3 & LLR >= -4 ~ paste0("Very strong support for ", hd),
        LLR < -4 ~ paste0("Extremely strong support for ", hd)
      ),
      Interpretation = dplyr::case_when(
        LLR > 0 ~ paste(
          "The similarity is",
          round(10^LLR, 2),
          "times more likely to be observed in the case of",
          hp,
          "than in the case of",
          hd
        ),
        LLR == 0 ~ paste0(hp, " is as likely as ", hd),
        LLR < 0 ~ paste(
          "The similarity is",
          round(10^abs(LLR), 2),
          "times more likely to be observed in the case of",
          hd,
          "than in the case of",
          hp
        )
      )
    )
  return(newtable)
}
