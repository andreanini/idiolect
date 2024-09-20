#' Extract patterns from the output of the LambdaG algorithm
#'
#' This function extracts the patterns from the output of the LambdaG algorithm (Nini et al. under review).
#'
#' @param q.data A single questioned or disputed text as a `quanteda` tokens object with the tokens being sentences (e.g. the output of [tokenize_sents()]).
#' @param k.data A known or undisputed corpus containing exclusively a single candidate author's texts as a `quanteda` tokens object with the tokens being sentences (e.g. the output of [tokenize_sents()]).
#' @param ref.data The reference dataset as a `quanteda` tokens object with the tokens being sentences (e.g. the output of [tokenize_sents()]).
#' @param N The order of the model. Default is 10. It cannot be 1.
#' @param r The number of iterations. Default is 30.
#' @param cores The number of cores to use for parallel processing (the default is one).
#'
#' @references Nini, A., Halvani, O., Graner, L., Gherardi, V., Ishihara, S. Authorship Verification based on the Likelihood Ratio of Grammar Models. https://arxiv.org/abs/2403.08462v1
#'
#' @return The function outputs a data frame with each row being an extracted pattern from the Q text, with the context, token, n-gram length, the probability of the token given the context in the Q text, the probability of the token given the context in the K text, and the lambdaG value for the pattern.
#'
#' @export
#'
#' @examples
#' q.data <- corpus_trim(enron.sample[1], "sentences", max_ntoken = 10) |> quanteda::tokens("sentence")
#' k.data <- enron.sample[2:5]|> quanteda::tokens("sentence")
#' ref.data <- enron.sample[6:ndoc(enron.sample)] |> quanteda::tokens("sentence")
#' lambdaG_patterns(q.data, k.data, ref.data, r = 2)
#'
lambdaG_patterns <- function(q.data, k.data, ref.data, N = 10, r = 30, cores = NULL){

  if(N == 1){

    stop("N cannot be 1.")

  }

  q.data.s <- add_sentence_boundaries(q.data)

  q.ngrams <- find_ngram_list(q.data.s, N)

  k.g = extract(as.character(k.data), N = N)

  pbapply::pbreplicate(r, find_patterns(ref.data, k.data, N, q.ngrams, k.g),
                       simplify = FALSE,
                       cl = cores) |>
    dplyr::bind_rows() |>
    dplyr::group_by(id, context, token, n) |>
    dplyr::summarise(llr = mean(llr)) |>
    dplyr::ungroup() |>
    dplyr::select(-id) |>
    dplyr::slice_min(order_by = n, n = 1, by = llr) |>
    dplyr::distinct() |>
    dplyr::arrange(dplyr::desc(llr), n, context) ->
    final.res

  return(final.res)

}

find_patterns <- function(ref.data, k.data, N, q.ngrams, k.g){

  ref.g <- ref.data |> as.character() |>  sample(length(k.data)) |> extract(N = N)

  lapply(as.list(q.ngrams), \(x){

    toks <- x |> stringr::str_squish() |> stringr::str_split_1(" ")
    n_tokens <- length(toks)

    topred = toks[n_tokens]
    context = paste0(toks[1:(n_tokens-1)], collapse = " ")

    list(context = context,
         token = topred,
         n = n_tokens,
         k = kgrams::probability(kgrams::`%|%`(topred, context), k.g),
         ref = kgrams::probability(kgrams::`%|%`(topred, context), ref.g),
         llr = log10(kgrams::probability(kgrams::`%|%`(topred, context), k.g)/
                       kgrams::probability(kgrams::`%|%`(topred, context), ref.g)))

  }) |>
    dplyr::bind_rows() |>
    dplyr::mutate(id = 1:length(q.ngrams)) ->
    res

  return(res)

}
find_ngram_list <- function(t, N){

  t |>
    unlist() |>
    tokens(remove_punct = FALSE, remove_symbols = FALSE, remove_url = TRUE, remove_numbers = FALSE,
           split_hyphens = TRUE, remove_separators = TRUE) |>
    tokens_ngrams(2:N, concatenator = " ") |>
    unlist(use.names = FALSE) ->
    ngram.list

  return(ngram.list)

}
add_sentence_boundaries <- function(t){

  lapply(t, \(y){

    sapply(y, \(x) paste(kgrams::BOS(), x, kgrams::EOS()))

  }) |>
    quanteda::as.tokens() -> t.s

  docvars(t.s) <- docvars(t)

  return(t.s)

}
extract <- function(s, N = N){

  kgrams::kgram_freqs(s, N = N) |>
    kgrams::language_model(smoother = "kn", D = 0.75) -> model

  return(model)

}
