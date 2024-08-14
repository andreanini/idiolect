test_that("content masking works", {

  # skip tests if there is no python installation
  testthat::skip_if(try(spacyr::spacy_initialize(), silent = TRUE) |>
                      inherits("try-error"),
                    message = "spacyr environment not present")

  enron.corpus <- readRDS(testthat::test_path("data", "enron_corpus.rds"))

  enron.small <- enron.corpus[1:3]

  expect_snapshot(contentmask(enron.small, algorithm = "POSnoise"))
  expect_snapshot(contentmask(enron.small, algorithm = "frames"))
  expect_snapshot(contentmask(enron.small, algorithm = "textdistortion"))

  text1 <- "The cat was on the chair. He didn't move\ncat@pets.com;\nhttp://quanteda.io/ i.e. a test 😻 👍"
  text2 <- "😻 👍"
  toy.corpus <- quanteda::corpus(c(text1, text2))
  contentmask(toy.corpus, algorithm = "POSnoise") |> expect_snapshot()
  contentmask(toy.corpus, algorithm = "POSnoise", replace_non_ascii = F) |> expect_snapshot()
  contentmask(toy.corpus, algorithm = "textdistortion") |> expect_snapshot()

})
