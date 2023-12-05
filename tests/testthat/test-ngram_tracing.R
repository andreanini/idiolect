test_that("ngram tracing works", {

  corpus = readRDS(testthat::test_path("data", "enron.rds"))

  unknown = quanteda::corpus_subset(corpus, texttype == "unknown")
  known = quanteda::corpus_subset(corpus, texttype == "known")

  # n-gram tracing from corpus
  results.corpus <- ngram_tracing(unknown[1:5], known[1:5], features = T)

  # n-gram tracing from dfm
  d = vectorize(c(unknown[1:5], known[1:5]), tokens = "character", remove_punct = F, remove_symbols = T,
                remove_numbers = T, lowercase = T, n = 9, weighting = "boolean", trim = F)

  results.dfm <- ngram_tracing(d[1:5,], d[6:10,], features = T)

  expect_identical(results.corpus, results.dfm)

  expect_snapshot(results.corpus)

})
