test_that(
  "corpus chunking works",
  {
    enron <- readRDS(testthat::test_path("data", "enron.rds"))
    chunked <- chunk_texts(enron, 100)
    testthat::expect_snapshot(chunked)
    testthat::expect_snapshot(quanteda::docvars(chunked))
  }
)
test_that(
  "sentence chunking works",
  {
    sample <- enron.sample[3:10] |>
      quanteda::tokens("sentence") |>
      quanteda::tokens_group(author)
    chunked <- chunk_texts(sample, 100)
    sizes <- chunked |>
      sapply(
        \(x){
          paste0(x, collapse = "\n") |>
            quanteda::tokens() |>
            quanteda::ntoken()
        }
      )
    testthat::expect_vector(names(sizes[sizes >= 100]), size = 44)
  }
)
