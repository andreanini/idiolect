test_that("chunking works", {

  enron <- readRDS(testthat::test_path("data", "enron.rds"))

  chunked <- chunk_texts(enron, 100)

  testthat::expect_snapshot(chunked)

  testthat::expect_snapshot(quanteda::docvars(chunked))

})
