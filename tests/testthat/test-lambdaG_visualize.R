test_that("lambdaG visualize works", {

  q.data <- quanteda::corpus_trim(enron.sample[1], "sentences", max_ntoken = 10) |>
    quanteda::tokens("sentence")
  k.data <- enron.sample[2:5] |> quanteda::tokens("sentence")
  ref.data <- enron.sample[6:ndoc(enron.sample)] |> quanteda::tokens("sentence")
  set.seed(2)
  lambdaG_visualize(q.data, k.data, ref.data, r = 2, print = "") |> expect_snapshot()
  lambdaG_visualize(q.data, k.data, ref.data, r = 2, print = "", scale = "relative") |> expect_snapshot()
  lambdaG_visualize(q.data, k.data, ref.data, r = 2, print = tempfile()) |> expect_no_error()

})
