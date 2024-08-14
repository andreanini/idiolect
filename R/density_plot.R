#' Plot density of TRUE/FALSE distributions
#'
#' @param dataset A data frame containing the calibration dataset, typically the output of an authorship analysis function like [impostors()].
#' @param q This optional argument should be one value or a vector of values that contain the score of the disputed text(s). These are then plotted as lines crossing the density distributions.
#'
#' @return A `ggplot2` plot with the density distributions for the scores for TRUE (typically, 'same-author') vs. FALSE (typically, 'different-author').
#'
#' @examples
#' res <- data.frame(score = c(0.5, 0.2, 0.8, 0.01, 0.6), target = c(TRUE, FALSE, TRUE, FALSE, TRUE))
#' q <- c(0.11, 0.7)
#' density_plot(res, q)
#'
#' @export
density_plot <- function(dataset, q = NULL){

  dataset |>
    ggplot2::ggplot() +
    ggplot2::aes(x = score, color = target, fill = target) +
    ggplot2::geom_density(alpha = 0.1) +
    ggplot2::theme_bw() +
    ggplot2::labs(fill = "Condition", color = "Condition") -> plot

  if(!is.null(q)){

    plot +
      ggplot2::geom_vline(xintercept = q, linetype = "solid") -> plot

  }

  return(plot)

}
