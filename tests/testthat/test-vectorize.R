test_that("tokenisation and vectorisation are correct", {

  mycorpus = readtext::readtext(testthat::test_path("data", "texts"),
                                docvarsfrom = "filenames",
                                docvarnames = c("author", "textname")) |> quanteda::corpus()

  testthat::expect_snapshot(vectorize(mycorpus))

})
