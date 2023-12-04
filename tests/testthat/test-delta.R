test_that("delta works", {

  full.corpus <- readRDS(testthat::test_path("data", "enron.rds"))

  corpus <- full.corpus[1:8]

  results <- delta(corpus, features = F)

  expect_snapshot(results)

})
