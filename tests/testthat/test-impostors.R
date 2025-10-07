test_that("RBI works", {

  set.seed(10)

  corpus = readRDS(testthat::test_path("data", "enron.rds"))

  unknown = quanteda::corpus_subset(corpus, texttype == "unknown")
  known = quanteda::corpus_subset(corpus, texttype == "known")

  # corpus version
  q.data <- unknown[c(1, 2)]
  k.data <- known[c(1:2, 5:6)]
  cand.imps <- known[7:50]


  results.corpus <- impostors(q.data, k.data, cand.imps, algorithm = "RBI", k = 100) |>
    suppressWarnings()


  # dfm version
  d = vectorize(c(q.data, k.data, cand.imps), tokens = "character", remove_punct = F, remove_symbols = T,
                remove_numbers = T, lowercase = F, n = 5, weighting = "rel", trim = T,
                threshold = 1500)

  results.dfm <- impostors(q.data = quanteda::dfm_subset(d, quanteda::docnames(d)
                                                         %in% quanteda::docnames(q.data)),
                           k.data = quanteda::dfm_subset(d, quanteda::docnames(d)
                                                         %in% quanteda::docnames(k.data)),
                           cand.imps = quanteda::dfm_subset(d, quanteda::docnames(d)
                                                            %in% quanteda::docnames(cand.imps)),
                           algorithm = "RBI", k = 100) |>
    suppressWarnings()


  testthat::expect_equal(results.corpus[1, 4], 0.540)
  testthat::expect_equal(results.dfm[1, 4], 0.539)
  testthat::expect_equal(results.corpus[2, 4], 0.207)
  testthat::expect_equal(results.dfm[2, 4], 0.240)

  # impostors as rest of K version
  q.data <- unknown[c(1, 2)]
  k.data <- known[c(1:50)]
  cand.imps <- k.data

  results.corpus <- impostors(q.data, k.data, cand.imps, algorithm = "RBI", k = 100) |>
    suppressWarnings()

  testthat::expect_equal(results.corpus[4, 4], 0.975)
  testthat::expect_equal(results.corpus[2, 4], 0.172)

})
test_that("KGI works", {

  set.seed(10)

  corpus = readRDS(testthat::test_path("data", "enron.rds"))

  unknown = quanteda::corpus_subset(corpus, texttype == "unknown")
  known = quanteda::corpus_subset(corpus, texttype == "known")

  # corpus version
  q.data <- unknown[c(1, 2)]
  k.data <- known[c(1:2, 5:6)]
  cand.imps <- known[7:50]

  results.corpus <- impostors(q.data, k.data, cand.imps, algorithm = "KGI") |>
    suppressWarnings()


  # dfm version
  d = vectorize(c(q.data, k.data, cand.imps), tokens = "character", remove_punct = F, remove_symbols = T,
                remove_numbers = T, lowercase = F, n = 4, weighting = "tf-idf", trim = F)

  results.dfm <- impostors(q.data = quanteda::dfm_subset(d, quanteda::docnames(d)
                                                         %in% quanteda::docnames(q.data)),
                           k.data = quanteda::dfm_subset(d, quanteda::docnames(d)
                                                         %in% quanteda::docnames(k.data)),
                           cand.imps = quanteda::dfm_subset(d, quanteda::docnames(d)
                                                            %in% quanteda::docnames(cand.imps)),
                           algorithm = "KGI") |>
    suppressWarnings()


  testthat::expect_equal(results.corpus[1, 4], 0.75)
  testthat::expect_equal(results.dfm[1, 4], 0.73)
  testthat::expect_lt(results.corpus[2, 4], 0.01)
  testthat::expect_equal(results.dfm[2, 4], 0.01)

})
test_that("IM works", {

  set.seed(10)

  corpus = readRDS(testthat::test_path("data", "enron.rds"))

  unknown = quanteda::corpus_subset(corpus, texttype == "unknown")
  known = quanteda::corpus_subset(corpus, texttype == "known")

  # corpus version
  q.data <- unknown[c(1, 2)]
  k.data <- known[c(1, 5)]
  cand.imps <- known[7:50]

  results.corpus <- impostors(q.data, k.data, cand.imps, algorithm = "IM") |>
    suppressWarnings()


  # dfm version
  d = vectorize(c(q.data, k.data, cand.imps), tokens = "character", remove_punct = F,
                remove_symbols = T, remove_numbers = T, lowercase = F, n = 4, weighting = "tf-idf",
                trim = F)

  results.dfm <- impostors(q.data = quanteda::dfm_subset(d, quanteda::docnames(d)
                                                         %in% quanteda::docnames(q.data)),
                           k.data = quanteda::dfm_subset(d, quanteda::docnames(d)
                                                         %in% quanteda::docnames(k.data)),
                           cand.imps = quanteda::dfm_subset(d, quanteda::docnames(d)
                                                            %in% quanteda::docnames(cand.imps)),
                           algorithm = "IM") |>
    suppressWarnings()


  testthat::expect_equal(results.corpus[4, 4], 0.57)
  testthat::expect_equal(results.dfm[4, 4], 0.585)
  testthat::expect_lt(results.corpus[2, 4], 0.01)
  testthat::expect_lt(results.dfm[2, 4], 0.001)

})
