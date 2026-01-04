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
