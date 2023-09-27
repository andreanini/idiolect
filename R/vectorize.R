#' Vectorize data
#'
#' This function turns the texts into n-gram vectors.
#'
#' More information about the literature will go here.
#'
#' @param input This should be a `quanteda` corpus object with the author names as a docvar called "author".
#' @param tokens The type of tokens to extract, either "character" (default) or "word".
#' @param remove_punct A logical value. FALSE (default) keeps punctuation marks.
#' @param remove_symbols A logical value. TRUE (default) removes symbols.
#' @param remove_numbers A logical value. TRUE (default) removes numbers
#' @param lowercase A logical value. TRUE (default) transforms all tokens to lower case.
#' @param n The order or size of the n-grams being extracted. Default is 5.
#' @param weighting The type of weighting to use, "rel" for relative frequencies, "tf-idf", or "boolean".
#' @param trim A logical value. If TRUE (default) then only the most frequent tokens are kept.
#' @param threshold A numeric value indicating how many most frequent tokens to keep. The default is 1500.
#'
#' @return A dfm (document-feature matrix) containing each text as a feature vector. N-gram tokenisation does not cross sentence boundaries.
#' @export
#'
#' @examples
#' mycorpus <- quanteda::corpus("The cat sat on the mat.")
#' quanteda::docvars(mycorpus, "author") <- "author1"
#' matrix <- vectorize(mycorpus)
vectorize = function(input, tokens = "character", remove_punct = F, remove_symbols = T, remove_numbers = T, lowercase = T, n = 5, weighting = "rel", trim = T, threshold = 1500){

  sents <- quanteda::corpus_reshape(input, to = "sentences")

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

  d <- quanteda::tokens_group(toks) |> quanteda::dfm(tolower = lowercase)

  if(trim == T){

    d = quanteda::dfm_trim(d, min_termfreq = threshold, termfreq_type = "rank")

  }

  if(weighting == "tf-idf"){

    d.f = quanteda::dfm_tfidf(d, scheme_tf = "prop")

  }

  if(weighting == "rel"){

    d.f = quanteda::dfm_weight(d, scheme = "prop")

  }

  if(weighting == "boolean"){

    d.f = quanteda::dfm_weight(d, scheme = "boolean")

  }

  return(d.f)

}
