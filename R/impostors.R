minmax = function(m, q){

  dist = proxy::dist(x = as.matrix(m), y = as.matrix(q), method = "fJaccard")
  ranking = rank(as.matrix(dist)[,1], ties.method = "min") |>  sort()

  return(ranking)

}
top_imps = function(k.sample, poss.imps, n){

  if(nrow(k.sample) > 1){

    stop("Multiple K samples in the top_imps function\n")

  }

  ranking = minmax(poss.imps, k.sample)
  imp.list = names(ranking[1:n])
  imps = quanteda::dfm_subset(poss.imps, quanteda::docnames(poss.imps) %in% imp.list)

  return(imps)

}
RBI = function(x, qs, candidate, cand.imps, k){

  q = qs[x,]

  r = k/5
  r.imps = k/10
  score.sum = 0

  for(i in 1:nrow(candidate)){

    cons.k = candidate[i,]

    score = 0

    for(j in 1:r){

      cons.imps = top_imps(cons.k, cand.imps, k)

      #r impostors
      cons.imps.f = quanteda::dfm_sample(cons.imps, size = r.imps)

      #50% of features
      feats.n = ncol(q)*0.5
      s = sample(colnames(q), feats.n)
      f.q = quanteda::dfm_match(q, s)

      #combining k and imps
      f.m = quanteda::dfm_match(rbind(cons.k, cons.imps.f), s)

      ranking = minmax(f.m, f.q)

      k.rank = ranking[quanteda::docnames(cons.k)] |>  as.numeric()

      score = score + 1/(r*k.rank)

    }

    score.sum = score.sum + score

  }

  final.score = round(score.sum/nrow(candidate), 3)

  results = data.frame()
  results[1,"candidate"] = quanteda::docvars(candidate[1,], "author")
  results[1,"q"] = quanteda::docnames(q)

  if(quanteda::docvars(candidate[1,], "author") == quanteda::docvars(q, "author")){

    results[1,"target"] = TRUE

  }else{

    results[1,"target"] = FALSE

  }

  results[1,"score"] = final.score

  return(results)

}
KGI = function(x, qs, candidate, cand.imps){

  q = qs[x,]

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
IM = function(x, qs, candidate, cand.imps, q.imps, m, n){

  q = qs[x,]

  score_a = 0

  candidate |>
    top_imps(cand.imps, m) |>
    quanteda::dfm_sample(n) -> cons.imps.f

  for (i in 1:100) {

    #50% of features
    feats.n = ncol(q)*0.5
    s = sample(colnames(q), feats.n)
    f.q = quanteda::dfm_match(q, s)

    #combining k and imps
    f.m = quanteda::dfm_match(rbind(candidate, cons.imps.f), s)

    ranking = minmax(f.m, f.q)

    rank = ranking[quanteda::docnames(candidate)] |>  as.numeric()

    if(rank == 1) { score_a = score_a + 0.01 }

  }


  score_b = 0

  q |>
    top_imps(q.imps, m) |>
    quanteda::dfm_sample(n) -> cons.imps.f

  for (i in 1:100) {

    #50% of features
    feats.n = ncol(candidate)*0.5
    s = sample(colnames(candidate), feats.n)
    f.k = quanteda::dfm_match(candidate, s)

    #combining q and imps
    f.m = quanteda::dfm_match(rbind(q, cons.imps.f), s)

    ranking = minmax(f.m, f.k)

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
#' This function runs the authorship verification method *Impostors Method*.
#'
#' More details here.
#'
#' @param candidate The `quanteda` dfm containing the data belonging to the candidate author.
#' @param algorithm A string specifying which impostors algorithm to use, either "RBI", "KGI", or "IM".
#' @param k The *k* parameters for the RBI algorithm. Not used by other algorithms. The default is 300.
#' @param m The *m* parameter for the IM algorithm. Not used by other algorithms. The default is 100.
#' @param qs The `quanteda` dfm containing the disputed texts.
#' @param cand.imps The `quanteda` dfm containing the impostors (or only the impostors for the candidate data if the algorithm is IM)
#' @param q.imps The `quanteda` dfm containing the impostors for the disputed text (only applicable for the IM algorithm)
#' @param cores The number of cores to use for parallel processing (the default is one).
#' @param n The *n* parameter for the IM algorithm. Not used by other algorithms. The default is 25.
#'
#' @return A data frame containing the score ranging from 0 to 1 representing the degree of confidence that the candidate is the author of the Q text. The data frame contains a column called "target" with a logical value which is TRUE if the author of the Q text is the candidate and FALSE otherwise.
#' @export
#'
#' @examples
#' library(quanteda)
#' text1 <- "The cat sat on the mat."
#' text2 <- "The dog sat on the mat."
#' k.corpus <-  corpus(c(text1, text2))
#' k.dfm <- dfm(tokens(k.corpus)) |> dfm_weight(scheme = "prop")
#' docvars(k.dfm, "author") <- "K"
#'
#' imp1 <- "A pet, such as a cat or a dog, is an animal kept primarily for a person's company."
#' imp2 <- "Some pets may be accepted by the owner regardless of these characteristics."
#' imp.corpus <- corpus(c(imp1, imp2))
#' imp.dfm <- dfm(tokens(imp.corpus)) |> dfm_weight(scheme = "prop")
#' docvars(imp.dfm, "author") <- "wikipedia"
#'
#' q <- "The dog sat on the chair."
#' q.dfm <- dfm(tokens(q)) |> dfm_weight(scheme = "prop")
#' docvars(q.dfm, "author") <- "Q"
#'
#' #note how all the dfms must have the same columns
#' imp.dfm <- dfm_match(imp.dfm, featnames(k.dfm))
#' q.dfm <- dfm_match(q.dfm, featnames(k.dfm))
#'
#' results <- impostors(q.dfm, k.dfm, imp.dfm, algorithm = "KGI")
impostors = function(qs, candidate, cand.imps, q.imps, algorithm = "RBI", k = 300, m = 100, n = 25, cores = NULL){

  if(algorithm == "RBI"){

    results = pbapply::pblapply(as.list(1:nrow(qs)), RBI, qs, candidate, cand.imps, k, cl = cores)

  }

  if(algorithm == "KGI"){

    results = pbapply::pblapply(as.list(1:nrow(qs)), KGI, qs, candidate, cand.imps, cl = cores)

  }

  if(algorithm == "IM"){

    if(nrow(candidate) > 1){

      stop("The IM algorithm can only be applied in the case of one single candidate sample.\n")

    }

    results = pbapply::pblapply(as.list(1:nrow(qs)), IM, qs, candidate, cand.imps, q.imps, m, n, cl = cores)

  }


  results.table = list_to_df(results)

  return(results.table)

}
