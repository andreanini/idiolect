## code to prepare `example_data` dataset goes here

refcor.sample <- create_corpus("data-raw/refcor")

usethis::use_data(refcor.sample, overwrite = TRUE)
