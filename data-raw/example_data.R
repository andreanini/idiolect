## code to prepare example dataset

full.corpus <- readRDS("tests/testthat/data/enron.rds")

enron.sample <- full.corpus[1:49]

docvars(enron.sample, "corpus") <- NULL
docvars(enron.sample, "texttype") <- NULL
docvars(enron.sample, "author") <- stringr::str_replace(docvars(enron.sample, "author"), "(\\w)(\\w+)*\\.(\\w)\\w+", "\\1\\3")
docnames(enron.sample) <- stringr::str_replace(docnames(enron.sample), "\\[(\\w)(\\w+)*\\.(\\w)\\w+ -", "[\\1\\3")

usethis::use_data(enron.sample, overwrite = TRUE)
