overlap <- function(m1, m2, rest.m){

  m <- rbind(m1, m2)

  overlap <- quanteda::dfm_trim(m, min_docfreq = 2) |> quanteda::featnames()

  to.remove <- quanteda::dfm_trim(rest.m, min_docfreq = 1) |> quanteda::featnames()

  unique.overlap <- overlap[!(overlap %in% to.remove)]


  if(stringr::str_detect(paste(unique.overlap, collapse = " "), "_")){

    # this means it's word n-grams

    unique.overlap |>
      as.data.frame() |>
      dplyr::mutate(length = stringr::str_count(`unique.overlap`, "_")) |>
      dplyr::arrange(dplyr::desc(length)) |>
      dplyr::pull(`unique.overlap`) |>
      paste(collapse = "|") -> output

  }else{

    # this is for char n-grams

    unique.overlap |>
      as.data.frame() |>
      dplyr::mutate(length = stringr::str_count(`unique.overlap`, stringr::regex("."))) |>
      dplyr::arrange(dplyr::desc(length)) |>
      dplyr::pull(`unique.overlap`) |>
      paste(collapse = "|") -> output

  }

  return(output)

}
similarity <- function(x, df, coefficient, features){

  q.name = as.character(x["Q"])
  q = quanteda::dfm_subset(df, quanteda::docnames(df) == q.name)

  k.name = as.character(x["K"])
  k = quanteda::dfm_subset(df, author == k.name &
                             quanteda::docnames(df) != q.name) |>
    quanteda::dfm_group(author) |>
    quanteda::dfm_weight(scheme = "boolean", force = T)

  if(features == T){

    rest <- quanteda::dfm_subset(df, quanteda::docnames(df) != q.name & author != k.name)
    quanteda::docvars(rest, "author") <- "rest"
    rest.m <- quanteda::dfm_group(rest, author) |> quanteda::dfm_weight("boolean", force = T)

  }

  a = as.double(suppressMessages(length(q[q & k])))
  b = as.double(suppressMessages(length(q[q == 1])) - a)
  c = as.double(suppressMessages(length(k[k == 1])) - a)
  p = as.double(ncol(k))
  d = as.double(p - (a+b+c))

  if(coefficient == "simpson"){ score = round(a/(a+b), 3)}
  if(coefficient == "phi"){ score = round((a*d - b*c)/sqrt((a+b)*(a+c)*(c+d)*(b+d)), 3)}
  if(coefficient == "jaccard"){ score = round(a/(a+b+c), 3)}
  if(coefficient == "kulczynski"){ score = round(((a/(a+b))+(a/(a+c)))/2, 3)}
  if(coefficient == "cole"){ score = round((a*d - b*c)/((a+b)*(b+d)), 3)}

  results = data.frame()
  results[1,"Q"] = q.name
  results[1,"K"] = k.name

  if(quanteda::docvars(k, "author") == quanteda::docvars(q, "author")){

    results[1,"target"] = TRUE

  }else{

    results[1,"target"] = FALSE

  }

  results[1,"score"] = score

  if(features == T){

    results[1, "unique_overlap"] = overlap(q, k, rest.m)

  }

  return(results)

}
#' N-gram tracing
#'
#' This function performs n-gram tracing.
#'
#' @param q.data The questioned or disputed data, either as a corpus (the output of [create_corpus()]) or as a `quanteda` dfm (the output of [vectorize()]).
#' @param k.data The known or undisputed data, either as a corpus (the output of [create_corpus()]) or as a `quanteda` dfm (the output of [vectorize()]). More than one sample for a candidate author is accepted but the function will combine them so to make a profile.
#' @param tokens The type of tokens to extract, either "word" or "character" (default).
#' @param remove_punct A logical value. FALSE (default) keeps punctuation marks.
#' @param remove_symbols A logical value. TRUE (default) removes symbols.
#' @param remove_numbers A logical value. TRUE (default) removes numbers.
#' @param lowercase A logical value. TRUE (default) transforms all tokens to lower case.
#' @param n The order or size of the n-grams being extracted. Default is 9.
#' @param coefficient The coefficient to use to compare texts, one of: "simpson" (default), "phi", "jaccard", "kulczynski", or "cole".
#' @param cores The number of cores to use for parallel processing (the default is one).
#' @param features Logical with default FALSE. If TRUE then the result table will contain the features in the overlap that are unique for that overlap in the corpus.
#'
#' @return The function will test all possible combinations of q texts and candidate authors and return a
#' data frame containing the value of the similarity coefficient selected called 'score' and an optional column with the overlapping features that only occur in the Q and candidate considered and in no other Qs (ordered by length if the n-gram is of variable length). The data frame contains a column called 'target' with a logical value which is TRUE if the author of the Q text is the candidate and FALSE otherwise.
#' @export
#'
#' @examples
#' qs <- refcor.sample[c(1, 4, 7)]
#' ks <- refcor.sample[-c(1, 4, 7)]
#' ngram_tracing(qs, ks, coefficient = 'simpson')
ngram_tracing <- function(q.data, k.data, tokens = "character", remove_punct = F, remove_symbols = T, remove_numbers = T, lowercase = T, n = 9, coefficient = "simpson", features = F, cores = NULL){

  if(quanteda::is.corpus(q.data) & quanteda::is.corpus(k.data)){

    df = vectorize(c(q.data, k.data), tokens = tokens, remove_punct = remove_punct,
                  remove_symbols = remove_symbols, remove_numbers = remove_numbers, lowercase = lowercase,
                  n = n, weighting = "boolean", trim = F)

  }else if(quanteda::is.dfm(q.data) & quanteda::is.dfm(k.data)){

    df <- rbind(q.data, k.data)

  }else{

    stop("The Q and K objects need to be either quanteda corpora or quanteda dfms.")

  }

  q.list <- quanteda::docnames(q.data)
  k.list <- quanteda::docvars(k.data, "author") |> unique()

  tests <- expand.grid(q.list, k.list, stringsAsFactors = F) |>
    dplyr::rename(Q = Var1, K = Var2)

  results <- pbapply::pbapply(tests, 1, similarity, df, coefficient, features, cl = cores)

  results.table = list_to_df(results)

  return(results.table)

}
