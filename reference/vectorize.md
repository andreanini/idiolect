# Vectorize data

This function turns texts into feature vectors.

## Usage

``` r
vectorize(
  input,
  tokens,
  remove_punct,
  remove_symbols,
  remove_numbers,
  lowercase,
  n,
  weighting,
  trim,
  threshold
)
```

## Arguments

- input:

  This should be a `quanteda` corpus object with the author names as a
  docvar called "author". Typically, this is the output of the
  [`create_corpus()`](https://andreanini.github.io/idiolect/reference/create_corpus.md)
  function.

- tokens:

  The type of tokens to extract, either "character" or "word".

- remove_punct:

  A logical value. FALSE to keep the punctuation marks or TRUE to remove
  them.

- remove_symbols:

  A logical value. TRUE removes symbols and FALSE keeps them.

- remove_numbers:

  A logical value. TRUE removes numbers and FALSE keeps them.

- lowercase:

  A logical value. TRUE transforms all tokens to lower case.

- n:

  The order or size of the n-grams being extracted.

- weighting:

  The type of weighting to use, "rel" for relative frequencies,
  "tf-idf", or "boolean".

- trim:

  A logical value. If TRUE then only the most frequent tokens are kept.

- threshold:

  A numeric value indicating how many most frequent tokens to keep.

## Value

A dfm (document-feature matrix) containing each text as a feature
vector. N-gram tokenisation does not cross sentence boundaries.

## Details

All the authorship analysis functions call `vectorize()` with the
standard parameters for the algorithm selected. This function is
therefore left only for those users who want to modify these parameters
or for convenience if the same dfm has to be reused by the algorithms so
to avoid vectorizing the same data many times. Most users who only need
to run a standard analysis do not need use this function.

## Examples

``` r
mycorpus <- quanteda::corpus("The cat sat on the mat.")
quanteda::docvars(mycorpus, "author") <- "author1"
matrix <- vectorize(mycorpus, tokens = "character", remove_punct = FALSE, remove_symbols = TRUE,
remove_numbers = TRUE, lowercase = TRUE, n = 5, weighting = "rel", trim = TRUE, threshold = 1500)
```
