## code to prepare example dataset

full.corpus <- readRDS("tests/testthat/data/enron.rds")

enron.sample <- full.corpus[1:49]

docvars(enron.sample, "corpus") <- NULL
docvars(enron.sample, "texttype") <- NULL
docvars(enron.sample, "author") <- stringr::str_replace(docvars(enron.sample, "author"), "(\\w+)*\\.(\\w)\\w+", "\\1_\\2")

docnames(enron.sample) <- stringr::str_remove(docnames(enron.sample), "(un)*known \\[")
docnames(enron.sample) <- stringr::str_remove(docnames(enron.sample), "\\]\\.txt")
docnames(enron.sample) <- stringr::str_replace(docnames(enron.sample), " - ", "_")
docnames(enron.sample) <- stringr::str_replace(docnames(enron.sample), "(\\w+)*\\.(\\w)\\w+(_Mail_\\d)", "\\1_\\2\\3")

docvars(enron.sample, "textname") <- stringr::str_replace(docnames(enron.sample), "\\w+_\\w+_(Mail_\\d)", "\\1")

usethis::use_data(enron.sample, overwrite = TRUE)
