#' Qualitative examination of evidence
#'
#' This function uses [quanteda::kwic()] to return a concordance for a search pattern. The function takes as input three data sets and a pattern and returns a final data frame with the hits labelled for authorship.
#'
#' @param q.data A `quanteda` corpus object, such as the output of [create_corpus()].
#' @param k.data A `quanteda` corpus object, such as the output of [create_corpus()].
#' @param reference.data A `quanteda` corpus object, such as the output of [create_corpus()]. This is optional.
#' @param search A string. It can be any sequence of characters and it also accepts the use of * as a wildcard.
#' @param token.type Choice between "word" (default), which searches for word or punctuation mark tokens, or "character", which instead uses a single character search.
#' @param window The number of context words to be displayed around the keyword ([quanteda::kwic()] parameter).
#' @param case_insensitive Logical; if TRUE, ignore case ([quanteda::kwic()] parameter).
#'
#' @return The function returns a data frame containing the concordances for the search pattern.
#' @export
#'
#' @examples
#' concordance(enron.sample[1], enron.sample[2], enron.sample[3:49], "wants to", token.type = "word")
#'
#' #using wildcards
#' concordance(enron.sample[1], enron.sample[2], enron.sample[3:49], "want * to", token.type = "word")
#'
#' #searching character sequences with wildcards
#' concordance(enron.sample[1], enron.sample[2], enron.sample[3:49], "help*", token.type = "character")
#'
concordance <- function(q.data, k.data, reference.data, search, token.type = "word", window = 5, case_insensitive = T){

  # this condition is needed to make reference.data optional
  if(missing(reference.data)){

    reference.data <- quanteda::corpus("")

  }

  if(!quanteda::is.corpus(q.data) | !quanteda::is.corpus(k.data) | !quanteda::is.corpus(reference.data)){

    stop("All inputs must be quanteda corpus objects.")

  }

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

    kw <- quanteda::tokens(search, what = token.type, remove_separators = F)

    q.data |>
      quanteda::tokens(what = token.type, remove_separators = F) |>
      quanteda::kwic(quanteda::as.phrase(kw), window = window, case_insensitive = case_insensitive,
                     separator = "") |>
      as.data.frame() |>
      dplyr::select(-pattern) |>
      dplyr::mutate(authorship = "Q") -> q.kwic

    k.data |>
      quanteda::tokens(what = token.type, remove_separators = F) |>
      quanteda::kwic(quanteda::as.phrase(kw), window = window, case_insensitive = case_insensitive,
                     separator = "") |>
      as.data.frame() |>
      dplyr::select(-pattern) |>
      dplyr::mutate(authorship = "K") -> k.kwic

    reference.data |>
      quanteda::tokens(what = token.type, remove_separators = F) |>
      quanteda::kwic(quanteda::as.phrase(kw), window = window, case_insensitive = case_insensitive,
                     separator = "") |>
      as.data.frame() |>
      dplyr::select(-pattern) |>
      dplyr::mutate(authorship = "Reference") -> r.kwic

  }

  output <- rbind(q.kwic, k.kwic) |> rbind(r.kwic) |> dplyr::rename(node = keyword)

  return(output)

}
