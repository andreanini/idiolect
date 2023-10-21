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
RBI <- function(x, qs, candidates, cand.imps, k){

  q.name = as.character(x["q"])
  q = quanteda::dfm_subset(qs, quanteda::docnames(qs) == q.name)

  candidate.name = as.character(x["candidate"])
  candidate = quanteda::dfm_subset(candidates, author == candidate.name &
                                               quanteda::docnames(candidates) != q.name)

  r = k/5
  r.imps = k/10
  score.sum = 0
  feats <- c()

  if(k >= nrow(cand.imps)){

    warning("K is greater than or equal to the number of available impostors.")

  }

  for(i in 1:nrow(candidate)){

    cons.k = candidate[i,]

    if(k < nrow(cand.imps)){

      cons.imps = most_similar(cons.k, cand.imps, k)

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

      ranking = minmax(f.m, f.q)

      k.rank = ranking[quanteda::docnames(cons.k)] |>  as.numeric()

      score = score + 1/(r*k.rank)

    }

    feats <- c(feats, important_features(q, cons.k, cons.imps))

    score.sum = score.sum + score

  }

  final.score = round(score.sum/nrow(candidate), 3)
  final.feats <- unique(feats)

  results = data.frame()
  results[1,"candidate"] = quanteda::docvars(candidate[1,], "author")
  results[1,"q"] = quanteda::docnames(q)

  if(quanteda::docvars(candidate[1,], "author") == quanteda::docvars(q, "author")){

    results[1,"target"] = TRUE

  }else{

    results[1,"target"] = FALSE

  }

  results[1,"score"] = final.score
  results[1, "features"] = paste(final.feats, collapse = "|")

  return(results)

}
KGI <- function(x, qs, candidates, cand.imps){

  q.name = as.character(x["q"])
  q = quanteda::dfm_subset(qs, quanteda::docnames(qs) == q.name)

  candidate.name = as.character(x["candidate"])
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
IM <- function(x, qs, candidates, cand.imps, q.imps, m, n){

  q.name = as.character(x["q"])
  q = quanteda::dfm_subset(qs, quanteda::docnames(qs) == q.name)

  candidate.name = as.character(x["candidate"])
  candidate = quanteda::dfm_subset(candidates, author == candidate.name &
                                               quanteda::docnames(candidates) != q.name)

  score_a = 0

  candidate |>
    most_similar(cand.imps, m) |>
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
    most_similar(q.imps, m) |>
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
#' @param candidates The `quanteda` dfm containing the data belonging to the candidate authors to test.
#' @param algorithm A string specifying which impostors algorithm to use, either "RBI", "KGI", or "IM".
#' @param k The *k* parameters for the RBI algorithm. Not used by other algorithms. The default is 300.
#' @param m The *m* parameter for the IM algorithm. Not used by other algorithms. The default is 100.
#' @param qs The `quanteda` dfm containing the disputed texts to test. With the exception of the "IM" algorithm, this data frame can contain the same texts that are also in the candidate data frame, for example, for leave-one-out testing.
#' @param cand.imps The `quanteda` dfm containing the impostors (or only the impostors for the candidate data if the algorithm is IM)
#' @param q.imps The `quanteda` dfm containing the impostors for the disputed text (only applicable for the IM algorithm)
#' @param cores The number of cores to use for parallel processing (the default is one).
#' @param n The *n* parameter for the IM algorithm. Not used by other algorithms. The default is 25.
#'
#' @return The function will test all possible combinations of q texts and candidate authors and return a
#' data frame containing the score ranging from 0 to 1 representing the degree of confidence that the candidate is the author of the Q text. The data frame contains a column called "target" with a logical value which is TRUE if the author of the Q text is the candidate and FALSE otherwise. If the RBI algorithm is selected then the data frame will also contain a column with the features that are likely to have had an impact on the score.
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
impostors = function(qs, candidates, cand.imps, q.imps, algorithm = "RBI", k = 300, m = 100, n = 25, cores = NULL){

  q.list <- rownames(qs)
  candidate.authors <- quanteda::docvars(candidates, "author") |> unique()

  tests <- expand.grid(q.list, candidate.authors, stringsAsFactors = F) |>
    dplyr::rename(q = Var1, candidate = Var2)


  if(algorithm == "RBI"){

    results = pbapply::pbapply(tests, 1, RBI, qs, candidates, cand.imps, k, cl = cores)

  }

  if(algorithm == "KGI"){

    results = pbapply::pbapply(tests, 1, KGI, qs, candidates, cand.imps, cl = cores)

  }

  if(algorithm == "IM"){

    if(nrow(candidates) > length(candidate.authors)){

      stop("The IM algorithm can only be applied in the case of one single candidate sample.\n")

    }

    results = pbapply::pbapply(tests, 1, IM, qs, candidates, cand.imps, q.imps, m, n, cl = cores)

  }


  results.table = list_to_df(results)

  return(results.table)

}
