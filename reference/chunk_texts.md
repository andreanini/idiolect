# Chunk a corpus

This function can be used to chunk a corpus in order to control sample
sizes.

## Usage

``` r
chunk_texts(corpus, size)
```

## Arguments

- corpus:

  A `quanteda` corpus.

- size:

  The size of the chunks in number of tokens.

## Value

A `quanteda` corpus object where each text is a chunk of the size
requested.

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

```
