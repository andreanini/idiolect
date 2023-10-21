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
similarity <- function(x, qs, candidates, coefficient, features){

  q.name = as.character(x["q"])
  q = quanteda::dfm_subset(qs, quanteda::docnames(qs) == q.name) |>
    quanteda::dfm_weight(scheme = "boolean", force = T)

  candidate.name = as.character(x["candidate"])
  k = quanteda::dfm_subset(candidates, author == candidate.name &
                             quanteda::docnames(candidates) != q.name) |>
    quanteda::dfm_group(author) |>
    quanteda::dfm_weight(scheme = "boolean", force = T)

  # this condition is needed in case there is only one Q text
  if(nrow(qs) > 1){

    rest <- quanteda::dfm_subset(qs, quanteda::docnames(qs) != q.name &
                                   !(quanteda::docnames(qs) %in% quanteda::docnames(candidates)))
    quanteda::docvars(rest, "author") <- "rest"
    rest.m <- quanteda::dfm_group(rest, author) |> quanteda::dfm_weight("boolean", force = T)

  }else{

    rest.m <- matrix(c(0, 0)) |> quanteda::as.dfm()

  }




  if(coefficient == "Phi"){

    score <- quanteda.textstats::textstat_simil(k, q, method = "correlation") |>
      suppressMessages()

  }

  # a = as.double(suppressMessages(length(q[q & k])))
  # b = as.double(suppressMessages(length(q[q == 1])) - a)
  # c = as.double(suppressMessages(length(k[k == 1])) - a)
  # p = as.double(ncol(k))
  # d = as.double(p - (a+b+c))
  #
  # results[i-1, 'matching'] = round((a+d)/p, 4)
  # results[i-1, 'overlap'] = round(a/(a+b), 4)
  # results[i-1, 'phi'] = round((a*d - b*c)/sqrt((a+b)*(a+c)*(c+d)*(b+d)), 4)
  # results[i-1, 'jaccard'] = round(a/(a+b+c), 4)
  # results[i-1, 'rao'] = round(a/p, 4)
  # results[i-1, 'sokal_sneath'] = round((a/sqrt((a+b)*(a+c)))*(d/sqrt((d+b)*(d+c))), 4)
  # results[i-1, 'cohen'] = round((2*(a*d - b*c))/(((a+b)*(b+d))+((a+c)*(c+d))), 4)
  # results[i-1, 'ochiai'] = round(a/sqrt((a+b)*(a+c)), 4)
  # results[i-1, 'kulczynski'] = round(((a/(a+b))+(a/(a+c)))/2, 4)
  # results[i-1, 'dice'] = round(2*a/(2*a + b + c), 4)
  # results[i-1, 'mountford'] = round(2*a/(a*b + a*c + 2*b*c), 4)
  # results[i-1, 'rogot_goldberg'] = round((a/(2*a + b + c))+(d/(2*d + b +c)), 4)
  # results[i-1, 'hawkins_dotson'] = round(((a/(a+b+c))+(d/(b+c+d)))/2, 4)
  # results[i-1, 'sorgenfrei'] = round(a**2/((a+b)*(a+c)), 4)
  # results[i-1, 'ct3'] = round(log(1+a)/log(1+p), 4)
  # results[i-1, 'log_overlap'] = round(log(1+a)/log(1+b), 4)
  # results[i-1, 'bub'] = round((sqrt(a*d)+a)/(sqrt(a*d)+a+b+c), 4)
  # results[i-1, 'cole'] = round((a*d - b*c)/((a+b)*(b+d)), 4)
  # results[i-1, 'ct5'] = round((log(1 + a*d) - log(1 + b*c))/log(1 + p**2/4), 4)
  # results[i-1, 'gk'] = round((2 * min(a, d) - b - c)/(2 * min(a, d) + b + c), 4)
  # results[i-1, 'loevinger'] = round((a*d - b*c)/min(b * (b+d), c * (c+d)), 4)
  # results[i-1, 'yule'] = round((a*d - b*c)/(a*d + b*c), 4)

  results = data.frame()
  results[1,"candidate"] = quanteda::docvars(k, "author")
  results[1,"q"] = quanteda::docnames(q)

  if(quanteda::docvars(k, "author") == quanteda::docvars(q, "author")){

    results[1,"target"] = TRUE

  }else{

    results[1,"target"] = FALSE

  }

  results[1,"score"] = as.numeric(score)

  if(features == T){

    results[1, "overlap"] = overlap(q, k, rest.m)

  }

  return(results)

}
#' N-gram tracing
#'
#' This function performs n-gram tracing.
#'
#' @param qs The `quanteda` dfm containing the disputed texts to test.
#' @param candidates The `quanteda` dfm containing the data belonging to the candidate authors to test. This dfm can contain multiple samples but these will then be concatenated into one profile. This dfm can potentially contain the same rows as in q (e.g. for leave-one-out testing) as these are removed when identical.
#' @param coefficient The coefficient to use to compare texts.
#' @param cores The number of cores to use for parallel processing (the default is one).
#' @param features Logical with default FALSE. If TRUE then the result table will contain the features in the overlap.
#'
#' @return The function will test all possible combinations of q texts and candidate authors and return a
#' data frame containing the value of the similarity coefficient selected called 'score' and an optional column with the overlapping features that only occur in the Q and candidate considered and in no other Qs (ordered by length if the n-gram is of variable length). The data frame contains a column called 'target' with a logical value which is TRUE if the author of the Q text is the candidate and FALSE otherwise.
#' @export
#'
#' @examples
#' library(quanteda)
#'
#' text1 <- 'The cat sat on the mat.'
#' k.corpus <-  corpus(text1)
#' k.dfm <- dfm(tokens(k.corpus))
#' docvars(k.dfm, 'author') <- 'K'
#'
#' q <- 'The dog sat on the chair?'
#' q.dfm <- dfm(tokens(q))
#' docvars(q.dfm, 'author') <- 'Q'
#' docnames(q.dfm) <- 'Qtext' # document names should be distinct across all dfms used as input
#'
#' ngram_tracing(q.dfm, k.dfm, 'Phi')
ngram_tracing <- function(qs, candidates, coefficient, features = F, cores = NULL){

  q.list <- rownames(qs)
  candidate.authors <- quanteda::docvars(candidates, "author") |> unique()

  tests <- expand.grid(q.list, candidate.authors, stringsAsFactors = F) |>
    dplyr::rename(q = Var1, candidate = Var2)

  results <- pbapply::pbapply(tests, 1, similarity, qs, candidates, coefficient, features, cl = cores)

  results.table = list_to_df(results)

  return(results.table)

}
