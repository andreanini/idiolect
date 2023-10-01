test_that("RBI works", {

  corpus = readRDS(testthat::test_path("data", "enron.rds"))

  unknown = quanteda::corpus_subset(corpus, texttype == "unknown")
  known = quanteda::corpus_subset(corpus, texttype == "known") |> quanteda::corpus_group(author)
  final.toks = unknown + known

  d = vectorize(final.toks)

  qs = quanteda::dfm_subset(d, quanteda::docnames(d) == "unknown [Kimberly.watson - Mail_3].txt" |
                             quanteda::docnames(d) == "unknown [Larry.campbell - Mail_1].txt")
  candidates = quanteda::dfm_subset(d, quanteda::docnames(d) == "Kimberly.watson" |
                                      quanteda::docnames(d) == "Larry.campbell")
  cand.imps = quanteda::dfm_subset(d, quanteda::docnames(d) != "Kimberly.watson" &
                                     quanteda::docnames(d) != "Larry.campbell" &
                                     texttype == "known")

  score_T = impostors(qs, candidates, cand.imps, "RBI", k = 100)

  testthat::expect_equal(score_T[1, 4], 1, tolerance = 0.05)
  testthat::expect_equal(score_T[2, 4], 0.1, tolerance = 0.1)
  testthat::expect_equal(score_T[3, 4], 0.1, tolerance = 0.1)
  testthat::expect_equal(score_T[4, 4], 1, tolerance = 0.1)

})
test_that("KGI works", {

  corpus = readRDS(testthat::test_path("data", "enron.rds"))

  unknown = quanteda::corpus_subset(corpus, texttype == "unknown")
  known = quanteda::corpus_subset(corpus, texttype == "known") |> quanteda::corpus_group(author)
  final.toks = unknown + known

  d = vectorize(final.toks)

  qs = quanteda::dfm_subset(d, quanteda::docnames(d) == "unknown [Kimberly.watson - Mail_3].txt" |
                              quanteda::docnames(d) == "unknown [Larry.campbell - Mail_1].txt")
  candidates = quanteda::dfm_subset(d, quanteda::docnames(d) == "Kimberly.watson"  |
                                      quanteda::docnames(d) == "Larry.campbell")
  cand.imps = quanteda::dfm_subset(d, quanteda::docnames(d) != "Kimberly.watson" &
                                     quanteda::docnames(d) != "Larry.campbell" &
                                     texttype == "known")

  score_T = impostors(qs, candidates, cand.imps, "KBI")

  testthat::expect_equal(score_T[1, 4], 1)
  testthat::expect_lt(score_T[2, 4], 0.1)
  testthat::expect_lt(score_T[3, 4], 0.1)
  testthat::expect_gt(score_T[4, 4], 0.8)

})
test_that("IM works", {

  corpus = readRDS(testthat::test_path("data", "enron.rds"))

  unknown = quanteda::corpus_subset(corpus, texttype == "unknown")
  known = quanteda::corpus_subset(corpus, texttype == "known") |> quanteda::corpus_group(author)
  final.toks = unknown + known

  d = vectorize(final.toks, n = 4, weighting = "tf-idf", trim = F)

  qs = quanteda::dfm_subset(d, quanteda::docnames(d) == "unknown [Kimberly.watson - Mail_3].txt" |
                              quanteda::docnames(d) == "unknown [Larry.campbell - Mail_1].txt")
  candidates = quanteda::dfm_subset(d, quanteda::docnames(d) == "Kimberly.watson"   |
                                      quanteda::docnames(d) == "Larry.campbell")
  cand.imps = quanteda::dfm_subset(d, quanteda::docnames(d) != "Kimberly.watson" &
                                     quanteda::docnames(d) != "Larry.campbell" &
                                     texttype == "known")
  q.imps = quanteda::dfm_subset(d, !(quanteda::docnames(d) %in% quanteda::docnames(qs)) &
                                     texttype == "unknown")

  score_T = impostors(qs, candidates, cand.imps, q.imps, "IM", m = 100, n = 25)

  testthat::expect_gt(score_T[1, 4], 0.8)
  testthat::expect_equal(score_T[2, 4], 0, tolerance = 0.01)
  testthat::expect_equal(score_T[3, 4], 0.0, tolerance = 0.01)
  testthat::expect_gt(score_T[4, 4], 0.1)

})

