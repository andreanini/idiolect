test_that("corpus creation works", {

  path <- testthat::test_path("data", "texts")

  expect_snapshot(create_corpus(path))

})
