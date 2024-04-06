test_that("density plotting works", {

  res = readRDS(testthat::test_path("data", "res.rds"))

  fake.q = 0.3

  p = density_plot(res, fake.q)

  expect_true(ggplot2::is.ggplot(p))
  expect_error(print(p), NA)

})
