test_that("content masking works", {

  enron.corpus <- readRDS(testthat::test_path("data", "enron_corpus.rds"))

  enron.small <- enron.corpus[1:3]

  expect_snapshot(contentmask(enron.small, algorithm = "POSnoise", output = "corpus"))
  expect_snapshot(contentmask(enron.small, algorithm = "frames", output = "corpus"))

  expect_snapshot(contentmask(enron.small, algorithm = "POSnoise", output = "sentences"))
  expect_snapshot(contentmask(enron.small, algorithm = "frames", output = "sentences"))

  text1 <- "The cat was on the chair. He didn't move\ncat@pets.com;\nhttp://quanteda.io/ test 😻 👍"
  text2 <- "😻 👍"
  toy.corpus <- quanteda::corpus(c(text1, text2))
  contentmask(toy.corpus, algorithm = "POSnoise") |> expect_snapshot()
  contentmask(toy.corpus, algorithm = "POSnoise", remove_emojis = F) |> expect_snapshot()

})
