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
#' @param input A `quanteda` corpus object, typically the output of the [create_corpus()] function, or a `quanteda` tokens object where each token is a sentence (the output of [tokenize_sents()]).
#' @param algorithm A string, either "POSnoise" (default), "frames", or "textdistortion".
#' @param fw_list The list of function words to use for the `textdistortion` algorithm. This is either the default ("eng_halvani") for the same list of function words used for `POSnoise` or it can be a vector of strings where each string is a function word to keep.
#' @param model The spacy model to use. The default is "en_core_web_sm".
#' @param cores The number of cores to use for parallel processing (the default is one). This option only applies when the input is a tokens object containing sentences.
#'
#' @references Halvani, Oren & Lukas Graner. 2021. POSNoise: An Effective Countermeasure Against Topic Biases in Authorship Analysis. In Proceedings of the 16th International Conference on Availability, Reliability and Security, 1–12. Vienna, Austria: Association for Computing Machinery. https://doi.org/10.1145/3465481.3470050.
#' Nini, Andrea. 2023. A Theory of Linguistic Individuality for Authorship Analysis (Elements in Forensic Linguistics). Cambridge, UK: Cambridge University Press.
#' Stamatatos, Efstathios. 2017. Masking topic-related information to enhance authorship attribution. Journal of the Association for Information Science and Technology. https://doi.org/10.1002/asi.23968.
#'
#'
#' @return Either a `quanteda` corpus object or a `quanteda` tokens object containing sentences, depending on the input, but only containing functional tokens according to the chosen content-masking algorithm. The corpus contains the same docvars as the input. Email addresses or URLs are treated like nouns.
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
    input,
    model = "en_core_web_sm",
    algorithm = "POSnoise",
    fw_list = "eng_halvani",
    cores = NULL
  ) {
  docids <- quanteda::docid(input)
  meta <- quanteda::docvars(input)
  names <- quanteda::docnames(input)

  # this is only for textdistortion
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

  # this is only for POSnoise
  content <- c("N", "P", "V", "J", "B", "D", "S")

  spacyr::spacy_initialize(model = model, entity = FALSE)

  if (quanteda::is.corpus(input)) {
    # this removes potential empty documents in the corpus, which are anyway removed by spacy
    c <- quanteda::corpus_subset(input, quanteda::ntoken(input) > 0)
    if (algorithm == "textdistortion") {
      toks <- spacyr::spacy_tokenize(c, "word", remove_separators = FALSE, output = "data.frame")
      x.corp <- toks |>
        dplyr::filter(token != " ") |>
        dplyr::mutate(token = stringr::str_to_lower(token)) |>
        dplyr::mutate(token = dplyr::if_else(token %in% keeplist, token, "*")) |>
        dplyr::group_by(doc_id) |>
        dplyr::summarise(text = paste(token, collapse = " ")) |>
        quanteda::corpus()
    } else {
      parsed.corpus <- spacyr::spacy_parse(
        c,
        lemma = FALSE,
        entity = FALSE,
        additional_attributes = c("like_url", "like_email")
      )
      if (algorithm == "POSnoise") {
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
  } else if (quanteda::is.tokens(input)) {
    if (algorithm == "textdistortion") {
      x.corp <- pbapply::pblapply(
        input,
        \(x){
          sapply(
            x,
            \(s){
              toks <- spacyr::spacy_tokenize(s, "word", remove_separators = FALSE, output = "data.frame")
              output <- toks |>
                dplyr::filter(token != " ") |>
                dplyr::mutate(token = stringr::str_to_lower(token)) |>
                dplyr::mutate(token = dplyr::if_else(token %in% keeplist, token, "*")) |>
                dplyr::group_by(doc_id) |>
                dplyr::summarise(text = paste(token, collapse = " ")) |>
                dplyr::pull(text)
            }
          )
        },
        cl = cores
      ) |>
        quanteda::as.tokens()
    } else if (algorithm == "POSnoise") {
      x.corp <- pbapply::pblapply(
        input,
        \(x){
          sapply(
            x,
            \(s){
              parsed <- spacyr::spacy_parse(
                s,
                lemma = FALSE,
                entity = FALSE,
                additional_attributes = c("like_url", "like_email")
              )
              masked <- parsed |>
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
              output <- sapply(
                masked,
                \(x) {
                  paste(x, collapse = " ")
                }
              )
            }
          )
        },
        cl = cores
      ) |>
        quanteda::as.tokens()
    } else if (algorithm == "frames") {
      x.corp <- pbapply::pblapply(
        input,
        \(x){
          sapply(
            x,
            \(s){
              parsed <- spacyr::spacy_parse(
                s,
                lemma = FALSE,
                entity = FALSE,
                additional_attributes = c("like_url", "like_email")
              )
              masked <- parsed |>
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
              output <- sapply(
                masked,
                \(x) {
                  paste(x, collapse = " ")
                }
              )
            }
          )
        },
        cl = cores
      ) |>
        quanteda::as.tokens()
    }
  }

  spacyr::spacy_finalize()

  quanteda::docvars(x.corp) <- meta
  quanteda::docnames(x.corp) <- names
  return(x.corp)
}
