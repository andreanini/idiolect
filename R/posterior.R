#' Posterior prosecution probabilities and odds
#'
#' This function takes as input a value of the Log-Likelihood Ratio and returns a table that shows the impact on some simulated prior probabilities for the prosecution hypothesis.
#'
#' @param LLR One single numeric value corresponding to a Log-Likelihood Ratio (base 10).
#' @param prior A prior probability or a vector or prior probabilities (for the prosecution hypothesis). If missing then a range of prior probabilities is provided.
#'
#' @return A data frame containing some simulated prior probabilities/odds for the prosecution and the resulting posterior probabilities/odds after the LLR.
#'
#' @examples
#' posterior(LLR = 0)
#' posterior(LLR = 1.8)
#' posterior(LLR = -0.5, prior = 0.9)
#' posterior(LLR = -0.5, prior = c(0.1, 0.9))
#'
#' @export
posterior <- function(LLR, prior = NULL) {
  if (is.null(prior)) {
    prior <- c(0.000001, 0.01, seq(0.1, 0.9, 0.1))
  }

  dplyr::tibble(prosecution_prior_probs = prior) |>
    dplyr::mutate(prior_odds = prosecution_prior_probs / (1 - prosecution_prior_probs)) |>
    dplyr::mutate(LLR = LLR) |>
    dplyr::mutate(LR = 10^LLR) |>
    dplyr::mutate(post_odds = LR * prior_odds) |>
    dplyr::mutate(prosecution_post_probs = post_odds / (1 + post_odds)) -> post.table

  return(post.table)
}
