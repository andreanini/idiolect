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
