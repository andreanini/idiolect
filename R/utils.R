list_to_df = function(list){

  final.df = do.call(rbind.data.frame, list) |>  as.data.frame()

  return(final.df)

}
detokenize <- function(tok){

  meta <- quanteda::docvars(tok)

  sapply(tok, function(x) { paste(x, collapse = " ") }) |> quanteda::corpus() -> c

  quanteda::docvars(c) <- meta

  return(c)
}
minmax <- function(m, q){

  dist = proxy::dist(x = as.matrix(m), y = as.matrix(q), method = "fJaccard")
  ranking = rank(as.matrix(dist)[,1], ties.method = "max") |>  sort()

  return(ranking)

}
phi <- function(m, q){

  bm <- quanteda::dfm_weight(m, "boolean", force = TRUE)
  bq <- quanteda::dfm_weight(q, "boolean", force = TRUE)

  score <- quanteda.textstats::textstat_simil(bm, bq, method = "correlation") |>
    suppressMessages()

  ranking <- rank(-as.matrix(score)[,1], ties.method = "max") |>  sort()

  return(ranking)

}
cosine <- function(m, q){

  score <- quanteda.textstats::textstat_simil(m, q, method = "cosine") |>
    suppressMessages()

  ranking <- rank(-as.matrix(score)[,1], ties.method = "max") |>  sort()

  return(ranking)

}
