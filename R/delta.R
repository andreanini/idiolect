cosine_delta <- function(x, z){

  a.name = as.character(x["V1"])
  a = quanteda::dfm_subset(z, quanteda::docnames(z) == a.name)
  a.author = quanteda::docvars(a, "author")

  b.name = as.character(x["V2"])
  b = quanteda::dfm_subset(z, quanteda::docnames(z) == b.name)
  b.author = quanteda::docvars(b, "author")

  score <- quanteda.textstats::textstat_simil(a, b, method = "cosine") |> suppressMessages() |> as.numeric()

  results = data.frame()
  results[1,"text1"] = a.name
  results[1,"text2"] = b.name

  if(a.author == b.author){

    results[1,"target"] = TRUE

  }else{

    results[1,"target"] = FALSE

  }

  results[1,"score"] = round(score, 3)

  return(results)

}
delta <- function(corpus, tokens = "word", remove_punct = F, remove_symbols = T, remove_numbers = T, lowercase = T, n = 1, threshold = 150, features = F, cores = NULL){

  d = vectorize(corpus, tokens = tokens, remove_punct = remove_punct, remove_symbols = remove_symbols,
                remove_numbers = remove_numbers, lowercase = lowercase, n = n, weighting = "rel", trim = T,
                threshold = threshold)

  q.list <- rownames(d)

  tests <- combn(q.list, 2) |> t() |> as.data.frame()

  z <- scale(d) |> quanteda::as.dfm()
  quanteda::docvars(z) <- quanteda::docvars(d)

  results <- pbapply::pbapply(tests, 1, cosine_delta, z, cl = cores)

  results.table = list_to_df(results)

  if(features == T){

    output <- list(results = results.table, features = colnames(d))

  }else{

    output <- results.table

  }

  return(output)

}
