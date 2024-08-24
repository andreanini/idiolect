#' Apply the LambdaG algorithm
#'
#' This function calculates the likelihood ratio of grammar models, or \eqn{\lambda_G}, as in Nini et al. (under review). In order to run the analysis as in this paper, all data must be preprocessed using [contentmask()] with the "algorithm" parameter set to "POSnoise".
#'
#' @param q.data The questioned or disputed data as a `quanteda` tokens object with the tokens being sentences (e.g. the output of [tokenize_sents()]).
#' @param k.data The known or undisputed data as a `quanteda` tokens object with the tokens being sentences (e.g. the output of [tokenize_sents()]).
#' @param ref.data The reference dataset as a `quanteda` tokens object with the tokens being sentences (e.g. the output of [tokenize_sents()]). This can be the same object as `k.data`.
#' @param N The order of the model. Default is 10.
#' @param r The number of iterations. Default is 30.
#' @param cores The number of cores to use for parallel processing (the default is one).
#'
#' @references Nini, A., Halvani, O., Graner, L., Gherardi, V., Ishihara, S. Authorship Verification based on the Likelihood Ratio of Grammar Models. https://arxiv.org/abs/2403.08462v1
#' @return The function will test all possible combinations of Q texts and candidate authors and return a
#' data frame containing \eqn{\lambda_G}, an uncalibrated log-likelihood ratio (base 10). \eqn{\lambda_G} can then be calibrated into a likelihood ratio that expresses the strength of the evidence using [calibrate_LLR()]. The data frame contains a column called "target" with a logical value which is TRUE if the author of the Q text is the candidate and FALSE otherwise.
#'
#' @examples
#' q.data <- enron.sample[1] |> quanteda::tokens("sentence")
#' k.data <- enron.sample[2:10] |> quanteda::tokens("sentence")
#' ref.data <- enron.sample[11:ndoc(enron.sample)] |> quanteda::tokens("sentence")
#' lambdaG(q.data, k.data, ref.data)
#'
#' @export
lambdaG <- function(q.data, k.data, ref.data, N = 10, r = 30, cores = NULL){

  q.list <- quanteda::docnames(q.data)
  k.list <- quanteda::docvars(k.data, "author") |> unique()

  tests <- expand.grid(q.list, k.list, stringsAsFactors = FALSE) |>
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

apply_lambdaG <- function(x, q.data, k.data, ref.data, N, r){

  q.name <- as.character(x["Q"])
  q.author <- quanteda::tokens_subset(q.data, quanteda::docnames(q.data) == q.name) |> docvars("author")
  q.sents <- quanteda::tokens_subset(q.data, quanteda::docnames(q.data) == q.name) |> as.character()

  candidate.name <- as.character(x["K"])
  k.sents <- quanteda::tokens_subset(k.data, author == candidate.name &
                                       quanteda::docnames(k.data) != q.name) |> as.character()

  ref.sents <- quanteda::tokens_subset(ref.data, author != candidate.name &
                                         author != q.author) |> as.character()

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
  results[1,"K"] = candidate.name
  results[1,"Q"] = q.name

  if(candidate.name == q.author){

    results[1,"target"] = TRUE

  }else{

    results[1,"target"] = FALSE

  }

  results[1,"score"] = round(lambda, 3)

  return(results)

}
