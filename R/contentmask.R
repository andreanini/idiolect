#' Content masking
#'
#' This function offers two algorithms for topic/content masking. In order to run the masking algorithms, a Part of Speech (POS) tagger is run first. This is `spacy`, which is run via [spacyr]. For more information about the masking algorithms see Details below.
#'
#' The default algorithm for content masking that this function applies is `POSnoise` (Halvani and Graner 2021). This algorithm only works for English and it transforms a text by masking tokens using their POS tag if these tokens are: nouns, verbs, adjectives, adverbs, digits, and symbols while leaving all the rest unchanged. `POSnoise` uses a list of function words for English that also includes frequent words belonging to the masked Part of Speech tags that tend to be mostly functional (e.g. make, recently, well).
#'
#' Another algorithm implemented is Nini's (2023) `frames` or `frame n-grams`. This algorithm does not involve a special list of tokens and therefore can potentially work for any language provided that the correct `spacy` model is loaded. This algorithm consists in masking all tokens using their POS tag only when these are nouns, verbs, or personal pronouns.
#'
#' @param corpus A `quanteda` corpus object, typically the output of the [create_corpus()] function.
#' @param algorithm A string, either "POSnoise" (default) or "frames".
#' @param model The spacy model to use. The default is en_core_web_sm.
#' @param replace_non_ascii A boolean value. If this is TRUE then All non-ASCII characters are either substituted to ASCII ones or removed using the function [textclean::replace_non_ascii()]. This operation also removes all emojis.
#'
#' @references Halvani, Oren & Lukas Graner. 2021. POSNoise: An Effective Countermeasure Against Topic Biases in Authorship Analysis. In Proceedings of the 16th International Conference on Availability, Reliability and Security, 1–12. Vienna, Austria: Association for Computing Machinery. https://doi.org/10.1145/3465481.3470050.
#' Nini, Andrea. 2023. A Theory of Linguistic Individuality for Authorship Analysis (Elements in Forensic Linguistics). Cambridge, UK: Cambridge University Press.
#'
#'
#' @return A `quanteda` corpus object only containing functional tokens, depending on the algorithm chosen. The corpus contains the same docvars as the input. Email addresses or URLs are treated like nouns.
#'
#' @examples
#' \dontrun{
#' text <- "The elegant cat was forcefully put on the chair. cat@pets.com; http://quanteda.io/"
#' toy.corpus <- quanteda::corpus(text)
#' contentmask(toy.corpus, algorithm = "POSnoise", replace_non_ascii = FALSE)
#' }
#'
#' @export
contentmask <- function(corpus, model = "en_core_web_sm", algorithm = "POSnoise", replace_non_ascii = F){


  if(replace_non_ascii == T){

    meta <- quanteda::docvars(corpus)
    names <- quanteda::docnames(corpus)

    c.c <- textclean::replace_non_ascii(corpus) |> quanteda::corpus()

    quanteda::docvars(c.c) <- meta
    quanteda::docnames(c.c) <- names


  }else{

    c.c <- corpus

  }

  # this removes potential empty documents in the corpus, which are anyway removed by spacy
  c <- quanteda::corpus_subset(c.c, quanteda::ntoken(c.c) > 0)

  meta <- quanteda::docvars(c)
  names <- quanteda::docnames(c)

  spacyr::spacy_initialize(model = model, entity = F)
  parsed.corpus <- spacyr::spacy_parse(c, lemma = F, entity = F, tag = T,
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

  if(algorithm == "frames"){

    content = c("ADD", "CD", "NN", "NNP", "NNPS", "NNS", "PRP", "PRP$", "VB", "VBD", "VBG", "VBN", "VBP",
                "VBZ")

    parsed.corpus |>
      dplyr::mutate(token = tolower(token)) |>
      dplyr::mutate(POSnoise = dplyr::case_when(tag %in% content ~ tag,
                                                tag == "_SP" ~ token,
                                                TRUE ~ token)) |>
      dplyr::select(doc_id, POSnoise) |>
      dplyr::rename(token = POSnoise) |>
      quanteda::as.tokens() -> x.pos

    x.corp <- sapply(x.pos, function(x) { paste(x, collapse = " ") }) |> quanteda::corpus()

  }

  quanteda::docvars(x.corp) <- meta
  quanteda::docnames(x.corp) <- names

  return(x.corp)

}
