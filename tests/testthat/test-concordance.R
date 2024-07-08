test_that("concordancer works", {

  enron.sample[1] |>
    quanteda::tokens() |>
    concordance(enron.sample[2], enron.sample[3:49], search = "wants to") |>
    expect_error()

  concordance(enron.sample[1], enron.sample[2], enron.sample[3:49],
              search = "wants to", token.type = "word") |>
    expect_snapshot()

  concordance(enron.sample[1], enron.sample[2], enron.sample[3:49],
              search = "want*", token.type = "character") |>
    expect_snapshot()

  concordance(enron.sample[1], enron.sample[2], search = "want*", token.type = "character") |>
    expect_snapshot()

})
