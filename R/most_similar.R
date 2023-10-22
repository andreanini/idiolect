#' Select most similar texts to a specific text
#'
#' @param sample This is a single row of a `quanteda` dfm representing the sample to match.
#' @param pool This is a dfm containing all possible samples from which to select the top n.
#' @param n The number of rows to extract from the pool of potential samples.
#' @param measure The measure to use for similarity. Either "minmax" or "Phi".
#'
#' @return The function returns a dfm containing the top n most similar rows to the input sample using the minmax distance.
#' @export
#'
#' @examples
#' text1 <- "The cat sat on the mat"
#' text2 <- "The dog sat on the chair"
#' text3 <- "Violence is the last refuge of the incompetent"
#' c <- quanteda::corpus(c(text1, text2, text3))
#' d <- quanteda::tokens(c) |> quanteda::dfm() |> quanteda::dfm_weight(scheme = "prop")
#' most_similar(d[1,], d[-1,], measure = "minmax", n = 1)
most_similar <- function(sample, pool, measure, n){

  if(nrow(sample) > 1){

    stop("Multiple samples in the most_similar function. Only one sample is allowed\n")

  }

  if(measure == "minmax"){

    ranking = minmax(pool, sample)

  }

  if(measure == "Phi"){

    ranking = phi(pool, sample)

  }

  imp.list = names(ranking[1:n])
  imps = quanteda::dfm_subset(pool, quanteda::docnames(pool) %in% imp.list)

  return(imps)

}
