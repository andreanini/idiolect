test_that("performance evaluation works", {

  res = readRDS(testthat::test_path("data", "res.rds"))

  results = performance(res)

  only.training <- results$evaluation

  testthat::expect_equal(only.training[1, 9], 0.84, tolerance = 0.01)

  train.test = split.data.frame(res, ~target)
  same = train.test$`TRUE`
  diff = train.test$`FALSE`

  #creating vector of random rows
  training = rbind(same[1:35,], diff[1:35,])
  test = rbind(same[35:48,], diff[35:48,])

  results = performance(training, test)

  train.test.perf <- results$evaluation

  testthat::expect_equal(train.test.perf[1, 9], 0.785, tolerance = 0.01)

})
