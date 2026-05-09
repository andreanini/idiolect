test_that("calibration works", {
  res <- readRDS(testthat::test_path("data", "res.rds"))
  fake.q <- res[1:10, ]
  calibration.data <- res[-c(1:10), ]
  results <- calibrate_LLR(fake.q, calibration.data)
  expect_snapshot(results)
})
test_that("calibration leave-one-out works", {
  res <- readRDS(testthat::test_path("data", "res.rds"))
  test <- res[1:10, ]
  results2 <- calibrate_LLR(test)
  expect_snapshot(results2)
})
