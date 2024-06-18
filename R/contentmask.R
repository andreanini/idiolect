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
#' @param output A string, either "corpus" or "sentences". This indicates the kind of object returned by the function, either a `quanteda` corpus or a `quanteda` tokens list where each token is a sentence.
#'
#' @references Halvani, Oren & Lukas Graner. 2021. POSNoise: An Effective Countermeasure Against Topic Biases in Authorship Analysis. In Proceedings of the 16th International Conference on Availability, Reliability and Security, 1–12. Vienna, Austria: Association for Computing Machinery. https://doi.org/10.1145/3465481.3470050.
#' Nini, Andrea. 2023. A Theory of Linguistic Individuality for Authorship Analysis (Elements in Forensic Linguistics). Cambridge, UK: Cambridge University Press.
#'
#'
#' @return A `quanteda` corpus object or a `quanteda` list of sentences only containing functional tokens, depending on the algorithm and output type chosen. The corpus contains the same docvars as the input. Email addresses or URLs are treated like nouns.
#'
#' @examples
#' \dontrun{
#' text <- "The elegant cat was forcefully put on the chair. He didn't like it but he did not move\ncat@pets.com;\nhttp://quanteda.io/"
#' toy.corpus <- quanteda::corpus(text)
#' contentmask(toy.corpus, algorithm = "POSnoise", replace_non_ascii = FALSE)
#' contentmask(toy.corpus, algorithm = "POSnoise", replace_non_ascii = FALSE, output = "sentences")
#' }
#'
#' @export
contentmask <- function(corpus, model = "en_core_web_sm", algorithm = "POSnoise", replace_non_ascii = F, output = "corpus"){

  if(replace_non_ascii == T){

    meta <- quanteda::docvars(corpus)
    names <- quanteda::docnames(corpus)

    c.c <- textclean::replace_non_ascii(corpus) |> quanteda::corpus()

    quanteda::docvars(c.c) <- meta
    quanteda::docnames(c.c) <- names


  }else{

    c.c <- corpus

  }

  spacyr::spacy_initialize(model = model, entity = F)

  if(output == "sentences"){

    c.p <- spacyr::spacy_tokenize(c.c, "sentence", output = "data.frame")

    dplyr::mutate(quanteda::docvars(c.c), doc_id = quanteda::docnames(c.c)) |>
      dplyr::inner_join(c.p, by = "doc_id") |>
      quanteda::corpus(text_field = "token", unique_docnames = F) -> c

  }else{

    c <- c.c

  }

  # this removes potential empty documents in the corpus, which are anyway removed by spacy
  c <- quanteda::corpus_subset(c, quanteda::ntoken(c) > 0)

  docids <- quanteda::docid(c)
  meta <- quanteda::docvars(c)
  names <- quanteda::docnames(c)

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

    if(output == "sentences"){

      x.corp <- sapply(x.pos, function(x) { paste(x, collapse = " ") }) |> quanteda::tokens("sentence")

    }else{

      x.corp <- sapply(x.pos, function(x) { paste(x, collapse = " ") }) |> quanteda::corpus()

    }

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

    if(output == "sentences"){

      x.corp <- sapply(x.pos, function(x) { paste(x, collapse = " ") }) |> quanteda::tokens("sentence")

    }else{

      x.corp <- sapply(x.pos, function(x) { paste(x, collapse = " ") }) |> quanteda::corpus()

    }

  }

  quanteda::docvars(x.corp) <- meta
  quanteda::docnames(x.corp) <- names

  if(output == "sentences"){

    quanteda::docvars(x.corp, "original_docid") <- docids
    final.x.corp <- quanteda::tokens_group(x.corp, original_docid)
    quanteda::docvars(final.x.corp, "original_docid") <- NULL

  }else{

    final.x.corp <- x.corp

  }

  return(final.x.corp)

}
