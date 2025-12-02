# Apply the LambdaG algorithm

This function calculates the likelihood ratio of grammar models, or
\\\lambda_G\\, as in Nini et al. (under review). In order to run the
analysis as in this paper, all data must be preprocessed using
[`contentmask()`](https://andreanini.github.io/idiolect/dev/reference/contentmask.md)
with the "algorithm" parameter set to "POSnoise".

## Usage

``` r
lambdaG(q.data, k.data, ref.data, N = 10, r = 30, cores = NULL)
```

## Arguments

- q.data:

  The questioned or disputed data as a `quanteda` tokens object with the
  tokens being sentences (e.g. the output of
  [`tokenize_sents()`](https://andreanini.github.io/idiolect/dev/reference/tokenize_sents.md)).

- k.data:

  The known or undisputed data as a `quanteda` tokens object with the
  tokens being sentences (e.g. the output of
  [`tokenize_sents()`](https://andreanini.github.io/idiolect/dev/reference/tokenize_sents.md)).

- ref.data:

  The reference dataset as a `quanteda` tokens object with the tokens
  being sentences (e.g. the output of
  [`tokenize_sents()`](https://andreanini.github.io/idiolect/dev/reference/tokenize_sents.md)).
  This can be the same object as `k.data`.

- N:

  The order of the model. Default is 10.

- r:

  The number of iterations. Default is 30.

- cores:

  The number of cores to use for parallel processing (the default is
  one).

## Value

The function will test all possible combinations of Q texts and
candidate authors and return a data frame containing \\\lambda_G\\, an
uncalibrated log-likelihood ratio (base 10). \\\lambda_G\\ can then be
calibrated into a likelihood ratio that expresses the strength of the
evidence using
[`calibrate_LLR()`](https://andreanini.github.io/idiolect/dev/reference/calibrate_LLR.md).
The data frame contains a column called "target" with a logical value
which is TRUE if the author of the Q text is the candidate and FALSE
otherwise.

## References

Nini, A., Halvani, O., Graner, L., Gherardi, V., Ishihara, S. Authorship
Verification based on the Likelihood Ratio of Grammar Models.
https://arxiv.org/abs/2403.08462v1

## Examples

``` r
q.data <- enron.sample[1] |> quanteda::tokens("sentence")
k.data <- enron.sample[2:10] |> quanteda::tokens("sentence")
ref.data <- enron.sample[11:ndoc(enron.sample)] |> quanteda::tokens("sentence")
lambdaG(q.data, k.data, ref.data)
#>    K                     Q target  score
#> 1 Kh known [Kh Mail_1].txt   TRUE 37.171
#> 2 Kw known [Kh Mail_1].txt  FALSE -6.720
```
