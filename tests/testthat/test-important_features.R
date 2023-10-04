test_that("retrieving important features", {

  corpus = readRDS(testthat::test_path("data", "enron.rds"))

  unknown = quanteda::corpus_subset(corpus, texttype == "unknown")
  known = quanteda::corpus_subset(corpus, texttype == "known") |> quanteda::corpus_group(author)
  final.toks = unknown + known

  d = vectorize(final.toks)

  q = quanteda::dfm_subset(d, quanteda::docnames(d) == "unknown [Kimberly.watson - Mail_3].txt")
  candidate = quanteda::dfm_subset(d, quanteda::docnames(d) == "Kimberly.watson")
  cand.imps = quanteda::dfm_subset(d, quanteda::docnames(d) != "Kimberly.watson" & texttype == "known")

  expect_snapshot(important_features(q, candidate, cand.imps))

})
