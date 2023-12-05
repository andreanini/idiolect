test_that("most_similar works", {

  enron <- readRDS(testthat::test_path("data", "enron.rds"))

  d <- vectorize(enron, tokens = "character", remove_punct = F, remove_symbols = T,
                 remove_numbers = T, lowercase = T, n = 5, weighting = "rel", trim = T,
                 threshold = 1500)

  expect_snapshot(most_similar(d[6,], d[-6,], coefficient = "minmax", n = 2))

  expect_snapshot(most_similar(d[6,], d[-6,], coefficient = "cosine", n = 2))

  d <- vectorize(enron, n = 8, trim = F, tokens = "character", remove_punct = F, remove_symbols = T,
                 remove_numbers = T, lowercase = T, weighting = "rel")

  expect_snapshot(most_similar(d[6,], d[-6,], coefficient = "Phi", n = 2))

})
