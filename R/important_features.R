overlap <- function(m1, m2){

  m <- rbind(m1, m2)

  features <- apply(m, 2, min) |> sort(decreasing = T)

  overlap <- names(features[features > 0])

  return(overlap)

}
#' Important features
#'
#' This function shows the most important features used by any of the impostors algorithms that adopt the minmax distance.
#'
#' @param q This is one `quanteda` dfm row corresponding to the Q text.
#' @param candidate This is one `quanteda` dfm row corresponding to the candidate text(s).
#' @param impostors This is the `quanteda` dfm with the impostors' data.
#'
#' @return One named vector of features that belong to the overlap between the Q text and the candidate containing the ratio between candidate and impostors
#' @export
#'
#' @examples
#' q <- "aaabbc"
#' candidate <- "aaaaaaaabbbbccc"
#' impostor <- "abbccccccccccczzzz"
#' corpus <- quanteda::corpus(c(q, candidate, impostor))
#' d <- vectorize(corpus, n = 1)
#' important_features(d[1,], d[2,], d[3,])
important_features <- function(q, candidate, impostors){

  if(nrow(candidate) > 1){

    stop("The important_features function only accepts one row for the candidate author.")

  }

  int <- overlap(q, candidate)

  imp.means.full <- quanteda::colMeans(impostors)
  imp.means <- imp.means.full[names(imp.means.full) %in% int]
  imp.matrix <- quanteda::as.dfm(t(as.matrix(imp.means)))

  overlap.matrix <- quanteda::dfm_match(candidate, int)

  full.matrix <- rbind(overlap.matrix, imp.matrix)

  ratio <- quanteda::as.dfm(full.matrix[1,]/full.matrix[2,])

  important.features <- quanteda::topfeatures(ratio, n = ncol(ratio))

  return(important.features)

}
