## code to prepare example dataset

full.corpus <- readRDS("tests/testthat/data/enron.rds")

enron.sample <- full.corpus[1:49]

usethis::use_data(enron.sample, overwrite = TRUE)
