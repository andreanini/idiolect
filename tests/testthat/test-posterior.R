test_that("posterior works", {

  table <- posterior(LLR = 1)

  expect_equal(table$prosecution_post_probs[2], 0.09174312)

  table <- posterior(LLR = 4)

  expect_equal(table$prosecution_post_probs[5], 0.99976672)

  table <- posterior(LLR = 1, prior = c(0.1, 0.9))

  expect_equal(table$prosecution_post_probs[1], 0.52631579)

})
