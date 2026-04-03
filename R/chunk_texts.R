#' Chunk a dataset
#'
#' This function can be used to chunk a dataset in order to control sample sizes.
#'
#' @param input A `quanteda` corpus object, typically the output of the [create_corpus()] function, or a `quanteda` tokens object where each token is a sentence (the output of [tokenize_sents()]).
#' @param size The size of the chunks in number of tokens.
#'
#' @return Either a `quanteda` corpus object or a `quanteda` tokens object containing sentences, depending on the input, where each text is a chunk of the size requested. If the input was a corpus object, then the function divides each unit of the corpus in chunks of the length specified. If the input was a tokens object then the function combines sentences together until the chunk is equal or greater than the size specified.
#'
#' @examples
#' corpus <- quanteda::corpus(c("The cat sat on the mat", "The dog sat on the chair"))
#' quanteda::docvars(corpus, "author") <- c("A", "B")
#' chunk_texts(corpus, size = 2)
#'
#' sentences <- quanteda::tokens(corpus, "sentence")
#' chunk_texts(sentences, size = 6)
#' chunk_texts(sentences, size = 2)
#' try(chunk_texts(sentences, size = 7))
#'
#' @export
chunk_texts <- function(input, size) {
  if (quanteda::is.corpus(input) == TRUE) {
    tok <- quanteda::tokens(input, what = "fastestword")
    tok2 <- quanteda::tokens_chunk(tok, size)
    tok3 <- quanteda::tokens_subset(tok2, quanteda::ntoken(tok2) == size)
    output <- detokenize(tok3)
  } else if (quanteda::is.tokens(input) == TRUE) {
    for (q in 1:ndoc(input)) {
      text <- input[q]
      all.sents <- unlist(text, use.names = FALSE)
      all.tokens <- unlist(text, use.names = FALSE) |>
        quanteda::tokens() |>
        quanteda::ntoken()
      names(all.tokens) <- 1:length(all.tokens)
      samples <- list()
      j <- 1
      while (j <= length(all.tokens)) {
        selected.samples <- c()
        for (i in j:length(all.tokens)) {
          j <- i + 1
          selected.samples <- c(selected.samples, all.tokens[i])
          if (sum(selected.samples) >= size) {
            samples[[length(samples) + 1]] <- all.sents[
              names(all.tokens) %in% names(selected.samples)
            ]
            selected.samples <- c()
          }
        }
      }
      if (length(samples) == 0) {
        stop("No chunks of the size specified are available")
      }
      samples.toks <- as.tokens(samples)
      docnames(samples.toks) <- paste0(docnames(text), ".", 1:length(samples.toks))
      dv <- docvars(text)
      for (z in 1:length(dv)) {
        docvars(samples.toks, names(dv[z])) <- dv[[z]]
      }
      if (q == 1) {
        output <- samples.toks
      } else {
        output <- output + samples.toks
      }
    }
  }
  return(output)
}
