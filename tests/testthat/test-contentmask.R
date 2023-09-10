test_that("content masking works", {

  enron.parsed <- readRDS(testthat::test_path("data", "enron_parsed.rds"))

  expect_snapshot(contentmask(enron.parsed, algorithm = "POSnoise"))

  expect_snapshot(contentmask(enron.parsed, algorithm = "framenoise"))

})
