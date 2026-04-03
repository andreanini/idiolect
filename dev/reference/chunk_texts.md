# Chunk a dataset

This function can be used to chunk a dataset in order to control sample
sizes.

## Usage

``` r
chunk_texts(input, size)
```

## Arguments

- input:

  A `quanteda` corpus object, typically the output of the
  [`create_corpus()`](https://andreanini.github.io/idiolect/dev/reference/create_corpus.md)
  function, or a `quanteda` tokens object where each token is a sentence
  (the output of
  [`tokenize_sents()`](https://andreanini.github.io/idiolect/dev/reference/tokenize_sents.md)).

- size:

  The size of the chunks in number of tokens.

## Value

Either a `quanteda` corpus object or a `quanteda` tokens object
containing sentences, depending on the input, where each text is a chunk
of the size requested. If the input was a corpus object, then the
function divides each unit of the corpus in chunks of the length
specified. If the input was a tokens object then the function combines
sentences together until the chunk is equal or greater than the size
specified.

## Examples

``` r
corpus <- quanteda::corpus(c("The cat sat on the mat", "The dog sat on the chair"))
quanteda::docvars(corpus, "author") <- c("A", "B")
chunk_texts(corpus, size = 2)
#> Corpus consisting of 6 documents and 1 docvar.
#> text1.1 :
#> "The cat"
#> 
#> text1.2 :
#> "sat on"
#> 
#> text1.3 :
#> "the mat"
#> 
#> text2.1 :
#> "The dog"
#> 
#> text2.2 :
#> "sat on"
#> 
#> text2.3 :
#> "the chair"
#> 

sentences <- quanteda::tokens(corpus, "sentence")
chunk_texts(sentences, size = 6)
#> Tokens consisting of 2 documents and 1 docvar.
#> text1.1 :
#> [1] "The cat sat on the mat"
#> 
#> text2.1 :
#> [1] "The dog sat on the chair"
#> 
chunk_texts(sentences, size = 2)
#> Tokens consisting of 2 documents and 1 docvar.
#> text1.1 :
#> [1] "The cat sat on the mat"
#> 
#> text2.1 :
#> [1] "The dog sat on the chair"
#> 
try(chunk_texts(sentences, size = 7))
#> Error in chunk_texts(sentences, size = 7) : 
#>   No chunks of the size specified are available
```
