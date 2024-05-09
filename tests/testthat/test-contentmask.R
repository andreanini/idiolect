test_that("content masking works", {

  enron.corpus <- readRDS(testthat::test_path("data", "enron_corpus.rds"))

  enron.small <- enron.corpus[1:3]

  expect_snapshot(contentmask(enron.small, algorithm = "POSnoise", replace_non_ascii = F, output = "corpus"))
  expect_snapshot(contentmask(enron.small, algorithm = "frames", replace_non_ascii = F, output = "corpus"))

  expect_snapshot(contentmask(enron.small, algorithm = "POSnoise", replace_non_ascii = F, output = "sentences"))
  expect_snapshot(contentmask(enron.small, algorithm = "frames", replace_non_ascii = F, output = "sentences"))

})
