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
  [`create_corpus()`](https://andreanini.github.io/idiolect/dev/reference/create_corpus.md))
  or as a `quanteda` dfm (the output of
  [`vectorize()`](https://andreanini.github.io/idiolect/dev/reference/vectorize.md)).

- k.data:

  The known or undisputed data, either as a corpus (the output of
  [`create_corpus()`](https://andreanini.github.io/idiolect/dev/reference/create_corpus.md))
  or as a `quanteda` dfm (the output of
  [`vectorize()`](https://andreanini.github.io/idiolect/dev/reference/vectorize.md)).

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
#>                    Q                 K target  score
#> 1     Kevin_h_Mail_2    Kevin_h_Mail_1   TRUE -0.039
#> 2  Kimberly_w_Mail_3    Kevin_h_Mail_1  FALSE -0.061
#> 3     Kevin_h_Mail_2    Kevin_h_Mail_3   TRUE  0.177
#> 4  Kimberly_w_Mail_3    Kevin_h_Mail_3  FALSE  0.075
#> 5     Kevin_h_Mail_2    Kevin_h_Mail_4   TRUE -0.068
#> 6  Kimberly_w_Mail_3    Kevin_h_Mail_4  FALSE -0.078
#> 7     Kevin_h_Mail_2    Kevin_h_Mail_5   TRUE -0.018
#> 8  Kimberly_w_Mail_3    Kevin_h_Mail_5  FALSE -0.161
#> 9     Kevin_h_Mail_2 Kimberly_w_Mail_1  FALSE -0.144
#> 10 Kimberly_w_Mail_3 Kimberly_w_Mail_1   TRUE  0.110
#> 11    Kevin_h_Mail_2 Kimberly_w_Mail_2  FALSE -0.091
#> 12 Kimberly_w_Mail_3 Kimberly_w_Mail_2   TRUE  0.195
#> 13    Kevin_h_Mail_2 Kimberly_w_Mail_4  FALSE -0.072
#> 14 Kimberly_w_Mail_3 Kimberly_w_Mail_4   TRUE  0.315
#> 15    Kevin_h_Mail_2 Kimberly_w_Mail_5  FALSE -0.113
#> 16 Kimberly_w_Mail_3 Kimberly_w_Mail_5   TRUE  0.243
#> 17    Kevin_h_Mail_2    Larry_c_Mail_1  FALSE  0.177
#> 18 Kimberly_w_Mail_3    Larry_c_Mail_1  FALSE -0.073
#> 19    Kevin_h_Mail_2    Larry_c_Mail_2  FALSE -0.084
#> 20 Kimberly_w_Mail_3    Larry_c_Mail_2  FALSE -0.192
#> 21    Kevin_h_Mail_2    Larry_c_Mail_3  FALSE -0.059
#> 22 Kimberly_w_Mail_3    Larry_c_Mail_3  FALSE -0.009
#> 23    Kevin_h_Mail_2    Larry_c_Mail_4  FALSE  0.073
#> 24 Kimberly_w_Mail_3    Larry_c_Mail_4  FALSE  0.028
#> 25    Kevin_h_Mail_2    Larry_c_Mail_5  FALSE  0.087
#> 26 Kimberly_w_Mail_3    Larry_c_Mail_5  FALSE -0.172
#> 27    Kevin_h_Mail_2    Lindy_d_Mail_4  FALSE  0.017
#> 28 Kimberly_w_Mail_3    Lindy_d_Mail_4  FALSE -0.021
#> 29    Kevin_h_Mail_2    Lindy_d_Mail_1  FALSE -0.155
#> 30 Kimberly_w_Mail_3    Lindy_d_Mail_1  FALSE  0.082
#> 31    Kevin_h_Mail_2    Lindy_d_Mail_2  FALSE -0.046
#> 32 Kimberly_w_Mail_3    Lindy_d_Mail_2  FALSE -0.086
#> 33    Kevin_h_Mail_2    Lindy_d_Mail_3  FALSE -0.168
#> 34 Kimberly_w_Mail_3    Lindy_d_Mail_3  FALSE -0.084
#> 35    Kevin_h_Mail_2    Lindy_d_Mail_5  FALSE -0.018
#> 36 Kimberly_w_Mail_3    Lindy_d_Mail_5  FALSE  0.032
#> 37    Kevin_h_Mail_2      Liz_t_Mail_2  FALSE  0.032
#> 38 Kimberly_w_Mail_3      Liz_t_Mail_2  FALSE -0.143
#> 39    Kevin_h_Mail_2      Liz_t_Mail_1  FALSE  0.113
#> 40 Kimberly_w_Mail_3      Liz_t_Mail_1  FALSE  0.116
#> 41    Kevin_h_Mail_2      Liz_t_Mail_3  FALSE  0.139
#> 42 Kimberly_w_Mail_3      Liz_t_Mail_3  FALSE  0.080
#> 43    Kevin_h_Mail_2      Liz_t_Mail_4  FALSE  0.145
#> 44 Kimberly_w_Mail_3      Liz_t_Mail_4  FALSE -0.032
#> 45    Kevin_h_Mail_2   Louise_k_Mail_4  FALSE  0.030
#> 46 Kimberly_w_Mail_3   Louise_k_Mail_4  FALSE -0.154
#> 47    Kevin_h_Mail_2   Louise_k_Mail_1  FALSE -0.038
#> 48 Kimberly_w_Mail_3   Louise_k_Mail_1  FALSE -0.012
#> 49    Kevin_h_Mail_2   Louise_k_Mail_2  FALSE -0.065
#> 50 Kimberly_w_Mail_3   Louise_k_Mail_2  FALSE -0.104
#> 51    Kevin_h_Mail_2   Louise_k_Mail_3  FALSE  0.152
#> 52 Kimberly_w_Mail_3   Louise_k_Mail_3  FALSE -0.002
#> 53    Kevin_h_Mail_2   Louise_k_Mail_5  FALSE -0.008
#> 54 Kimberly_w_Mail_3   Louise_k_Mail_5  FALSE -0.060
#> 55    Kevin_h_Mail_2     Lynn_b_Mail_3  FALSE -0.203
#> 56 Kimberly_w_Mail_3     Lynn_b_Mail_3  FALSE  0.072
#> 57    Kevin_h_Mail_2     Lynn_b_Mail_1  FALSE -0.111
#> 58 Kimberly_w_Mail_3     Lynn_b_Mail_1  FALSE  0.114
#> 59    Kevin_h_Mail_2     Lynn_b_Mail_2  FALSE -0.094
#> 60 Kimberly_w_Mail_3     Lynn_b_Mail_2  FALSE  0.052
#> 61    Kevin_h_Mail_2     Lynn_b_Mail_4  FALSE  0.042
#> 62 Kimberly_w_Mail_3     Lynn_b_Mail_4  FALSE  0.132
#> 63    Kevin_h_Mail_2     Lynn_b_Mail_5  FALSE -0.106
#> 64 Kimberly_w_Mail_3     Lynn_b_Mail_5  FALSE -0.070
#> 65    Kevin_h_Mail_2     Lysa_a_Mail_3  FALSE -0.006
#> 66 Kimberly_w_Mail_3     Lysa_a_Mail_3  FALSE -0.278
#> 67    Kevin_h_Mail_2     Lysa_a_Mail_1  FALSE -0.004
#> 68 Kimberly_w_Mail_3     Lysa_a_Mail_1  FALSE -0.193
#> 69    Kevin_h_Mail_2     Lysa_a_Mail_2  FALSE -0.044
#> 70 Kimberly_w_Mail_3     Lysa_a_Mail_2  FALSE -0.134
#> 71    Kevin_h_Mail_2     Lysa_a_Mail_4  FALSE  0.137
#> 72 Kimberly_w_Mail_3     Lysa_a_Mail_4  FALSE -0.270
#> 73    Kevin_h_Mail_2     Lysa_a_Mail_5  FALSE  0.081
#> 74 Kimberly_w_Mail_3     Lysa_a_Mail_5  FALSE -0.220
#> 75    Kevin_h_Mail_2        M_f_Mail_1  FALSE -0.242
#> 76 Kimberly_w_Mail_3        M_f_Mail_1  FALSE  0.024
#> 77    Kevin_h_Mail_2        M_f_Mail_2  FALSE -0.096
#> 78 Kimberly_w_Mail_3        M_f_Mail_2  FALSE -0.023
#> 79    Kevin_h_Mail_2        M_f_Mail_3  FALSE  0.123
#> 80 Kimberly_w_Mail_3        M_f_Mail_3  FALSE -0.017
#> 81    Kevin_h_Mail_2        M_f_Mail_4  FALSE -0.148
#> 82 Kimberly_w_Mail_3        M_f_Mail_4  FALSE  0.057
#> 83    Kevin_h_Mail_2        M_f_Mail_5  FALSE  0.058
#> 84 Kimberly_w_Mail_3        M_f_Mail_5  FALSE -0.135
#> 85    Kevin_h_Mail_2        M_l_Mail_3  FALSE -0.214
#> 86 Kimberly_w_Mail_3        M_l_Mail_3  FALSE  0.053
#> 87    Kevin_h_Mail_2        M_l_Mail_1  FALSE  0.009
#> 88 Kimberly_w_Mail_3        M_l_Mail_1  FALSE  0.051
#> 89    Kevin_h_Mail_2        M_l_Mail_2  FALSE -0.143
#> 90 Kimberly_w_Mail_3        M_l_Mail_2  FALSE -0.046
#> 91    Kevin_h_Mail_2        M_l_Mail_4  FALSE  0.024
#> 92 Kimberly_w_Mail_3        M_l_Mail_4  FALSE -0.032
#> 93    Kevin_h_Mail_2        M_l_Mail_5  FALSE  0.036
#> 94 Kimberly_w_Mail_3        M_l_Mail_5  FALSE  0.064
```
