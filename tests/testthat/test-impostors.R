test_that("RBI works", {

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


  testthat::expect_gt(round(results.corpus[1, 4], 1), 0.4)
  testthat::expect_gt(round(results.dfm[1, 4], 1), 0.4)
  testthat::expect_lt(round(results.corpus[2, 4], 1), 0.3)
  testthat::expect_lt(round(results.dfm[2, 4], 1), 0.3)

  # impostors as rest of K version
  q.data <- unknown[c(1, 2)]
  k.data <- known[c(1:50)]
  cand.imps <- k.data

  results.corpus <- impostors(q.data, k.data, cand.imps, algorithm = "RBI", k = 100) |>
    suppressWarnings()

  testthat::expect_gt(round(results.corpus[4, 4], 1), 0.7)
  testthat::expect_lt(round(results.corpus[2, 4], 1), 0.3)

})
test_that("KGI works", {

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


  testthat::expect_gt(results.corpus[1, 4], 0.6)
  testthat::expect_gt(results.dfm[1, 4], 0.6)
  testthat::expect_lt(results.corpus[2, 4], 0.1)
  testthat::expect_lt(results.dfm[2, 4], 0.1)

})
test_that("IM works", {

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


  testthat::expect_gt(results.corpus[4, 4], 0)
  testthat::expect_gt(results.dfm[4, 4], 0)
  testthat::expect_lt(results.corpus[2, 4], 0.1)
  testthat::expect_lt(results.dfm[2, 4], 0.1)

})

