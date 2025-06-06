#' Visualize the output of the LambdaG algorithm
#'
#' This function outputs a colour-coded list of sentences belonging to the input Q text ordered from highest to lowest \eqn{\lambda_G}, as shown in Nini et al. (under review).
#'
#' @param q.data A single questioned or disputed text as a `quanteda` tokens object with the tokens being sentences (e.g. the output of [tokenize_sents()]).
#' @param k.data A known or undisputed corpus containing exclusively a single candidate author's texts as a `quanteda` tokens object with the tokens being sentences (e.g. the output of [tokenize_sents()]).
#' @param ref.data The reference dataset as a `quanteda` tokens object with the tokens being sentences (e.g. the output of [tokenize_sents()]).
#' @param N The order of the model. Default is 10.
#' @param r The number of iterations. Default is 30.
#' @param output A string detailing the file type of the colour-coded text output. Either "html" (default) or "latex".
#' @param print A string indicating the path and filename to save the colour-coded text file. If left empty (default), then nothing is printed.
#' @param scale A string indicating what scale to use to colour-code the text file. If "absolute" (default) then the raw \eqn{\lambda_G} is used; if "relative", then the z-score of \eqn{\lambda_G} over the Q data is used instead, thus showing relative importance.
#' @param negative Logical. If TRUE then negative values of \eqn{\lambda_G} are color-coded in blue, otherwise (default) only the positive values of \eqn{\lambda_G} are displayed in red. This only applies to HTML output.
#' @param order.by A string indicating the order of the output. If "importance" (default) then the output is ordered by sentence \eqn{\lambda_G} in descending order, otherwise the text is displayed and ordered as it appears.
#' @param cores The number of cores to use for parallel processing (the default is one).
#'
#' @references Nini, A., Halvani, O., Graner, L., Gherardi, V., Ishihara, S. Authorship Verification based on the Likelihood Ratio of Grammar Models. https://arxiv.org/abs/2403.08462v1
#' @return The function outputs a list of two objects: a data frame with each row being a token in the Q text and the values of \eqn{\lambda_G} for the token and sentences, in decreasing order of sentence \eqn{\lambda_G} and with the relative contribution of each token and each sentence to the final \eqn{\lambda_G} in percentage; the raw code in html or LaTeX that generates the colour-coded file. If a path is provided for the print argument then the function will also save the colour-coded text as an html or plain text file.
#'
#' @examples
#' q.data <- corpus_trim(enron.sample[1], "sentences", max_ntoken = 10) |> quanteda::tokens("sentence")
#' k.data <- enron.sample[2:5]|> quanteda::tokens("sentence")
#' ref.data <- enron.sample[6:ndoc(enron.sample)] |> quanteda::tokens("sentence")
#' outputs <- lambdaG_visualize(q.data, k.data, ref.data, r = 2)
#' outputs$table
#'
#' @export
lambdaG_visualize <- function(q.data, k.data, ref.data, N = 10, r = 30, output = "html", print = "", scale = "absolute", negative = FALSE, order.by = "importance", cores = NULL){

  if(length(unique(quanteda::docvars(k.data, "author"))) != 1){

    stop("The k.data does not contain a single candidate author.")

  }

  if(length(q.data) != 1){

    stop("The q.data does not contain one text only.")

  }


  llr.table <- loglikelihood_table_avgllrs(q.data, k.data, ref.data, r, N, order.by, cores = cores)

  # calculation of relative contribution in percentage
  dplyr::filter(llr.table, lambdaG > 0) |> dplyr::pull(lambdaG) |> sum() -> pos.t.total
  dplyr::filter(llr.table, lambdaG < 0) |> dplyr::pull(lambdaG) |> sum() -> neg.t.total
  dplyr::slice_head(llr.table, n = 1, by = sentence_id) |> dplyr::filter(sentence_lambdaG > 0) |>
    dplyr::pull(sentence_lambdaG) |> sum() -> pos.s.total
  dplyr::slice_head(llr.table, n = 1, by = sentence_id) |> dplyr::filter(sentence_lambdaG < 0) |>
    dplyr::pull(sentence_lambdaG) |> sum() -> neg.s.total

  llr.table |>
    dplyr::mutate(token_contribution = dplyr::case_when(lambdaG > 0 ~ round(lambdaG/pos.t.total*100, 2),
                                                        lambdaG < 0 ~ round(-lambdaG/neg.t.total*100, 2),
                                                        lambdaG == 0 ~ 0)) |>
    dplyr::mutate(sent_contribution = dplyr::case_when(sentence_lambdaG > 0 ~
                                                         round(sentence_lambdaG/pos.s.total*100, 2),
                                                        sentence_lambdaG < 0 ~
                                                         round(-sentence_lambdaG/neg.s.total*100, 2),
                                                        sentence_lambdaG == 0 ~ 0)) ->
    llr.table


  if(output == "html"){

    cc.text <- color_coding_html(llr.table, scale, negative = negative)

  }else if(output == "latex"){

    cc.text <- color_coding_latex(llr.table, scale)

  }

  if(print != ""){

    write(cc.text, print)

  }

  output.list <- list(table = llr.table, colourcoded_text = cc.text)

  return(output.list)

}
extract <- function(s, N){

  kgrams::kgram_freqs(s, N = N) |>
    kgrams::language_model(smoother = "kn", D = 0.75) -> model

  return(model)

}
loglikelihood_one_rep <- function(q.sents, k.sents, ref.sents, N, k.g, k.sent.probs){

  ref.g <- ref.sents |> sample(length(k.sents)) |> extract(N)

  ref.sent.probs = kgrams::probability(q.sents, ref.g)

  sentence.llrs <- log10(k.sent.probs/ref.sent.probs)

  table = mapply(\(id, s, sllr) {

    toks = s |> stringr::str_squish() |> stringr::str_split_1(" ")
    n_tokens = length(toks) + 1

    res = data.frame(sentence_id = id, token_id = 1:n_tokens, t = character(n_tokens),
                     k = numeric(n_tokens), ref = numeric(n_tokens), llr = numeric(n_tokens),
                     sentence_llr = sllr)

    for (i in 1:n_tokens) {
      topred = ifelse(i < n_tokens, toks[i], kgrams::EOS())

      context = toks[ seq(from = 0, to = i - 1) ]
      context = c(rep(kgrams::BOS(), N - 1), context)
      context = paste0(context, collapse = " ")

      res$t[i] = topred
      res$k[i] = kgrams::probability(kgrams::`%|%`(topred, context), k.g)
      res$ref[i] = kgrams::probability(kgrams::`%|%`(topred, context), ref.g)
      res$llr[i] = log10(res$k[i]/res$ref[i])
    }

    res
  }, 1:length(q.sents), q.sents, sentence.llrs, SIMPLIFY = FALSE)

  table = dplyr::bind_rows(table)

  return(table)

}
loglikelihood_table_avgllrs <- function(q.data, k.data, ref.data, r, N, order.by, cores){

  k.sents = as.character(k.data)
  ref.sents = as.character(ref.data)
  q.sents = as.character(q.data)

  k.g = extract(k.sents, N)
  k.sent.probs = kgrams::probability(q.sents, k.g)

  pbapply::pbreplicate(r, loglikelihood_one_rep(q.sents, k.sents, ref.sents, N, k.g, k.sent.probs),
                       simplify = FALSE, cl = cores) |>
    dplyr::bind_rows() |>
    dplyr::group_by(sentence_id, token_id, t) |>
    dplyr::summarise(lambdaG = mean(llr), sentence_lambdaG = round(mean(sentence_llr), 3)) |>
    dplyr::ungroup() |>
    dplyr::mutate(zlambdaG = as.numeric(round(scale(lambdaG), 3))) -> final.table

  if(order.by == "importance"){

    final.table <- dplyr::arrange(final.table, desc(sentence_lambdaG), sentence_id, token_id)

  }

  return(final.table)

}
color_coding_html <- function(llr.table, scale, negative){

  if(scale == "absolute"){

    llr.table |> dplyr::mutate(color = dplyr::case_when(lambdaG > 0 & lambdaG < 1 ~ "#fdedec",
                                                        lambdaG >= 1 & lambdaG < 2 ~ "#f5b7b1",
                                                        lambdaG >= 2 & lambdaG < 3 ~ "#ec7063",
                                                        lambdaG >= 3 & lambdaG <= 4 ~ "#cb4335",
                                                        lambdaG > 4 ~ "#943126",
                                                        .default = "")) -> table2

    if(negative == TRUE){

      table2 |> dplyr::mutate(color = dplyr::case_when(lambdaG < 0 & lambdaG > -1 ~ "#d1e5f0",
                                                        lambdaG <= -1 & lambdaG > -2 ~ "#92c5de",
                                                        lambdaG <= -2 & lambdaG > -3 ~ "#4393c3",
                                                        lambdaG <= -3 & lambdaG >= -4 ~ "#2166ac",
                                                        lambdaG < -4 ~ "#053061",
                                                        .default = color)) -> table2

    }

  }

  if(scale == "relative"){

    llr.table |> dplyr::mutate(color = dplyr::case_when(zlambdaG > 0.5 & zlambdaG <= 1 ~ "#FADBD8",
                                                        zlambdaG > 1 & zlambdaG <= 2 ~ "#F1948A",
                                                        zlambdaG > 2 ~ "#E74C3C",
                                                        .default = "")) -> table2

    if(negative == TRUE){

      table2 |> dplyr::mutate(color = dplyr::case_when(zlambdaG < -0.5 & zlambdaG >= -1 ~ "#d1e5f0",
                                                       zlambdaG < -1 & zlambdaG >= -2 ~ "#67a9cf",
                                                       zlambdaG < -2 ~ "#2166ac",
                                                       .default = color)) -> table2

    }

  }

  string = c()

  for (i in 1:nrow(table2)) {

    if(table2[i, "color"] != ""){

      segment = paste0("<span style=\"background-color: ", table2[i, "color"], ";\">",
                       table2[i, "t"],
                       "</span>")

    }else{

      segment = table2[i, "t"]

    }

    string = paste(string, segment, sep = " ") |> stringr::str_replace_all("___EOS___", "<br>")

  }

  return(string)

}
color_coding_latex <- function(llr.table, scale){

  if(scale == "absolute"){

    llr.table |> dplyr::mutate(t = dplyr::if_else(t == "___EOS___", "[EOS]", t),
                               color = dplyr::case_when(lambdaG > 0 & lambdaG < 1 ~ 20,
                                                        lambdaG >= 1 & lambdaG < 2 ~ 40,
                                                        lambdaG >= 2 & lambdaG < 3 ~ 60,
                                                        lambdaG >= 3 & lambdaG <= 4 ~ 80,
                                                        lambdaG > 4 ~ 100,
                                                        .default = 0)) -> table2

  }

  if(scale == "relative"){

    llr.table |> dplyr::mutate(t = dplyr::if_else(t == "___EOS___", "[EOS]", t),
                               color = dplyr::case_when(zlambdaG > 0.5 & zlambdaG <= 1 ~ 20,
                                                        zlambdaG > 1 & zlambdaG <= 2 ~ 50,
                                                        zlambdaG > 2 ~ 70,
                                                        .default = 0)) -> table2
  }


  string = c()

  for (i in 1:nrow(table2)) {

    if(table2[i, "t"] == "[EOS]"){

      segment = paste0("\\code{colorlow!", table2[i, "color"], "}{\\strut ",
                       table2[i, "t"],
                       "}\\allowbreak\\newline")

    }else{

      segment = paste0("\\code{colorlow!", table2[i, "color"], "}{\\strut ",
                       table2[i, "t"],
                       "}\\allowbreak")

    }

    string <- paste0(string, segment)

  }

  return(string)

}
