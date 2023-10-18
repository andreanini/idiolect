minmax_overlap <- function(m1, m2){

  m <- rbind(m1, m2)

  mins <- apply(m, 2, min)
  maxs <- apply(m, 2, max)

  ratios <- mins/maxs

  return(ratios)

}
#' Important features
#'
#' This function shows the most important features used by any of the impostors algorithms that adopt the minmax distance.
#'
#' @param q This is one `quanteda` dfm row corresponding to the Q text.
#' @param candidate This is the `quanteda` dfm corresponding to the candidate text(s).
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

  important.features = c()

  for(i in 1:nrow(candidate)){

    cand.overlap <- minmax_overlap(q, candidate[i,])

    imp.means <- quanteda::colMeans(impostors)
    imp.matrix <- quanteda::as.dfm(t(as.matrix(imp.means)))

    imp.overlap <- minmax_overlap(q, imp.matrix)

    odds <- cand.overlap/imp.overlap

    temp <- odds[is.na(odds) == F & odds != 0]

    important.features <- c(important.features, temp)

  }

  final.features <- sort(important.features, decreasing = T)

  return(final.features)

}
