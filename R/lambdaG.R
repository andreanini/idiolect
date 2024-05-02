apply_lambdaG <- function(x, q.data, k.data, ref.data, N, r){

  q.name <- as.character(x["Q"])
  q <- quanteda::corpus_subset(q.data, quanteda::docnames(q.data) == q.name)

  candidate.name <- as.character(x["K"])
  candidate <- quanteda::corpus_subset(k.data, author == candidate.name &
                                     quanteda::docnames(k.data) != q.name)

  reference <- quanteda::corpus_subset(ref.data, author != candidate.name &
                                      author != quanteda::docvars(q, "author"))

  k.sents <- kgrams::tknz_sent(candidate, EOS = "[.?!]+( \\n+)*|\\n+", keep_first = T)
  ref.sents <- kgrams::tknz_sent(reference, "[.?!]+( \\n+)*|\\n+", keep_first = T)
  q.sents <- kgrams::tknz_sent(q, EOS = "[.?!]+( \\n+)*|\\n+", keep_first = T)

  k.g <- k.sents |> kgrams::kgram_freqs(N = N) |> kgrams::language_model(smoother = "kn", D = 0.75)

  k.probs <- kgrams::probability(q.sents, k.g)

  #this changes all 0 probabilities to the lowest value supported by R
  k.probs[which(k.probs == 0)] = .Machine$double.xmin

  lambda = 0

  for (i in 1:r) {

    s = sample(1:length(ref.sents), length(k.sents))
    cons.sents = ref.sents[s]

    ref.g <- cons.sents |> kgrams::kgram_freqs(N = N) |> kgrams::language_model(smoother = "kn", D = 0.75)

    ref.probs <- kgrams::probability(q.sents, ref.g)

    #this changes all 0 probabilities to the lowest value supported by R
    ref.probs[which(ref.probs == 0)] = .Machine$double.xmin

    lr <- log10(k.probs/ref.probs) |> sum()

    lambda = lambda + lr/r

  }

  results = data.frame()
  results[1,"K"] = quanteda::docvars(candidate[1,], "author")
  results[1,"Q"] = quanteda::docnames(q)

  if(quanteda::docvars(candidate[1,], "author") == quanteda::docvars(q, "author")){

    results[1,"target"] = TRUE

  }else{

    results[1,"target"] = FALSE

  }

  results[1,"score"] = round(lambda, 3)

  return(results)

}
#' Apply the LambdaG algorithm
#'
#' This function calculates the likelihood ratio of grammar models, or the LambdaG score, as in Nini et al. (pending submission). In order to run the analysis as in this paper, all data must be preprocessed using [contentmask()] with the "algorithm" parameter set to "POSnoise".
#'
#' @param q.data The questioned or disputed data as a corpus (the output of [create_corpus()]).
#' @param k.data The known or undisputed data as a corpus (the output of [create_corpus()]).
#' @param ref.data The reference dataset as a corpus (the output of [create_corpus()]). This can be the same object as `k.data`.
#' @param N The order of the model. Default is 10.
#' @param r The number of iterations. Default is 30.
#' @param cores The number of cores to use for parallel processing (the default is one).
#'
#' @references Nini, A., Halvani, O., Graner, L., Gherardi, V., Ishihara, S. Authorship Verification based on the Likelihood Ratio of Grammar Models. https://arxiv.org/abs/2403.08462v1
#' @return The function will test all possible combinations of q texts and candidate authors and return a
#' data frame containing the LambdaG, an uncalibrated log-likelihood ratio (base 10). LambdaG can then be calibrated into a likelihood ratio that expresses the strength of the evidence using [calibrate_LLR()]. The data frame contains a column called "target" with a logical value which is TRUE if the author of the Q text is the candidate and FALSE otherwise.
#' @export
#'
#' @examples
#' q.data <- enron.sample[1]
#' k.data <- enron.sample[2:10]
#' ref.data <- enron.sample[11:ndoc(enron.sample)]
lambdaG <- function(q.data, k.data, ref.data, N = 10, r = 30, cores = NULL){

  q.list <- quanteda::docnames(q.data)
  k.list <- quanteda::docvars(k.data, "author") |> unique()

  tests <- expand.grid(q.list, k.list, stringsAsFactors = F) |>
    dplyr::rename(Q = Var1, K = Var2)

  # this condition allows for the reference being just the rest of the K data
  if(identical(ref.data, k.data)){

    all.data <- c(q.data, k.data)

  }else{

    all.data <- c(q.data, k.data, ref.data)

  }

  results <- pbapply::pbapply(tests, 1, apply_lambdaG, q.data, k.data, ref.data, N, r, cl = cores)

  results.table = list_to_df(results)

  return(results.table)

}
