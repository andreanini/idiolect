# Select the most similar texts to a specific text

Select the most similar texts to a specific text

## Usage

``` r
most_similar(sample, pool, coefficient, n)
```

## Arguments

- sample:

  This is a single row of a `quanteda` dfm representing the sample to
  match.

- pool:

  This is a dfm containing all possible samples from which to select the
  top n.

- coefficient:

  The coefficient to use for similarity. Either "minmax", "cosine", or
  "Phi".

- n:

  The number of rows to extract from the pool of potential samples.

## Value

The function returns a dfm containing the top n most similar rows to the
input sample using the minmax distance.

## Examples

``` r
text1 <- "The cat sat on the mat"
text2 <- "The dog sat on the chair"
text3 <- "Violence is the last refuge of the incompetent"
c <- quanteda::corpus(c(text1, text2, text3))
d <- quanteda::tokens(c) |> quanteda::dfm() |> quanteda::dfm_weight(scheme = "prop")
most_similar(d[1,], d[-1,], coefficient = "minmax", n = 1)
#> Document-feature matrix of: 1 document, 13 features (61.54% sparse) and 0 docvars.
#>        features
#> docs          the cat       sat        on mat       dog     chair violence is
#>   text2 0.3333333   0 0.1666667 0.1666667   0 0.1666667 0.1666667        0  0
#>        features
#> docs    last
#>   text2    0
#> [ reached max_nfeat ... 3 more features ]
```
