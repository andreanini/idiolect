test_that("lambdaG visualize works", {

  q.data <- quanteda::corpus_trim(enron.sample[1], "sentences", max_ntoken = 10)
  k.data <- enron.sample[2:10]
  ref.data <- enron.sample[11:ndoc(enron.sample)]
  set.seed(2)
  outputs <- lambdaG_visualize(q.data, k.data, ref.data, r = 2, print = FALSE)

  expect_snapshot(outputs)

})
