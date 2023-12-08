minmax_overlap <- function(m1, m2){

  m <- rbind(m1, m2)

  mins <- apply(m, 2, min)
  maxs <- apply(m, 2, max)

  ratios <- mins/maxs

  return(ratios)

}
important_features <- function(q, candidate, impostors){

  important.features = c()

  for(i in 1:nrow(candidate)){

    cand.overlap <- minmax_overlap(q, candidate[i,])

    imp.means <- quanteda::colMeans(impostors)
    imp.matrix <- quanteda::as.dfm(t(as.matrix(imp.means)))

    imp.overlap <- minmax_overlap(q, imp.matrix)

    odds <- cand.overlap/imp.overlap

    temp <- odds[is.na(odds) == F & odds != 0]

    important.features <- c(important.features, temp)

  }

  final.features <- important.features |> sort(decreasing = T) |> names() |> unique()

  return(final.features[1:10])

}
RBI <- function(x, qs, candidates, cand.imps, coefficient, k, features){

  q.name = as.character(x["Q"])
  q = quanteda::dfm_subset(qs, quanteda::docnames(qs) == q.name)

  candidate.name = as.character(x["K"])
  candidate = quanteda::dfm_subset(candidates, author == candidate.name &
                                               quanteda::docnames(candidates) != q.name)

  f <- get(coefficient)
  r = k/5
  r.imps = k/10
  score.sum = 0
  feats <- c()

  if(k >= nrow(cand.imps)){

    warning("The k parameter is greater than or equal to the number of available impostors.")

  }

  for(i in 1:nrow(candidate)){

    cons.k = candidate[i,]

    if(k < nrow(cand.imps)){

      cons.imps = most_similar(cons.k, cand.imps, coefficient, k)

    }else{

      cons.imps = cand.imps

    }


    score = 0

    for(j in 1:r){

      #r impostors
      cons.imps.f = quanteda::dfm_sample(cons.imps, size = r.imps)

      #50% of features
      feats.n = ncol(q)*0.5
      s = sample(colnames(q), feats.n)
      f.q = quanteda::dfm_match(q, s)

      #combining k and imps
      f.m = quanteda::dfm_match(rbind(cons.k, cons.imps.f), s)

      ranking = f(f.m, f.q)

      k.rank = ranking[quanteda::docnames(cons.k)] |>  as.numeric()

      score = score + 1/(r*k.rank)

    }

    if(features == T) { feats <- c(feats, important_features(q, cons.k, cons.imps)) }

    score.sum = score.sum + score

  }

  final.score = round(score.sum/nrow(candidate), 3)
  if(features == T) { final.feats <- unique(feats) }

  results = data.frame()
  results[1,"candidate"] = quanteda::docvars(candidate[1,], "author")
  results[1,"q"] = quanteda::docnames(q)

  if(quanteda::docvars(candidate[1,], "author") == quanteda::docvars(q, "author")){

    results[1,"target"] = TRUE

  }else{

    results[1,"target"] = FALSE

  }

  results[1,"score"] = final.score

  if(features == T) { results[1, "features"] = paste(final.feats, collapse = "|") }

  return(results)

}
KGI <- function(x, qs, candidates, cand.imps){

  q.name = as.character(x["Q"])
  q = quanteda::dfm_subset(qs, quanteda::docnames(qs) == q.name)

  candidate.name = as.character(x["K"])
  candidate = quanteda::dfm_subset(candidates, author == candidate.name &
                                               quanteda::docnames(candidates) != q.name)

  score = 0
  r.imps = nrow(cand.imps)/2

  for (i in 1:100) {

    #r impostors
    cons.imps.f = quanteda::dfm_sample(cand.imps, size = r.imps)

    #50% of features
    feats.n = ncol(q)*0.5
    s = sample(colnames(q), feats.n)
    f.q = quanteda::dfm_match(q, s)

    #reducing k
    f.k = quanteda::dfm_match(candidate, s)

    #reducing imps
    f.i = quanteda::dfm_match(cons.imps.f, s)

    k.dist = proxy::dist(x = as.matrix(f.k), y = as.matrix(f.q), method = "fJaccard")
    min.k = min(k.dist)

    i.dist = proxy::dist(x = as.matrix(f.i), y = as.matrix(f.q), method = "fJaccard")
    min.i = min(i.dist)

    if(min.k < min.i){

      score = score + 0.01

    }

  }

  score = round(score, 3)

  results = data.frame()
  results[1,"candidate"] = quanteda::docvars(candidate[1,], "author")
  results[1,"q"] = quanteda::docnames(q)

  if(quanteda::docvars(candidate[1,], "author") == quanteda::docvars(q, "author")){

    results[1,"target"] = TRUE

  }else{

    results[1,"target"] = FALSE

  }

  results[1,"score"] = score

  return(results)

}
IM <- function(x, qs, candidates, cand.imps, coefficient, m, n){

  q.name = as.character(x["Q"])
  q = quanteda::dfm_subset(qs, quanteda::docnames(qs) == q.name)

  candidate.name = as.character(x["K"])
  candidate = quanteda::dfm_subset(candidates, author == candidate.name &
                                               quanteda::docnames(candidates) != q.name)

  f <- get(coefficient)

  score_a = 0

  candidate |>
    most_similar(cand.imps, coefficient, m) |>
    quanteda::dfm_sample(n) -> cons.imps.f

  for (i in 1:100) {

    #50% of features
    feats.n = ncol(q)*0.5
    s = sample(colnames(q), feats.n)
    f.q = quanteda::dfm_match(q, s)

    #combining k and imps
    f.m = quanteda::dfm_match(rbind(candidate, cons.imps.f), s)

    ranking = f(f.m, f.q)

    rank = ranking[quanteda::docnames(candidate)] |>  as.numeric()

    if(rank == 1) { score_a = score_a + 0.01 }

  }


  score_b = 0

  q |>
    most_similar(cand.imps, coefficient, m) |>
    quanteda::dfm_sample(n) -> cons.imps.f

  for (i in 1:100) {

    #50% of features
    feats.n = ncol(candidate)*0.5
    s = sample(colnames(candidate), feats.n)
    f.k = quanteda::dfm_match(candidate, s)

    #combining q and imps
    f.m = quanteda::dfm_match(rbind(q, cons.imps.f), s)

    ranking = f(f.m, f.k)

    rank = ranking[quanteda::docnames(q)] |>  as.numeric()

    if(rank == 1) { score_b = score_b + 0.01 }

  }

  score = round(mean(c(score_a, score_b)), 3)

  results = data.frame()
  results[1,"candidate"] = quanteda::docvars(candidate[1,], "author")
  results[1,"q"] = quanteda::docnames(q)

  if(quanteda::docvars(candidate[1,], "author") == quanteda::docvars(q, "author")){

    results[1,"target"] = TRUE

  }else{

    results[1,"target"] = FALSE

  }

  results[1,"score"] = score

  return(results)

}
#' Impostors Method
#'
#' This function runs the *Impostors Method* for authorship verification.
#'
#' More details here.
#'
#' @param q.data The questioned or disputed data, either as a corpus (the output of [create_corpus()]) or as a `quanteda` dfm (the output of [vectorize()]).
#' @param k.data The known or undisputed data, either as a corpus (the output of [create_corpus()]) or as a `quanteda` dfm (the output of [vectorize()]). More than one sample for a candidate author is accepted for all algorithms except IM.
#' @param cand.imps The impostors data for the candidate authors, either as a corpus (the output of [create_corpus()]) or as a `quanteda` dfm (the output of [vectorize()]).
#' @param algorithm A string specifying which impostors algorithm to use, either "RBI", "KGI", or "IM".
#' @param coefficient A string indicating the coefficient to use, either "minmax" (default) or "cosine". This does not apply to the algorithm KGI, where the distance is "minmax".
#' @param k The *k* parameters for the RBI algorithm. Not used by other algorithms. The default is 300.
#' @param m The *m* parameter for the IM algorithm. Not used by other algorithms. The default is 100.
#' @param n The *n* parameter for the IM algorithm. Not used by other algorithms. The default is 25.
#' @param features A logical value indicating whether the important features should be retrieved or not. The default is FALSE. This only applies to the RBI algorithm.
#' @param cores The number of cores to use for parallel processing (the default is one).
#'
#' @return The function will test all possible combinations of q texts and candidate authors and return a
#' data frame containing a score ranging from 0 to 1 representing the degree of confidence that the candidate is the author of the Q text. The data frame contains a column called "target" with a logical value which is TRUE if the author of the Q text is the candidate and FALSE otherwise. If the RBI algorithm is selected and the features parameter is TRUE then the data frame will also contain a column with the features that are likely to have had an impact on the score. The three data sets, `q.data`, `k.data`, and `cand.imps` must be disjunct in terms of the texts that they contain otherwise an error is returned.
#' @export
#'
#' @examples
#' q <- refcor.sample[1]
#' ks <- refcor.sample[2:3]
#' imps <- refcor.sample[4:9]
#' impostors(q, ks, imps, algorithm = "KGI")
impostors = function(q.data, k.data, cand.imps, algorithm = "RBI", coefficient = "minmax", k = 300, m = 100, n = 25, features = F, cores = NULL){

  q.list <- quanteda::docnames(q.data)
  k.list <- quanteda::docvars(k.data, "author") |> unique()

  tests <- expand.grid(q.list, k.list, stringsAsFactors = F) |>
    dplyr::rename(Q = Var1, K = Var2)


  if(algorithm == "RBI"){

    if(quanteda::is.corpus(q.data) & quanteda::is.corpus(k.data) & quanteda::is.corpus(cand.imps)){

      df = vectorize(c(q.data, k.data, cand.imps),
                     tokens = "character", remove_punct = F, remove_symbols = T,
                     remove_numbers = T, lowercase = F,
                     n = 5, weighting = "rel", trim = T, threshold = 1500)

      results = pbapply::pbapply(tests, 1, RBI,
                                 qs = quanteda::dfm_subset(df, quanteda::docnames(df)
                                                           %in% quanteda::docnames(q.data)),
                                 candidates = quanteda::dfm_subset(df, quanteda::docnames(df)
                                                                   %in% quanteda::docnames(k.data)),
                                 cand.imps = quanteda::dfm_subset(df, quanteda::docnames(df)
                                                                  %in% quanteda::docnames(cand.imps)),
                                 coefficient, k, features, cl = cores)

    }else if(quanteda::is.dfm(q.data) & quanteda::is.dfm(k.data) & quanteda::is.dfm(cand.imps)){

      results = pbapply::pbapply(tests, 1, RBI,
                                 qs = q.data,
                                 candidates = k.data,
                                 cand.imps = cand.imps,
                                 coefficient, k, features, cl = cores)

    }else{

      stop("The Q, K, and impostors objects need to be either quanteda corpora or quanteda dfms.")

    }

  }

  if(algorithm == "KGI"){

    if(quanteda::is.corpus(q.data) & quanteda::is.corpus(k.data) & quanteda::is.corpus(cand.imps)){

      df = vectorize(c(q.data, k.data, cand.imps),
                     tokens = "character", remove_punct = F, remove_symbols = T,
                     remove_numbers = T, lowercase = F,
                     n = 4, weighting = "tf-idf", trim = F)

      results = pbapply::pbapply(tests, 1, KGI,
                                 qs = quanteda::dfm_subset(df, quanteda::docnames(df)
                                                           %in% quanteda::docnames(q.data)),
                                 candidates = quanteda::dfm_subset(df, quanteda::docnames(df)
                                                                   %in% quanteda::docnames(k.data)),
                                 cand.imps = quanteda::dfm_subset(df, quanteda::docnames(df)
                                                                  %in% quanteda::docnames(cand.imps)),
                                 cl = cores)

    }else if(quanteda::is.dfm(q.data) & quanteda::is.dfm(k.data) & quanteda::is.dfm(cand.imps)){

      results = pbapply::pbapply(tests, 1, KGI,
                                 qs = q.data,
                                 candidates = k.data,
                                 cand.imps = cand.imps,
                                 cl = cores)

    }else{

      stop("The Q, K, and impostors objects need to be either quanteda corpora or quanteda dfms.")

    }

  }

  if(algorithm == "IM"){

    if(quanteda::is.corpus(q.data) &
       quanteda::is.corpus(k.data) &
       quanteda::is.corpus(cand.imps)){

      df = vectorize(c(q.data, k.data, cand.imps),
                     tokens = "character", remove_punct = F, remove_symbols = T,
                     remove_numbers = T, lowercase = F,
                     n = 4, weighting = "tf-idf", trim = F)

      results = pbapply::pbapply(tests, 1, IM,
                                 qs = quanteda::dfm_subset(df, quanteda::docnames(df) %in%
                                                             quanteda::docnames(q.data)),
                                 candidates = quanteda::dfm_subset(df, quanteda::docnames(df) %in%
                                                                     quanteda::docnames(k.data)),
                                 cand.imps = quanteda::dfm_subset(df, quanteda::docnames(df) %in%
                                                                    quanteda::docnames(cand.imps)),
                                 coefficient, m, n, cl = cores)

    }else if(quanteda::is.dfm(q.data) &
             quanteda::is.dfm(k.data) &
             quanteda::is.dfm(cand.imps)){


      results = pbapply::pbapply(tests, 1, IM,
                                 qs = q.data,
                                 candidates = k.data,
                                 cand.imps = cand.imps,
                                 coefficient, m, n, cl = cores)
    }else{

      stop("The Q, K, and impostors objects need to be either quanteda corpora or quanteda dfms.")

    }

  }

  results.table = list_to_df(results)

  return(results.table)

}
