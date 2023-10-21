#' Content masking
#'
#' This function offers two algorithms for topic/content masking. See Details below.
#'
#' References to algorithms to appear here.
#'
#' @param corpus A `quanteda` corpus object, typically the output of the [create_corpus()] function.
#' @param algorithm A string, either "POSnoise" (default) or "frames".
#' @param model The spacy model to use. The default is en_core_web_sm.
#' @param replace_non_ascii A boolean value. If this is TRUE then All non-ASCII characters are either substituted to ASCII ones or removed using the function [textclean::replace_non_ascii()]. This operation also removes all emojis.
#'
#' @return A `quanteda` corpus object only containing functional tokens, depending on the algorithm chosen. The corpus contains the same docvars as the input. Email addresses or URLs are treated like nouns.
#' @export
#'
#' @examples
#' text <- "The elegant cat was forcefully put on the chair. cat@pets.com; http://quanteda.io/"
#' toy.corpus <- quanteda::corpus(text)
#' contentmask(toy.corpus, algorithm = "POSnoise", replace_non_ascii = FALSE)
contentmask <- function(corpus, model = "en_core_web_sm", algorithm = "POSnoise", replace_non_ascii){


  if(replace_non_ascii == T){

    meta.p <- quanteda::docvars(corpus)

    c.c <- textclean::replace_non_ascii(corpus) |> quanteda::corpus()

    docvars(c.c) <- meta.p

  }else{

    c.c <- corpus

  }

  # this removes potential empty documents in the corpus, which are anyway removed by spacy
  c <- quanteda::corpus_subset(c.c, quanteda::ntoken(c.c) > 0)

  meta <- quanteda::docvars(c)


  spacyr::spacy_initialize(model = model, entity = F)
  parsed.corpus <- spacyr::spacy_parse(c, lemma = F, entity = F,
                                       additional_attributes = c("like_url", "like_email"))
  spacyr::spacy_finalize()

  if(algorithm == "POSnoise"){

    content <- c("N", "P", "V", "J", "B", "D", "S")

    parsed.corpus |>
      dplyr::mutate(token = tolower(token)) |>
      dplyr::mutate(pos = dplyr::case_when(like_email == T ~ "N",
                                           like_url == T ~ "N",
                                           pos == "NOUN" ~ "N",
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
