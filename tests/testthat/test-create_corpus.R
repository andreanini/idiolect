test_that("corpus creation works", {
  path <- testthat::test_path("data", "texts")
  expect_snapshot(create_corpus(path))
})
test_that("filename syntax check works", {
  path <- testthat::test_path("data", "wrong_texts")
  expect_error(
    create_corpus(path),
    "Some files do not follow the required syntax: abc2.txt, smithtext.txt"
  )
})
test_that("create_corpus preserves newlines within text files", {
  # The on-disk fixtures in data/texts/ are all single-line, so they can't
  # exercise newline preservation. Build a throwaway corpus directory with
  # a multi-line file (including a blank line) and verify the loader
  # round-trips the newlines into the corpus body.
  tmp <- tempfile("create_corpus_newlines_")
  dir.create(tmp)
  on.exit(unlink(tmp, recursive = TRUE), add = TRUE)

  lines <- c(
    "First paragraph.",
    "",
    "Second paragraph after a blank line.",
    "Third line."
  )
  writeLines(lines, file.path(tmp, "alice_001.txt"))

  body <- as.character(create_corpus(tmp))[[1]]

  expect_equal(body, paste(lines, collapse = "\n"))
  expect_true(grepl("\n\n", body, fixed = TRUE))
})
