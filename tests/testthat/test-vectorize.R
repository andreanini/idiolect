test_that("vectorisation works", {

  enron <- readRDS(testthat::test_path("data", "enron.rds"))

  testthat::expect_snapshot(vectorize(enron))

})
