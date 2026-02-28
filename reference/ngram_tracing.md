# N-gram tracing

This function runs the authorship analysis method called *n-gram
tracing*, which can be used for both attribution and verification.

## Usage

``` r
ngram_tracing(
  q.data,
  k.data,
  tokens = "character",
  remove_punct = FALSE,
  remove_symbols = TRUE,
  remove_numbers = TRUE,
  lowercase = TRUE,
  n = 9,
  coefficient = "simpson",
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
  More than one sample for a candidate author is accepted but the
  function will combine them so to make a profile.

- tokens:

  The type of tokens to extract, either "word" or "character" (default).

- remove_punct:

  A logical value. FALSE (default) keeps punctuation marks.

- remove_symbols:

  A logical value. TRUE (default) removes symbols.

- remove_numbers:

  A logical value. TRUE (default) removes numbers.

- lowercase:

  A logical value. TRUE (default) transforms all tokens to lower case.

- n:

  The order or size of the n-grams being extracted. Default is 9.

- coefficient:

  The coefficient to use to compare texts, one of: "simpson" (default),
  "phi", "jaccard", "kulczynski", or "cole".

- features:

  Logical with default FALSE. If TRUE then the result table will contain
  the features in the overlap that are unique for that overlap in the
  corpus. If only two texts are present then this will return the
  n-grams in common.

- cores:

  The number of cores to use for parallel processing (the default is
  one).

## Value

The function will test all possible combinations of Q texts and
candidate authors and return a data frame containing the value of the
similarity coefficient selected called 'score' and an optional column
with the overlapping features that only occur in the Q and candidate
considered and in no other Qs (ordered by length if the n-gram is of
variable length). The data frame contains a column called 'target' with
a logical value which is TRUE if the author of the Q text is the
candidate and FALSE otherwise.

## Details

N-gram tracing was originally proposed by Grieve et al (2019). Nini
(2023) then proposed a mathematical reinterpretation that is compatible
with Cognitive Linguistic theories of language processing. He then
tested several variants of the method and found that the original
version, which uses the Simpson's coefficient, tends to be outperformed
by versions using the Phi coefficient, the Kulczynski's coefficient, and
the Cole coefficient. This function can run the n-gram tracing method
using any of these coefficients plus the Jaccard coefficient for
reference, as this coefficient has been applied in several forensic
linguistic studies.

## References

Grieve, Jack, Emily Chiang, Isobelle Clarke, Hannah Gideon, Aninna
Heini, Andrea Nini & Emily Waibel. 2019. Attributing the Bixby Letter
using n-gram tracing. Digital Scholarship in the Humanities 34(3).
493–512. Nini, Andrea. 2023. A Theory of Linguistic Individuality for
Authorship Analysis (Elements in Forensic Linguistics). Cambridge, UK:
Cambridge University Press.

## Examples

``` r
Q <- enron.sample[c(5:6)]
K <- enron.sample[-c(5:6)]
ngram_tracing(Q, K, coefficient = 'phi')
#>                    Q          K target  score
#> 1     Kevin_h_Mail_2    Kevin_h   TRUE  0.032
#> 2  Kimberly_w_Mail_3    Kevin_h  FALSE  0.030
#> 3     Kevin_h_Mail_2 Kimberly_w  FALSE  0.031
#> 4  Kimberly_w_Mail_3 Kimberly_w   TRUE  0.086
#> 5     Kevin_h_Mail_2    Larry_c  FALSE  0.028
#> 6  Kimberly_w_Mail_3    Larry_c  FALSE  0.027
#> 7     Kevin_h_Mail_2    Lindy_d  FALSE  0.026
#> 8  Kimberly_w_Mail_3    Lindy_d  FALSE  0.046
#> 9     Kevin_h_Mail_2      Liz_t  FALSE  0.033
#> 10 Kimberly_w_Mail_3      Liz_t  FALSE  0.048
#> 11    Kevin_h_Mail_2   Louise_k  FALSE  0.014
#> 12 Kimberly_w_Mail_3   Louise_k  FALSE  0.027
#> 13    Kevin_h_Mail_2     Lynn_b  FALSE  0.017
#> 14 Kimberly_w_Mail_3     Lynn_b  FALSE  0.040
#> 15    Kevin_h_Mail_2     Lysa_a  FALSE  0.006
#> 16 Kimberly_w_Mail_3     Lysa_a  FALSE -0.018
#> 17    Kevin_h_Mail_2        M_f  FALSE  0.021
#> 18 Kimberly_w_Mail_3        M_f  FALSE  0.038
#> 19    Kevin_h_Mail_2        M_l  FALSE  0.016
#> 20 Kimberly_w_Mail_3        M_l  FALSE  0.047
```
