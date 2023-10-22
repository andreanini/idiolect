test_that("most_similar works", {

  enron <- readRDS(testthat::test_path("data", "enron.rds"))

  d <- vectorize(enron)

  expect_snapshot(most_similar(d[6,], d[-6,], measure = "minmax", n = 2))

  d <- vectorize(enron, n = 8, trim = F)

  expect_snapshot(most_similar(d[6,], d[-6,], measure = "Phi", n = 2))

})
