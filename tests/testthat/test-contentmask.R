test_that("content masking works", {
  # skip tests if there is no python installation
  testthat::skip_if(
    try(suppressMessages(spacyr::spacy_initialize()), silent = TRUE) |>
      inherits("try-error"),
    message = "spacyr environment not present"
  )

  enron.corpus <- readRDS(testthat::test_path("data", "enron_corpus.rds"))

  enron.small <- enron.corpus[1:3]

  expect_snapshot(contentmask(enron.small, algorithm = "POSnoise"))
  expect_snapshot(contentmask(enron.small, algorithm = "frames"))
  expect_snapshot(contentmask(enron.small, algorithm = "textdistortion"))

  text1 <- "The cat was on the chair. He didn't move\ncat@pets.com;\nhttp://quanteda.io/ i.e. a test"
  toy.corpus <- quanteda::corpus(text1)
  contentmask(toy.corpus, algorithm = "POSnoise") |> expect_snapshot()
  contentmask(toy.corpus, algorithm = "frames") |> expect_snapshot()
  contentmask(toy.corpus, algorithm = "textdistortion") |> expect_snapshot()
  contentmask(toy.corpus, algorithm = "textdistortion", fw_list = c("the", "on")) |> expect_snapshot()
  contentmask(toy.corpus, algorithm = "textdistortion", fw_list = "the") |> expect_snapshot()

})
