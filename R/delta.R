cosine_delta <- function(x, z){

  a.name = as.character(x["Q"])
  a = quanteda::dfm_subset(z, quanteda::docnames(z) == a.name)
  a.author = quanteda::docvars(a, "author")

  b.name = as.character(x["K"])
  b = quanteda::dfm_subset(z, quanteda::docnames(z) == b.name)
  b.author = quanteda::docvars(b, "author")

  score <- quanteda.textstats::textstat_simil(a, b, method = "cosine") |> suppressMessages() |> as.numeric()

  results = data.frame()
  results[1,"Q"] = a.name
  results[1,"K"] = b.name

  if(a.author == b.author){

    results[1,"target"] = TRUE

  }else{

    results[1,"target"] = FALSE

  }

  results[1,"score"] = round(score, 3)

  return(results)

}
#' Delta
#'
#' This function runs a classic *Cosine Delta* analysis (Smith and Aldridge 2011; Evert et al. 2017).
#'
#' @param q.data The questioned or disputed data, either as a corpus (the output of [create_corpus()]) or as a `quanteda` dfm (the output of [vectorize()]).
#' @param k.data The known or undisputed data, either as a corpus (the output of [create_corpus()]) or as a `quanteda` dfm (the output of [vectorize()]).
#' @param tokens The type of tokens to extract, either "word" (default) or "character".
#' @param remove_punct A logical value. FALSE (default) keeps punctuation marks.
#' @param remove_symbols A logical value. TRUE (default) removes symbols.
#' @param remove_numbers A logical value. TRUE (default) removes numbers
#' @param lowercase A logical value. TRUE (default) transforms all tokens to lower case.
#' @param n The order or size of the n-grams being extracted. Default is 1.
#' @param trim A logical value. If TRUE (default) then only the most frequent tokens are kept.
#' @param threshold A numeric value indicating how many most frequent tokens to keep if trim = T. The default is 150.
#' @param features Logical with default FALSE. If TRUE, then the output will contain the features used.
#' @param cores The number of cores to use for parallel processing (the default is one).
#'
#' @references Evert, Stefan, Thomas Proisl, Fotis Jannidis, Isabella Reger, Steffen Pielström, Christof Schöch & Thorsten Vitt. 2017. Understanding and explaining Delta measures for authorship attribution. Digital Scholarship in the Humanities 32. ii4–ii16. https://doi.org/10.1093/llc/fqx023.
#' Smith, Peter W H & W Aldridge. 2011. Improving Authorship Attribution: Optimizing Burrows’ Delta Method*. Journal of Quantitative Linguistics 18(1). 63–88. https://doi.org/10.1080/09296174.2011.533591.

#' @return If features is set to FALSE then the output is a data frame containing the results of all comparisons between the Q texts and the K texts. If features is set to TRUE then the output is a list containing the results data frame and the vector of features used for the analysis.
#'
#' @examples
#' Q <- enron.sample[c(5:6)]
#' K <- enron.sample[-c(5:6)]
#' delta(Q, K)
#'
#' @export
delta <- function(q.data, k.data, tokens = "word", remove_punct = F, remove_symbols = T, remove_numbers = T, lowercase = T, n = 1, trim = T, threshold = 150, features = F, cores = NULL){

  if(quanteda::is.corpus(q.data) & quanteda::is.corpus(k.data)){

    d = vectorize(c(q.data, k.data), tokens = tokens, remove_punct = remove_punct,
                  remove_symbols = remove_symbols, remove_numbers = remove_numbers, lowercase = lowercase,
                  n = n, weighting = "rel", trim = trim, threshold = threshold)

  }else if(quanteda::is.dfm(q.data) & quanteda::is.dfm(k.data)){

    d <- rbind(q.data, k.data)

  }else{

    stop("The Q and K objects need to be either quanteda corpora or quanteda dfms.")

  }

  q.list <- quanteda::docnames(q.data)
  k.list <- quanteda::docnames(k.data)

  tests <- expand.grid(q.list, k.list, stringsAsFactors = F) |>
    dplyr::rename(Q = Var1, K = Var2)

  z <- scale(d) |> quanteda::as.dfm()
  quanteda::docvars(z) <- quanteda::docvars(d)

  results <- pbapply::pbapply(tests, 1, cosine_delta, z, cl = cores)

  results.table = list_to_df(results)

  if(features == T){

    output <- list(results = results.table, features = colnames(d))

  }else{

    output <- results.table

  }

  return(output)

}
