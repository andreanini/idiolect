test_that("content masking works", {
  # skip tests if there is no python installation
  testthat::skip_if(
    try(
      suppressMessages(spacyr::spacy_initialize()),
      silent = TRUE
    ) |>
      inherits("try-error"),
    message = "spacyr environment not present"
  )

  enron.corpus <- readRDS(testthat::test_path("data", "enron_corpus.rds"))

  enron.small <- enron.corpus[1:3]

  enron.pos <- contentmask(enron.small, algorithm = "POSnoise") |>
    suppressMessages()
  expect_snapshot(enron.pos)

  enron.frames <- contentmask(enron.small, algorithm = "frames") |>
    suppressMessages()
  expect_snapshot(enron.frames)

  enron.dist <- contentmask(enron.small, algorithm = "textdistortion") |>
    suppressMessages()
  expect_snapshot(enron.dist)

  # testing masking of sentences
  enron.sents <- tokenize_sents(enron.small)
  enron.sents.pos <- contentmask(enron.sents, algorithm = "POSnoise") |>
    suppressMessages() |>
    lapply(
      \(x){
        paste0(x, collapse = " ")
      }
    )
  expect_identical(enron.sents.pos[[3]], enron.pos[[3]])

  enron.sents.frames <- contentmask(enron.sents, algorithm = "frames") |>
    suppressMessages() |>
    lapply(
      \(x){
        paste0(x, collapse = " ")
      }
    )
  expect_identical(enron.sents.frames[[3]], enron.frames[[3]])

  enron.sents.dist <- contentmask(enron.sents, algorithm = "textdistortion") |>
    suppressMessages() |>
    lapply(
      \(x){
        paste0(x, collapse = " ")
      }
    )
  expect_identical(enron.sents.dist[[1]], enron.dist[[1]])
  expect_identical(enron.sents.dist[[2]], enron.dist[[2]])
  expect_identical(enron.sents.dist[[3]], enron.dist[[3]])

  # testing weird cases and function word list

  text1 <- "The cat was on the chair. He didn't move\ncat@pets.com;\nhttp://quanteda.io/ i.e. a test"

  toy.corpus <- quanteda::corpus(text1)

  contentmask(toy.corpus, algorithm = "POSnoise") |>
    suppressMessages() |>
    expect_snapshot()

  contentmask(toy.corpus, algorithm = "frames") |>
    suppressMessages() |>
    expect_snapshot()

  contentmask(toy.corpus, algorithm = "textdistortion") |>
    suppressMessages() |>
    expect_snapshot()

  contentmask(toy.corpus, algorithm = "textdistortion", fw_list = c("the", "on")) |>
    suppressMessages() |>
    expect_snapshot()

  contentmask(toy.corpus, algorithm = "textdistortion", fw_list = "the") |>
    suppressMessages() |>
    expect_snapshot()
})
