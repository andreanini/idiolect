# Delta

This function runs a *Cosine Delta* analysis (Smith and Aldridge 2011;
Evert et al. 2017).

## Usage

``` r
delta(
  q.data,
  k.data,
  tokens = "word",
  remove_punct = FALSE,
  remove_symbols = TRUE,
  remove_numbers = TRUE,
  lowercase = TRUE,
  n = 1,
  trim = TRUE,
  threshold = 150,
  features = FALSE,
  cores = NULL
)
```

## Arguments

- q.data:

  The questioned or disputed data, either as a corpus (the output of
  [`create_corpus()`](https://andreanini.github.io/idiolect/reference/create_corpus.md))
  or as a `quanteda` dfm (the output of
  [`vectorize()`](https://andreanini.github.io/idiolect/reference/vectorize.md)).

- k.data:

  The known or undisputed data, either as a corpus (the output of
  [`create_corpus()`](https://andreanini.github.io/idiolect/reference/create_corpus.md))
  or as a `quanteda` dfm (the output of
  [`vectorize()`](https://andreanini.github.io/idiolect/reference/vectorize.md)).

- tokens:

  The type of tokens to extract, either "word" (default) or "character".

- remove_punct:

  A logical value. FALSE (default) keeps punctuation marks.

- remove_symbols:

  A logical value. TRUE (default) removes symbols.

- remove_numbers:

  A logical value. TRUE (default) removes numbers

- lowercase:

  A logical value. TRUE (default) transforms all tokens to lower case.

- n:

  The order or size of the n-grams being extracted. Default is 1.

- trim:

  A logical value. If TRUE (default) then only the most frequent tokens
  are kept.

- threshold:

  A numeric value indicating how many most frequent tokens to keep if
  trim = TRUE. The default is 150.

- features:

  Logical with default FALSE. If TRUE, then the output will contain the
  features used.

- cores:

  The number of cores to use for parallel processing (the default is
  one).

## Value

If features is set to FALSE then the output is a data frame containing
the results of all comparisons between the Q texts and the K texts. If
features is set to TRUE then the output is a list containing the results
data frame and the vector of features used for the analysis.

## References

Evert, Stefan, Thomas Proisl, Fotis Jannidis, Isabella Reger, Steffen
Pielström, Christof Schöch & Thorsten Vitt. 2017. Understanding and
explaining Delta measures for authorship attribution. Digital
Scholarship in the Humanities 32. ii4–ii16.
https://doi.org/10.1093/llc/fqx023. Smith, Peter W H & W Aldridge. 2011.
Improving Authorship Attribution: Optimizing Burrows’ Delta Method\*.
Journal of Quantitative Linguistics 18(1). 63–88.
https://doi.org/10.1080/09296174.2011.533591.

## Examples

``` r
Q <- enron.sample[c(5:6)]
K <- enron.sample[-c(5:6)]
delta(Q, K)
#>                          Q                       K target  score
#> 1  unknown [Kh Mail_2].txt   known [Kh Mail_1].txt   TRUE -0.039
#> 2  unknown [Kw Mail_3].txt   known [Kh Mail_1].txt  FALSE -0.061
#> 3  unknown [Kh Mail_2].txt   known [Kh Mail_3].txt   TRUE  0.177
#> 4  unknown [Kw Mail_3].txt   known [Kh Mail_3].txt  FALSE  0.075
#> 5  unknown [Kh Mail_2].txt   known [Kh Mail_4].txt   TRUE -0.068
#> 6  unknown [Kw Mail_3].txt   known [Kh Mail_4].txt  FALSE -0.078
#> 7  unknown [Kh Mail_2].txt   known [Kh Mail_5].txt   TRUE -0.018
#> 8  unknown [Kw Mail_3].txt   known [Kh Mail_5].txt  FALSE -0.161
#> 9  unknown [Kh Mail_2].txt   known [Kw Mail_1].txt  FALSE -0.144
#> 10 unknown [Kw Mail_3].txt   known [Kw Mail_1].txt   TRUE  0.110
#> 11 unknown [Kh Mail_2].txt   known [Kw Mail_2].txt  FALSE -0.091
#> 12 unknown [Kw Mail_3].txt   known [Kw Mail_2].txt   TRUE  0.195
#> 13 unknown [Kh Mail_2].txt   known [Kw Mail_4].txt  FALSE -0.072
#> 14 unknown [Kw Mail_3].txt   known [Kw Mail_4].txt   TRUE  0.315
#> 15 unknown [Kh Mail_2].txt   known [Kw Mail_5].txt  FALSE -0.113
#> 16 unknown [Kw Mail_3].txt   known [Kw Mail_5].txt   TRUE  0.243
#> 17 unknown [Kh Mail_2].txt unknown [Lc Mail_1].txt  FALSE  0.177
#> 18 unknown [Kw Mail_3].txt unknown [Lc Mail_1].txt  FALSE -0.073
#> 19 unknown [Kh Mail_2].txt   known [Lc Mail_2].txt  FALSE -0.084
#> 20 unknown [Kw Mail_3].txt   known [Lc Mail_2].txt  FALSE -0.192
#> 21 unknown [Kh Mail_2].txt   known [Lc Mail_3].txt  FALSE -0.059
#> 22 unknown [Kw Mail_3].txt   known [Lc Mail_3].txt  FALSE -0.009
#> 23 unknown [Kh Mail_2].txt   known [Lc Mail_4].txt  FALSE  0.073
#> 24 unknown [Kw Mail_3].txt   known [Lc Mail_4].txt  FALSE  0.028
#> 25 unknown [Kh Mail_2].txt   known [Lc Mail_5].txt  FALSE  0.087
#> 26 unknown [Kw Mail_3].txt   known [Lc Mail_5].txt  FALSE -0.172
#> 27 unknown [Kh Mail_2].txt unknown [Ld Mail_4].txt  FALSE  0.017
#> 28 unknown [Kw Mail_3].txt unknown [Ld Mail_4].txt  FALSE -0.021
#> 29 unknown [Kh Mail_2].txt   known [Ld Mail_1].txt  FALSE -0.155
#> 30 unknown [Kw Mail_3].txt   known [Ld Mail_1].txt  FALSE  0.082
#> 31 unknown [Kh Mail_2].txt   known [Ld Mail_2].txt  FALSE -0.046
#> 32 unknown [Kw Mail_3].txt   known [Ld Mail_2].txt  FALSE -0.086
#> 33 unknown [Kh Mail_2].txt   known [Ld Mail_3].txt  FALSE -0.168
#> 34 unknown [Kw Mail_3].txt   known [Ld Mail_3].txt  FALSE -0.084
#> 35 unknown [Kh Mail_2].txt   known [Ld Mail_5].txt  FALSE -0.018
#> 36 unknown [Kw Mail_3].txt   known [Ld Mail_5].txt  FALSE  0.032
#> 37 unknown [Kh Mail_2].txt unknown [Lt Mail_2].txt  FALSE  0.032
#> 38 unknown [Kw Mail_3].txt unknown [Lt Mail_2].txt  FALSE -0.143
#> 39 unknown [Kh Mail_2].txt   known [Lt Mail_1].txt  FALSE  0.113
#> 40 unknown [Kw Mail_3].txt   known [Lt Mail_1].txt  FALSE  0.116
#> 41 unknown [Kh Mail_2].txt   known [Lt Mail_3].txt  FALSE  0.139
#> 42 unknown [Kw Mail_3].txt   known [Lt Mail_3].txt  FALSE  0.080
#> 43 unknown [Kh Mail_2].txt   known [Lt Mail_4].txt  FALSE  0.145
#> 44 unknown [Kw Mail_3].txt   known [Lt Mail_4].txt  FALSE -0.032
#> 45 unknown [Kh Mail_2].txt unknown [Lk Mail_4].txt  FALSE  0.030
#> 46 unknown [Kw Mail_3].txt unknown [Lk Mail_4].txt  FALSE -0.154
#> 47 unknown [Kh Mail_2].txt   known [Lk Mail_1].txt  FALSE -0.038
#> 48 unknown [Kw Mail_3].txt   known [Lk Mail_1].txt  FALSE -0.012
#> 49 unknown [Kh Mail_2].txt   known [Lk Mail_2].txt  FALSE -0.065
#> 50 unknown [Kw Mail_3].txt   known [Lk Mail_2].txt  FALSE -0.104
#> 51 unknown [Kh Mail_2].txt   known [Lk Mail_3].txt  FALSE  0.152
#> 52 unknown [Kw Mail_3].txt   known [Lk Mail_3].txt  FALSE -0.002
#> 53 unknown [Kh Mail_2].txt   known [Lk Mail_5].txt  FALSE -0.008
#> 54 unknown [Kw Mail_3].txt   known [Lk Mail_5].txt  FALSE -0.060
#> 55 unknown [Kh Mail_2].txt unknown [Lb Mail_3].txt  FALSE -0.203
#> 56 unknown [Kw Mail_3].txt unknown [Lb Mail_3].txt  FALSE  0.072
#> 57 unknown [Kh Mail_2].txt   known [Lb Mail_1].txt  FALSE -0.111
#> 58 unknown [Kw Mail_3].txt   known [Lb Mail_1].txt  FALSE  0.114
#> 59 unknown [Kh Mail_2].txt   known [Lb Mail_2].txt  FALSE -0.094
#> 60 unknown [Kw Mail_3].txt   known [Lb Mail_2].txt  FALSE  0.052
#> 61 unknown [Kh Mail_2].txt   known [Lb Mail_4].txt  FALSE  0.042
#> 62 unknown [Kw Mail_3].txt   known [Lb Mail_4].txt  FALSE  0.132
#> 63 unknown [Kh Mail_2].txt   known [Lb Mail_5].txt  FALSE -0.106
#> 64 unknown [Kw Mail_3].txt   known [Lb Mail_5].txt  FALSE -0.070
#> 65 unknown [Kh Mail_2].txt unknown [La Mail_3].txt  FALSE -0.006
#> 66 unknown [Kw Mail_3].txt unknown [La Mail_3].txt  FALSE -0.278
#> 67 unknown [Kh Mail_2].txt   known [La Mail_1].txt  FALSE -0.004
#> 68 unknown [Kw Mail_3].txt   known [La Mail_1].txt  FALSE -0.193
#> 69 unknown [Kh Mail_2].txt   known [La Mail_2].txt  FALSE -0.044
#> 70 unknown [Kw Mail_3].txt   known [La Mail_2].txt  FALSE -0.134
#> 71 unknown [Kh Mail_2].txt   known [La Mail_4].txt  FALSE  0.137
#> 72 unknown [Kw Mail_3].txt   known [La Mail_4].txt  FALSE -0.270
#> 73 unknown [Kh Mail_2].txt   known [La Mail_5].txt  FALSE  0.081
#> 74 unknown [Kw Mail_3].txt   known [La Mail_5].txt  FALSE -0.220
#> 75 unknown [Kh Mail_2].txt unknown [Mf Mail_1].txt  FALSE -0.242
#> 76 unknown [Kw Mail_3].txt unknown [Mf Mail_1].txt  FALSE  0.024
#> 77 unknown [Kh Mail_2].txt   known [Mf Mail_2].txt  FALSE -0.096
#> 78 unknown [Kw Mail_3].txt   known [Mf Mail_2].txt  FALSE -0.023
#> 79 unknown [Kh Mail_2].txt   known [Mf Mail_3].txt  FALSE  0.123
#> 80 unknown [Kw Mail_3].txt   known [Mf Mail_3].txt  FALSE -0.017
#> 81 unknown [Kh Mail_2].txt   known [Mf Mail_4].txt  FALSE -0.148
#> 82 unknown [Kw Mail_3].txt   known [Mf Mail_4].txt  FALSE  0.057
#> 83 unknown [Kh Mail_2].txt   known [Mf Mail_5].txt  FALSE  0.058
#> 84 unknown [Kw Mail_3].txt   known [Mf Mail_5].txt  FALSE -0.135
#> 85 unknown [Kh Mail_2].txt unknown [Ml Mail_3].txt  FALSE -0.214
#> 86 unknown [Kw Mail_3].txt unknown [Ml Mail_3].txt  FALSE  0.053
#> 87 unknown [Kh Mail_2].txt   known [Ml Mail_1].txt  FALSE  0.009
#> 88 unknown [Kw Mail_3].txt   known [Ml Mail_1].txt  FALSE  0.051
#> 89 unknown [Kh Mail_2].txt   known [Ml Mail_2].txt  FALSE -0.143
#> 90 unknown [Kw Mail_3].txt   known [Ml Mail_2].txt  FALSE -0.046
#> 91 unknown [Kh Mail_2].txt   known [Ml Mail_4].txt  FALSE  0.024
#> 92 unknown [Kw Mail_3].txt   known [Ml Mail_4].txt  FALSE -0.032
#> 93 unknown [Kh Mail_2].txt   known [Ml Mail_5].txt  FALSE  0.036
#> 94 unknown [Kw Mail_3].txt   known [Ml Mail_5].txt  FALSE  0.064
```
