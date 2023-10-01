#' Chunk a corpus
#'
#'This function can be used to chunk a corpus in order to control sample sizes.
#'
#' @param corpus This is a `quanteda` corpus.
#' @param size The size of the chunks in number of tokens.
#'
#' @return A `quanteda` corpus object where each text is a chunk of the size requested.
#' @export
#'
#' @examples
#' corpus <- quanteda::corpus(c("The cat sat on the mat", "The dog sat on the chair"))
#' quanteda::docvars(corpus, "author") <- c("A", "B")
#' chunk_texts(corpus, size = 2)
chunk_texts <- function(corpus, size){

  tok <- quanteda::tokens(corpus)

  tok2 <- quanteda::tokens_chunk(tok, size)

  tok3 <- quanteda::tokens_subset(tok2, quanteda::ntoken(tok2) == size)

  output <- detokenize(tok3)

  return(output)

}
