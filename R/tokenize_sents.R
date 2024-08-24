#' Tokenize to sentences
#'
#' This function turns a corpus of texts into a `quanteda` tokens object of sentences.
#'
#' The function first split each text into paragraphs by splitting at new line markers and then uses spacy to tokenize each paragraph into sentences. The function accepts a plain text corpus input or the output of [contentmask()]. This function is necessary to prepare the data for [lambdaG()].
#'
#' @param corpus A `quanteda` corpus object, typically the output of the [create_corpus()] function or the output of [contentmask()].
#' @param model The spacy model to use. The default is "en_core_web_sm".
#'
#' @return A `quanteda` tokens object where each token is a sentence.
#'
#' @examples
#' \dontrun{
#' toy.pos <- corpus("the N was on the N . he did n't move \n N ; \n N N")
#' tokenize_sents(toy.pos)
#' }
#'
#' @export
tokenize_sents <- function(corpus, model = "en_core_web_sm"){

  meta <- quanteda::docvars(corpus)
  names <- quanteda::docnames(corpus)

  sapply(corpus, stringr::str_replace_all, "\n", "\n\n") |>
    quanteda::corpus() |>
    quanteda::corpus_reshape(to = "paragraphs", use_docvars = TRUE) -> x.pars

  spacyr::spacy_initialize(model = model, entity = FALSE)
  x.pars |>
    spacyr::spacy_tokenize("sentence") |>
    quanteda::as.tokens() -> x.toks
  spacyr::spacy_finalize()

  docvars(x.toks, "original_docid") <- docid(x.pars)

  final.x.toks <- tokens_group(x.toks, original_docid)

  quanteda::docvars(final.x.toks) <- meta
  quanteda::docnames(final.x.toks) <- names

  return(final.x.toks)

}
