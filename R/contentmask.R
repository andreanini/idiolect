#' Content masking
#'
#' This function offers two algorithms for topic/content masking. See Details below.
#'
#' References to algorithms to appear here.
#'
#' @param parsed.corpus A data frame containing a `spacyr` Part of Speech tagged corpus. Typically the output of the [create_corpus()] function with the pos_tag argument switched to TRUE.
#' @param algorithm A string, either "POSnoise" (default) or "frames".
#'
#' @return A `quanteda` corpus object only containing functional tokens, depending on the algorithm chosen. The corpus also contains the author names as a docvar.
#' @export
#'
#' @examples
#' text <- "The elegant cat was forcefully put on the chair."
#' spacyr::spacy_initialize()
#' parsed.text <- spacyr::spacy_parse(text)
#' spacyr::spacy_finalize()
#' posnoise.text <- contentmask(parsed.text, algorithm = "POSnoise")
#' frames.text <- contentmask(parsed.text, algorithm = "framenoise")
contentmask <- function(parsed.corpus, algorithm = "POSnoise"){

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

    quanteda::docvars(x.corp, field = 'author') <- gsub('(\\w+)_\\w+\\.txt', '\\1', quanteda::docid(x.corp))

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

    quanteda::docvars(x.corp, field = 'author') <- gsub('(\\w+)_\\w+\\.txt', '\\1', quanteda::docid(x.corp))

  }

  return(x.corp)

}
