test_that("calibration works", {

  res = readRDS(testthat::test_path("data", "res.rds"))

  fake.q = res[1:10,]
  calibration.data = res[-c(1:10),]

  results = calibrate_LLR(calibration.data, fake.q)

  expect_snapshot(results)

})
