#' Vectorize data
#'
#' This function turns the texts into n-gram vectors.
#'
#' All the authorship analysis functions call vectorize() with the standard parameters for the algorithm selected. This function is therefore left only for users who want to modify these parameters or for convenience if the same dfm has to be reused by the algorithms to avoid vectorizing the same data many times. Most users who only need to run a standard analysis do not need use this function.
#'
#' @param input This should be a `quanteda` corpus object with the author names as a docvar called "author". Typically, this is the output of the [create_corpus()] function.
#' @param tokens The type of tokens to extract, either "character" or "word".
#' @param remove_punct A logical value. FALSE to keep the punctuation marks or TRUE to remove them.
#' @param remove_symbols A logical value. TRUE removes symbols and FALSE keeps them.
#' @param remove_numbers A logical value. TRUE removes numbers and FALSE keeps them.
#' @param lowercase A logical value. TRUE transforms all tokens to lower case.
#' @param n The order or size of the n-grams being extracted.
#' @param weighting The type of weighting to use, "rel" for relative frequencies, "tf-idf", or "boolean".
#' @param trim A logical value. If TRUE then only the most frequent tokens are kept.
#' @param threshold A numeric value indicating how many most frequent tokens to keep.
#'
#' @return A dfm (document-feature matrix) containing each text as a feature vector. N-gram tokenisation does not cross sentence boundaries.
#' @export
#'
#' @examples
#' mycorpus <- quanteda::corpus("The cat sat on the mat.")
#' quanteda::docvars(mycorpus, "author") <- "author1"
#' matrix <- vectorize(mycorpus, tokens = "character", remove_punct = FALSE, remove_symbols = TRUE,
#' remove_numbers = TRUE, lowercase = TRUE, n = 5, weighting = "rel", trim = TRUE, threshold = 1500)
vectorize = function(input, tokens, remove_punct, remove_symbols, remove_numbers, lowercase, n, weighting, trim, threshold){

  sents <- quanteda::corpus_segment(input, pattern = "[.?!]+( \\n+)*|\\n+", valuetype = "regex",
                                    extract_pattern = F, pattern_position = "after")

  if(tokens == "character"){

    sents |>
      quanteda::tokens(what = tokens, remove_punct = remove_punct, remove_symbols = remove_symbols,
                       remove_url = T, remove_numbers = remove_numbers, split_hyphens = T,
                       remove_separators = F) |>
      quanteda::tokens_ngrams(n, concatenator = "") -> toks

  }

  if(tokens == "word"){

    sents |>
      quanteda::tokens(what = tokens, remove_punct = remove_punct, remove_symbols = remove_symbols,
                       remove_url = T, remove_numbers = remove_numbers, split_hyphens = T,
                       remove_separators = T) |>
      quanteda::tokens_ngrams(n, concatenator = "_") -> toks

  }

  d <- quanteda::tokens_group(toks) |>
    quanteda::dfm(tolower = lowercase)

  if(weighting == "tf-idf"){

    d.f = quanteda::dfm_tfidf(d, scheme_tf = "prop")

  }

  if(weighting == "rel"){

    d.f = quanteda::dfm_weight(d, scheme = "prop")

  }

  if(weighting == "boolean"){

    d.f = quanteda::dfm_weight(d, scheme = "boolean")

  }

  if(trim == T){

    d.f = quanteda::dfm_trim(d.f, min_termfreq = threshold, termfreq_type = "rank") |> suppressWarnings()

  }

  return(d.f)

}
