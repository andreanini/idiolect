#' Content masking
#'
#' This function offers three algorithms for topic/content masking. In order to run the masking algorithms, a `spacy` tokenizer or POS-tagger has to be run first (via `spacyr`). For more information about the masking algorithms see Details below.
#'
#' The default algorithm for content masking that this function applies is `POSnoise` (Halvani and Graner 2021). This algorithm only works for English and it transforms a text by masking tokens using their POS tag if these tokens are: nouns, verbs, adjectives, adverbs, digits, and symbols while leaving all the rest unchanged. `POSnoise` uses a list of function words for English that also includes frequent words belonging to the masked Part of Speech tags that tend to be mostly functional (e.g. make, recently, well).
#'
#' Another algorithm implemented is Nini's (2023) `frames` or `frame n-grams`. This algorithm does not involve a special list of tokens and therefore can potentially work for any language provided that the correct `spacy` model is loaded. This algorithm consists in masking all tokens using their POS tag only when these are nouns, verbs, or numbers. The original version of the algorithms also masked personal pronouns but this is not done here to make this more applicable for various languages (the spacy universal tagset does not distinguish personal pronouns from other types of pronouns).
#'
#' Finally, the last algorithm implemented is a version of `textdistortion`, as originally proposed by Stamatatos (2017). This version of the algorithm is essentially `POSnoise` but without POS tag information. The default implementation uses the same list of function words that are used for `POSnoise`. In addition to the function words provided, the function treats all punctuation marks and new line breaks as function words to keep. The basic tokenization is done using `spacyr` so the right model for the language being analysed should be selected.
#'
#' If you have never used `spacyr` before then please follow the instructions to set it up and install a model before using this function here: [https://spacyr.quanteda.io](https://spacyr.quanteda.io).
#'
#' @param corpus A `quanteda` corpus object, typically the output of the [create_corpus()] function.
#' @param algorithm A string, either "POSnoise" (default), "frames", or "textdistortion".
#' @param fw_list The list of function words to use for the `textdistortion` algorithm. This is either the default ("eng_halvani") for the same list of function words used for `POSnoise` or it can be a vector of strings where each string is a function word to keep.
#' @param model The spacy model to use. The default is "en_core_web_sm".
#'
#' @references Halvani, Oren & Lukas Graner. 2021. POSNoise: An Effective Countermeasure Against Topic Biases in Authorship Analysis. In Proceedings of the 16th International Conference on Availability, Reliability and Security, 1–12. Vienna, Austria: Association for Computing Machinery. https://doi.org/10.1145/3465481.3470050.
#' Nini, Andrea. 2023. A Theory of Linguistic Individuality for Authorship Analysis (Elements in Forensic Linguistics). Cambridge, UK: Cambridge University Press.
#' Stamatatos, Efstathios. 2017. Masking topic-related information to enhance authorship attribution. Journal of the Association for Information Science and Technology. https://doi.org/10.1002/asi.23968.
#'
#'
#' @return A `quanteda` corpus object only containing functional tokens, depending on the algorithm chosen. The corpus contains the same docvars as the input. Email addresses or URLs are treated like nouns.
#'
#'
#' @examples
#' \dontrun{
#' text <- "The cat was on the chair. He didn't move\ncat@pets.com;\nhttp://quanteda.io/. i.e. a test "
#' toy.corpus <- quanteda::corpus(text)
#' contentmask(toy.corpus, algorithm = "POSnoise")
#' contentmask(toy.corpus, algorithm = "frames")
#' contentmask(toy.corpus, algorithm = "textdistortion")
#' }
#' @export
contentmask <- function(
    corpus,
    model = "en_core_web_sm",
    algorithm = "POSnoise",
    fw_list = "eng_halvani") {
  # this removes potential empty documents in the corpus, which are anyway removed by spacy
  c <- quanteda::corpus_subset(corpus, quanteda::ntoken(corpus) > 0)

  docids <- quanteda::docid(c)
  meta <- quanteda::docvars(c)
  names <- quanteda::docnames(c)

  if (algorithm == "textdistortion") {
    spacyr::spacy_initialize(model = model, entity = FALSE)
    toks <- spacyr::spacy_tokenize(c, "word", remove_separators = FALSE, output = "data.frame")
    spacyr::spacy_finalize()

    if (length(fw_list) > 1) {
      keeplist <- fw_list
    } else if (fw_list == "eng_halvani") {
      keeplist <- c(
        c(
          "&", "'", "\\", "[", "]", "{", "}", ":", ",", "-", "\"", "...", "!", ".", "(", ")", "?", ";",
          "/", "\n"
        ),
        halvani
      )
    } else {
      keeplist <- fw_list
    }

    x.corp <- toks |>
      dplyr::filter(token != " ") |>
      dplyr::mutate(token = stringr::str_to_lower(token)) |>
      dplyr::mutate(token = dplyr::if_else(token %in% keeplist, token, "*")) |>
      dplyr::group_by(doc_id) |>
      dplyr::summarise(text = paste(token, collapse = " ")) |>
      quanteda::corpus()
  } else {
    spacyr::spacy_initialize(model = model, entity = FALSE)
    parsed.corpus <- spacyr::spacy_parse(
      c,
      lemma = FALSE,
      entity = FALSE,
      additional_attributes = c("like_url", "like_email")
    )
    spacyr::spacy_finalize()

    if (algorithm == "POSnoise") {
      content <- c("N", "P", "V", "J", "B", "D", "S")

      x.pos <- parsed.corpus |>
        dplyr::mutate(token = tolower(token)) |>
        dplyr::mutate(
          pos = dplyr::case_when(
            like_email == TRUE ~ "N",
            like_url == TRUE ~ "N",
            pos == "NOUN" ~ "N",
            pos == "PROPN" ~ "P",
            pos == "VERB" ~ "V",
            pos == "ADJ" ~ "J",
            pos == "ADV" ~ "B",
            pos == "NUM" ~ "D",
            pos == "SYM" ~ "S",
            TRUE ~ pos
          )
        ) |>
        dplyr::mutate(
          POSnoise = dplyr::case_when(
            token %in% halvani ~ token,
            !(pos %in% content) ~ token,
            pos == "SPACE" ~ token,
            TRUE ~ pos
          )
        ) |>
        dplyr::select(doc_id, POSnoise) |>
        dplyr::rename(token = POSnoise) |>
        quanteda::as.tokens()

      x.corp <- sapply(x.pos, function(x) {
        paste(x, collapse = " ")
      }) |> quanteda::corpus()
    }

    if (algorithm == "frames") {
      x.pos <- parsed.corpus |>
        dplyr::mutate(token = tolower(token)) |>
        dplyr::mutate(
          POSnoise = dplyr::case_when(
            like_email == TRUE ~ "NOUN",
            like_url == TRUE ~ "NOUN",
            pos %in% c("PROPN", "NOUN", "VERB", "NUM") ~ pos,
            pos == "SPACE" ~ token,
            TRUE ~ token
          )
        ) |>
        dplyr::select(doc_id, POSnoise) |>
        dplyr::rename(token = POSnoise) |>
        quanteda::as.tokens()

      x.corp <- sapply(x.pos, function(x) {
        paste(x, collapse = " ")
      }) |> quanteda::corpus()
    }
  }

  quanteda::docvars(x.corp) <- meta
  quanteda::docnames(x.corp) <- names

  return(x.corp)
}
