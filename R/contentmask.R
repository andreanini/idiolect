#' Content masking
#'
#' This function offers two algorithms for topic/content masking. See Details below.
#'
#' References to algorithms to appear here.
#'
#' @param corpus A `quanteda` corpus object, typically the output of the [create_corpus()] function.
#' @param algorithm A string, either "POSnoise" (default) or "frames".
#'
#' @return A `quanteda` corpus object only containing functional tokens, depending on the algorithm chosen. The corpus contains the same docvars as the input.
#' @export
#'
#' @examples
#' text <- "The elegant cat was forcefully put on the chair."
#' toy.corpus <- quanteda::corpus(text)
#' contentmask(toy.corpus, algorithm = "POSnoise")
contentmask <- function(corpus, algorithm = "POSnoise"){

  meta <- quanteda::docvars(corpus)

  spacyr::spacy_initialize()
  parsed.corpus <- spacyr::spacy_parse(corpus, lemma = F, entity = F)
  spacyr::spacy_finalize()

  if(algorithm == "POSnoise"){

    content <- c("N", "P", "V", "J", "B", "D", "S")

    parsed.corpus |>
      dplyr::mutate(token = tolower(token)) |>
      dplyr::mutate(pos = dplyr::case_when(pos == "NOUN" ~ "N",
                                           pos == "PROPN" ~ "P",
                                           pos == "VERB" ~ "V",
                                           pos == "ADJ" ~ "J",
                                           pos == "ADV" ~ "B",
                                           pos == "NUM" ~ "D",
                                           pos == "SYM" ~ "S",
                                           TRUE ~ pos)) |>
      dplyr::mutate(POSnoise = dplyr::case_when(token %in% halvani ~ token,
                                                !(pos %in% content) ~ token,
                                                pos == "SPACE" ~ token,
                                                TRUE ~ pos)) |>
      dplyr::select(doc_id, POSnoise) |>
      dplyr::rename(token = POSnoise) |>
      quanteda::as.tokens() -> x.pos

    x.corp <- sapply(x.pos, function(x) { paste(x, collapse = " ") }) |> quanteda::corpus()

  }

  if(algorithm == "framenoise"){

    content <- c("N", "P", "V", "D", "S")

    parsed.corpus |>
      dplyr::mutate(token = tolower(token)) |>
      dplyr::mutate(pos = dplyr::case_when(pos == "NOUN" ~ "N",
                                           pos == "PROPN" ~ "P",
                                           pos == "VERB" ~ "V",
                                           pos == "NUM" ~ "D",
                                           pos == "SYM" ~ "S",
                                           TRUE ~ pos)) |>
      dplyr::mutate(POSnoise = dplyr::case_when(pos %in% content ~ pos,
                                                pos == "SPACE" ~ token,
                                                TRUE ~ token)) |>
      dplyr::select(doc_id, POSnoise) |>
      dplyr::rename(token = POSnoise) |>
      quanteda::as.tokens() -> x.pos

    x.corp <- sapply(x.pos, function(x) { paste(x, collapse = " ") }) |> quanteda::corpus()

  }

  quanteda::docvars(x.corp) <- meta

  return(x.corp)

}
