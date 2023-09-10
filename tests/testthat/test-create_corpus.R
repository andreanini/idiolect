test_that("corpus creation works", {

  path <- testthat::test_path("data", "texts")

  expect_snapshot(create_corpus(path))

  create_corpus(path, pos_tag = T)

})
test_that("postagging works", {

  path <- testthat::test_path("data", "texts")

  expect_snapshot(create_corpus(path, pos_tag = T))

})
