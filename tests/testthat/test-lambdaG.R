test_that("lambdaG works", {

  q.data <- enron.sample[1] |> quanteda::tokens("sentence")
  k.data <- enron.sample[2:10]|> quanteda::tokens("sentence")
  ref.data <- enron.sample[11:ndoc(enron.sample)]|> quanteda::tokens("sentence")

  results <- lambdaG(q.data, k.data, ref.data)

  expect_gt(results[1, 4], 0)
  expect_lt(results[2, 4], 0)

})
