#' Qualitative examination of evidence
#'
#' This function uses [quanteda::kwic()] to return a concordance for a search pattern. The function takes as input three datasets and a pattern and returns a data frame with the hits labelled for authorship.
#'
#' @param q.data A `quanteda` corpus object, such as the output of [create_corpus()], or a tokens object with tokens being sentences, such as the output of [tokenize_sents()].
#' @param k.data A `quanteda` corpus object, such as the output of [create_corpus()], or a tokens object with tokens being sentences, such as the output of [tokenize_sents()].
#' @param reference.data A `quanteda` corpus object, such as the output of [create_corpus()], or a tokens object with tokens being sentences, such as the output of [tokenize_sents()]. This is optional.
#' @param search A string. It can be any sequence of characters and it also accepts the use of * as a wildcard. The special tokens for sentence boundaries are '_BOS_' for beginning of sentence and '_EOS_' for end of sentence.
#' @param token.type Choice between "word" (default), which searches for word or punctuation mark tokens, or "character", which instead uses a single character search.
#' @param window The number of context items to be displayed around the keyword (a [quanteda::kwic()] parameter).
#' @param case_insensitive Logical; if TRUE, ignore case (a [quanteda::kwic()] parameter).
#'
#' @return The function returns a data frame containing the concordances for the search pattern.
#'
#' @examples
#' concordance(enron.sample[1], enron.sample[2], enron.sample[3], "wants to", token.type = "word")
#'
#' #using wildcards
#' concordance(enron.sample[1], enron.sample[2], enron.sample[3], "wants * be", token.type = "word")
#'
#' #searching character sequences with wildcards
#' concordance(enron.sample[1], enron.sample[2], enron.sample[3], "help*", token.type = "character")
#'
#' #using sentences
#' enron.sents <- tokens(enron.sample, "sentence")
#' concordance(enron.sents[1], enron.sents[2], enron.sents[3], ". _EOS_", token.type = "word")
#'
#' @export
concordance <- function(q.data, k.data, reference.data, search, token.type = "word", window = 5, case_insensitive = TRUE){

  # this condition is needed to make reference.data optional
  if(missing(reference.data)){

    reference.data <- quanteda::corpus("")

  }

  q.data <- corpus_transform(q.data)
  k.data <- corpus_transform(k.data)
  reference.data <- corpus_transform(reference.data)

  if(token.type == "word"){

    kw <- quanteda::tokens(search, what = token.type)

    q.data |>
      quanteda::tokens(what = token.type) |>
      quanteda::kwic(quanteda::as.phrase(kw), window = window, case_insensitive = case_insensitive) |>
      as.data.frame() |>
      dplyr::select(-pattern) |>
      dplyr::mutate(authorship = "Q") -> q.kwic

    k.data |>
      quanteda::tokens(what = token.type) |>
      quanteda::kwic(quanteda::as.phrase(kw), window = window, case_insensitive = case_insensitive) |>
      as.data.frame() |>
      dplyr::select(-pattern) |>
      dplyr::mutate(authorship = "K") -> k.kwic

    reference.data |>
      quanteda::tokens(what = token.type) |>
      quanteda::kwic(quanteda::as.phrase(kw), window = window, case_insensitive = case_insensitive) |>
      as.data.frame() |>
      dplyr::select(-pattern) |>
      dplyr::mutate(authorship = "Reference") -> r.kwic

  }else if(token.type == "character"){

    kw <- quanteda::tokens(search, what = token.type, remove_separators = FALSE)

    q.data |>
      quanteda::tokens(what = token.type, remove_separators = FALSE) |>
      quanteda::kwic(quanteda::as.phrase(kw), window = window, case_insensitive = case_insensitive,
                     separator = "") |>
      as.data.frame() |>
      dplyr::select(-pattern) |>
      dplyr::mutate(authorship = "Q") -> q.kwic

    k.data |>
      quanteda::tokens(what = token.type, remove_separators = FALSE) |>
      quanteda::kwic(quanteda::as.phrase(kw), window = window, case_insensitive = case_insensitive,
                     separator = "") |>
      as.data.frame() |>
      dplyr::select(-pattern) |>
      dplyr::mutate(authorship = "K") -> k.kwic

    reference.data |>
      quanteda::tokens(what = token.type, remove_separators = FALSE) |>
      quanteda::kwic(quanteda::as.phrase(kw), window = window, case_insensitive = case_insensitive,
                     separator = "") |>
      as.data.frame() |>
      dplyr::select(-pattern) |>
      dplyr::mutate(authorship = "Reference") -> r.kwic

  }

  output <- rbind(q.kwic, k.kwic) |> rbind(r.kwic) |> dplyr::rename(node = keyword)

  return(output)

}

#this function returns a corpus if the object is already corpus or otherwise it combines the tokens (assumed to be sentences) back to a corpus after adding sentence boundaries
corpus_transform <- function(x){

  if(quanteda::is.corpus(x)){

    y <- x

  }else{

    y <- detokenize(x, sentence.boundaries = TRUE)

  }

  return(y)

}

