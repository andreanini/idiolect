test_that("content masking works", {

  enron.corpus <- readRDS(testthat::test_path("data", "enron_corpus.rds"))

  enron.small <- enron.corpus[1:3]

  expect_snapshot(contentmask(enron.small, algorithm = "POSnoise", output = "corpus"))
  expect_snapshot(contentmask(enron.small, algorithm = "frames", output = "corpus"))

  expect_snapshot(contentmask(enron.small, algorithm = "POSnoise", output = "sentences"))
  expect_snapshot(contentmask(enron.small, algorithm = "frames", output = "sentences"))

})
