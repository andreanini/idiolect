test_that("concordancer works", {

  concordance(enron.sample[1], enron.sample[2], enron.sample[3:49],
              search = "wants to", token.type = "word") |>
    expect_snapshot()

  concordance(enron.sample[1], enron.sample[2], enron.sample[3:49],
              search = "want*", token.type = "character") |>
    expect_snapshot()

  concordance(enron.sample[1], enron.sample[2], search = "want*", token.type = "character") |>
    expect_snapshot()


  # testing with sentences
  enron.sents <- tokens(enron.sample, what = "sentence")

  concordance(enron.sents[1], enron.sents[2], enron.sents[3:49],
              search = "? _EOS_", token.type = "word") |>
    expect_snapshot()


})
