#' Posterior prosecution probabilities/odds
#'
#' This function takes as input a value of the Log-Likelihood Ratio and returns a table that shows the impact on some simulated prior probabilities (for the prosecution hypothesis).
#'
#' @param LLR One single numeric value corresponding to the Log-Likelihood Ratio.
#'
#' @return A data frame containing some simulated prior probabilities/odds for the prosecution and the resulting posterior probabilities/odds after the LLR. The first row/scenario is a prior of 0.000001, where the denominator roughly corresponds to the population of Manchester.
#' @export
#'
#' @examples
#' posterior(LLR = 0)
#' posterior(LLR = 1.8)
#' posterior(LLR = -0.5)
#' posterior(LLR = 4)
posterior <- function(LLR){

  dplyr::tibble(prosecution_prior_probs = c(0.000001, 0.01, seq(0.1, 0.9, 0.1))) |>
    dplyr::mutate(prior_odds = prosecution_prior_probs/(1-prosecution_prior_probs)) |>
    dplyr::mutate(LLR = LLR) |>
    dplyr::mutate(LR = 10^LLR) |>
    dplyr::mutate(post_odds = LR*prior_odds) |>
    dplyr::mutate(prosecution_post_probs = post_odds/(1+post_odds)) -> post.table

  return(post.table)

}
