# Tokenize to sentences

This function turns a corpus of texts into a `quanteda` tokens object of
sentences.

## Usage

``` r
tokenize_sents(corpus, model = "en_core_web_sm")
```

## Arguments

- corpus:

  A `quanteda` corpus object, typically the output of the
  [`create_corpus()`](https://andreanini.github.io/idiolect/reference/create_corpus.md)
  function or the output of
  [`contentmask()`](https://andreanini.github.io/idiolect/reference/contentmask.md).

- model:

  The spacy model to use. The default is "en_core_web_sm".

## Value

A `quanteda` tokens object where each token is a sentence.

## Details

The function first split each text into paragraphs by splitting at new
line markers and then uses spacy to tokenize each paragraph into
sentences. The function accepts a plain text corpus input or the output
of
[`contentmask()`](https://andreanini.github.io/idiolect/reference/contentmask.md).
This function is necessary to prepare the data for
[`lambdaG()`](https://andreanini.github.io/idiolect/reference/lambdaG.md).

## Examples

``` r
if (FALSE) { # \dontrun{
toy.pos <- corpus("the N was on the N . he did n't move \n N ; \n N N")
tokenize_sents(toy.pos)
} # }
```
