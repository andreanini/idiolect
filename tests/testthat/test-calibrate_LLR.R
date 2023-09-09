test_that("calibration works", {

  res = readRDS(testthat::test_path("data", "res.rds"))

  fake.q = res[1,]
  calibration.data = res[-1,]

  results = calibrate_LLR(calibration.data, fake.q)

  expect_equal(results$calibrated.data$llr, 0.039982208)

})
