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

  final.features <- important.features |> sort(decreasing = T)

  to.return <- names(final.features[final.features > 1]) |> unique()

  return(to.return)

}
RBI <- function(x, qs, candidates, cand.imps, coefficient, k, features){

  q.name = as.character(x["Q"])
  q = quanteda::dfm_subset(qs, quanteda::docnames(qs) == q.name)

  candidate.name = as.character(x["K"])
  candidate = quanteda::dfm_subset(candidates, author == candidate.name &
                                     quanteda::docnames(candidates) != q.name)

  cand.imps <- quanteda::dfm_subset(cand.imps, author != candidate.name &
                                      author != quanteda::docvars(q, "author"))

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
  results[1,"K"] = quanteda::docvars(candidate[1,], "author")
  results[1,"Q"] = quanteda::docnames(q)

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

  cand.imps <- quanteda::dfm_subset(cand.imps, author != candidate.name &
                                      author != quanteda::docvars(q, "author"))

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
  results[1,"K"] = quanteda::docvars(candidate[1,], "author")
  results[1,"Q"] = quanteda::docnames(q)

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

  cand.imps <- quanteda::dfm_subset(cand.imps, author != candidate.name &
                                      author != quanteda::docvars(q, "author"))

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
  results[1,"K"] = quanteda::docvars(candidate[1,], "author")
  results[1,"Q"] = quanteda::docnames(q)

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
#' This function runs the *Impostors Method* for authorship verification. The Impostors Method is based on calculating a similarity score and then, using a corpus of impostor texts, perform a bootstrapping analysis sampling random subsets of features and impostors in order to test the robustness of this similarity.
#'
#' The Impostors Method has been implemented in several algorithms and this function can run three of them:
#'
#' 1) IM: this is the original Impostors Method as proposed by Koppel and Winter (2014).
#' 2) KGI: Kestemont's et al. (2016) version, which is a very popular implementation of the Impostors Method for stylometricians. It is inspired by IM and by its generalized version, the General Impostors Method proposed by Seidman (2013) but it is different in several ways.
#' 3) RBI: the Rank-Based Impostors Method (Potha and Stamatatos 2017, 2020), which is the default option as it is currently the latest version that has been tested against older variants and found to be more successful.
#' The two data sets `q.data`, `k.data`, must be disjunct in terms of the texts that they contain otherwise an error is returned. However, `cand.imps` and `k.data` can be the same object, for example, to use the other candidates' texts as impostors. The function will always exclude impostor texts with the same author as the Q and K texts considered.
#'
#' @param q.data The questioned or disputed data, either as a corpus (the output of [create_corpus()]) or as a `quanteda` dfm (the output of [vectorize()]).
#' @param k.data The known or undisputed data, either as a corpus (the output of [create_corpus()]) or as a `quanteda` dfm (the output of [vectorize()]). More than one sample for a candidate author is accepted for all algorithms except IM.
#' @param cand.imps The impostors data for the candidate authors, either as a corpus (the output of [create_corpus()]) or as a `quanteda` dfm (the output of [vectorize()]). This can be the same object as `k.data` (e.g. to recycle impostors).
#' @param algorithm A string specifying which impostors algorithm to use, either "RBI" (deafult), "KGI", or "IM".
#' @param coefficient A string indicating the coefficient to use, either "minmax" (default) or "cosine". This does not apply to the algorithm KGI, where the distance is "minmax".
#' @param k The *k* parameters for the RBI algorithm. Not used by other algorithms. The default is 300.
#' @param m The *m* parameter for the IM algorithm. Not used by other algorithms. The default is 100.
#' @param n The *n* parameter for the IM algorithm. Not used by other algorithms. The default is 25.
#' @param features A logical value indicating whether the important features should be retrieved or not. The default is FALSE. This only applies to the RBI algorithm.
#' @param cores The number of cores to use for parallel processing (the default is one).
#'
#' @references Kestemont, Mike, Justin Stover, Moshe Koppel, Folgert Karsdorp & Walter Daelemans. 2016. Authenticating the writings of Julius Caesar. Expert Systems With Applications 63. 86–96. https://doi.org/10.1016/j.eswa.2016.06.029.
#' Koppel, Moshe & Yaron Winter. 2014. Determining if two documents are written by the same author. Journal of the Association for Information Science and Technology 65(1). 178–187.
#' Potha, Nektaria & Efstathios Stamatatos. 2017. An Improved Impostors Method for Authorship Verification. In Gareth J.F. Jones, Séamus Lawless, Julio Gonzalo, Liadh Kelly, Lorraine Goeuriot, Thomas Mandl, Linda Cappellato & Nicola Ferro (eds.), Experimental IR Meets Multilinguality, Multimodality, and Interaction (Lecture Notes in Computer Science), vol. 10456, 138–144. Springer, Cham. https://doi.org/10.1007/978-3-319-65813-1_14. (5 September, 2017).
#' Potha, Nektaria & Efstathios Stamatatos. 2020. Improved algorithms for extrinsic author verification. Knowledge and Information Systems 62(5). 1903–1921. https://doi.org/10.1007/s10115-019-01408-4.
#' Seidman, Shachar. 2013. Authorship Verification Using the Impostors Method. In Pamela Forner, Roberto Navigli, Dan Tufis & Nicola Ferro (eds.), Proceedings of CLEF 2013 Evaluation Labs and Workshop – Working Notes Papers, 23–26. Valencia, Spain. https://ceur-ws.org/Vol-1179/.
#'
#' @return The function will test all possible combinations of q texts and candidate authors and return a
#' data frame containing a score ranging from 0 to 1, with a higher score indicating a higher likelihood that the same author produced the two sets of texts. The data frame contains a column called "target" with a logical value which is TRUE if the author of the Q text is the candidate and FALSE otherwise.
#'
#' If the RBI algorithm is selected and the features parameter is TRUE then the data frame will also contain a column with the features that are likely to have had an impact on the score. This algorithm has not been tested and the results should therefore be treated with care. The algorithm returns all those features that are consistently found to be shared by the candidate author's data and the questioned data and that also tend to be rare in the data set of impostors.
#'
#' @examples
#' q <- refcor.sample[1]
#' ks <- refcor.sample[2:3]
#' imps <- refcor.sample[4:9]
#' impostors(q, ks, imps, algorithm = "KGI")
#'
#' @export
impostors = function(q.data, k.data, cand.imps, algorithm = "RBI", coefficient = "minmax", k = 300, m = 100, n = 25, features = F, cores = NULL){

  q.list <- quanteda::docnames(q.data)
  k.list <- quanteda::docvars(k.data, "author") |> unique()

  tests <- expand.grid(q.list, k.list, stringsAsFactors = F) |>
    dplyr::rename(Q = Var1, K = Var2)




  if(quanteda::is.corpus(q.data)&quanteda::is.corpus(k.data)&quanteda::is.corpus(cand.imps)){

    # this condition allows for the impostors being just the rest of the K data
    if(identical(cand.imps, k.data)){

      all.data <- c(q.data, k.data)

    }else{

      all.data <- c(q.data, k.data, cand.imps)

    }

    if(algorithm == "RBI"){

      df = vectorize(all.data,
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

    }

    if(algorithm == "KGI"){

      df = vectorize(all.data,
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

    }

    if(algorithm == "IM"){

      df = vectorize(all.data,
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

    }


  }else if(quanteda::is.dfm(q.data)&quanteda::is.dfm(k.data)&quanteda::is.dfm(cand.imps)){

    if(algorithm == "RBI"){

      results = pbapply::pbapply(tests, 1, RBI,
                                 qs = q.data,
                                 candidates = k.data,
                                 cand.imps = cand.imps,
                                 coefficient, k, features, cl = cores)

    }

    if(algorithm == "KGI"){

      results = pbapply::pbapply(tests, 1, KGI,
                                 qs = q.data,
                                 candidates = k.data,
                                 cand.imps = cand.imps,
                                 cl = cores)
    }

    if(algorithm == "IM"){

      results = pbapply::pbapply(tests, 1, IM,
                                 qs = q.data,
                                 candidates = k.data,
                                 cand.imps = cand.imps,
                                 coefficient, m, n, cl = cores)

    }


  }else{
    stop("The Q, K, and impostors objects need to be either quanteda corpora or quanteda dfms.")
  }


  results.table = list_to_df(results)

  return(results.table)

}
