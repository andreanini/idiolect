test_that("delta works", {

  full.corpus <- readRDS(testthat::test_path("data", "enron.rds"))
  q.corpus <- quanteda::corpus_subset(full.corpus, texttype == "unknown")
  k.corpus <- quanteda::corpus_subset(full.corpus, texttype == "known")

  # delta from corpus
  results.corpus <- delta(q.corpus[1:5], k.corpus[1:5])

  # delta from dfm
  d <- vectorize(c(q.corpus[1:5], k.corpus[1:5]), tokens = "word", remove_punct = F, remove_symbols = T,
                 remove_numbers = T, lowercase = T, n = 1, weighting = "rel", trim = T, threshold = 150)
  results.dfm <- delta(d[1:5,], d[6:10,])


  expect_identical(results.corpus, results.dfm)

  expect_snapshot(results.corpus)

})
