test_that("posterior works", {

  posterior(LLR = 1) -> table

  expect_equal(table$prosecution_post_probs[2], 0.09174312)

  posterior(LLR = 4) -> table

  expect_equal(table$prosecution_post_probs[5], 0.99976672)

})
