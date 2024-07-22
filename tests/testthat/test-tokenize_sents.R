test_that("tokenize_sents works", {

  toy <- quanteda::corpus("The cat was on the chair. He didn't move\ncat@pets.com;\nhttp://quanteda.io/ test 😻 👍")
  toy.pos <- quanteda::corpus("the N was on the N . he did n't move \n N ; \n N N")

  tokenize_sents(toy) |> expect_snapshot()
  tokenize_sents(toy.pos) |> expect_snapshot()

})
