test_that("content masking works", {

  enron.corpus <- readRDS(testthat::test_path("data", "enron_corpus.rds"))

  expect_snapshot(contentmask(enron.corpus, algorithm = "POSnoise"))

  expect_snapshot(contentmask(enron.corpus, algorithm = "framenoise"))

})
