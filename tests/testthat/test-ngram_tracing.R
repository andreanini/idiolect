test_that("ngram tracing works", {

  corpus = readRDS(testthat::test_path("data", "enron.rds"))

  unknown = quanteda::corpus_subset(corpus, texttype == "unknown")
  known = quanteda::corpus_subset(corpus, texttype == "known") |> quanteda::corpus_group(author)
  final.toks = unknown + known

  d = vectorize(final.toks, tokens = "character", remove_punct = F, remove_symbols = T,
                remove_numbers = T, lowercase = T, n = 5, weighting = "rel", trim = T,
                threshold = 1500)

  qs = quanteda::dfm_subset(d, quanteda::docnames(d) == "unknown [Kimberly.watson - Mail_3].txt" |
                              quanteda::docnames(d) == "unknown [Larry.campbell - Mail_1].txt")
  candidates = quanteda::dfm_subset(d, quanteda::docnames(d) == "Kimberly.watson" |
                                      quanteda::docnames(d) == "Larry.campbell")

  results <- ngram_tracing(qs, candidates, 'Phi', features = T)

  expect_snapshot(results)

})
