test_that("concordancer works", {

  concordance(enron.sample[1], enron.sample[2], enron.sample[3:49],
              search = "wants to", token.type = "word") |>
    expect_snapshot()

  concordance(enron.sample[1], enron.sample[2], enron.sample[3:49],
              search = "want*", token.type = "character") |>
    expect_snapshot()

})
