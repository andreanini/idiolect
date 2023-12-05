test_that("vectorisation works", {

  enron <- readRDS(testthat::test_path("data", "enron.rds"))

  testthat::expect_snapshot(vectorize(enron, tokens = "character", remove_punct = F, remove_symbols = T,
                                      remove_numbers = T, lowercase = T, n = 5, weighting = "rel", trim = T,
                                      threshold = 1500))

})
