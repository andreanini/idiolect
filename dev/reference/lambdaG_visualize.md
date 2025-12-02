# Visualize the output of the LambdaG algorithm

This function outputs a colour-coded list of sentences belonging to the
input Q text ordered from highest to lowest \\\lambda_G\\, as shown in
Nini et al. (under review).

## Usage

``` r
lambdaG_visualize(
  q.data,
  k.data,
  ref.data,
  N = 10,
  r = 30,
  output = "html",
  print = "",
  scale = "absolute",
  negative = FALSE,
  order.by = "importance",
  cores = NULL
)
```

## Arguments

- q.data:

  A single questioned or disputed text as a `quanteda` tokens object
  with the tokens being sentences (e.g. the output of
  [`tokenize_sents()`](https://andreanini.github.io/idiolect/dev/reference/tokenize_sents.md)).

- k.data:

  A known or undisputed corpus containing exclusively a single candidate
  author's texts as a `quanteda` tokens object with the tokens being
  sentences (e.g. the output of
  [`tokenize_sents()`](https://andreanini.github.io/idiolect/dev/reference/tokenize_sents.md)).

- ref.data:

  The reference dataset as a `quanteda` tokens object with the tokens
  being sentences (e.g. the output of
  [`tokenize_sents()`](https://andreanini.github.io/idiolect/dev/reference/tokenize_sents.md)).

- N:

  The order of the model. Default is 10.

- r:

  The number of iterations. Default is 30.

- output:

  A string detailing the file type of the colour-coded text output.
  Either "html" (default) or "latex".

- print:

  A string indicating the path and filename to save the colour-coded
  text file. If left empty (default), then nothing is printed.

- scale:

  A string indicating what scale to use to colour-code the text file. If
  "absolute" (default) then the raw \\\lambda_G\\ is used; if
  "relative", then the z-score of \\\lambda_G\\ over the Q data is used
  instead, thus showing relative importance.

- negative:

  Logical. If TRUE then negative values of \\\lambda_G\\ are color-coded
  in blue, otherwise (default) only the positive values of \\\lambda_G\\
  are displayed in red. This only applies to HTML output.

- order.by:

  A string indicating the order of the output. If "importance" (default)
  then the output is ordered by sentence \\\lambda_G\\ in descending
  order, otherwise the text is displayed and ordered as it appears.

- cores:

  The number of cores to use for parallel processing (the default is
  one).

## Value

The function outputs a list of two objects: a data frame with each row
being a token in the Q text and the values of \\\lambda_G\\ for the
token and sentences, in decreasing order of sentence \\\lambda_G\\ and
with the relative contribution of each token and each sentence to the
final \\\lambda_G\\ in percentage; the raw code in html or LaTeX that
generates the colour-coded file. If a path is provided for the print
argument then the function will also save the colour-coded text as an
html or plain text file.

## References

Nini, A., Halvani, O., Graner, L., Gherardi, V., Ishihara, S. Authorship
Verification based on the Likelihood Ratio of Grammar Models.
https://arxiv.org/abs/2403.08462v1

## Examples

``` r
q.data <- corpus_trim(enron.sample[1], "sentences", max_ntoken = 10) |> quanteda::tokens("sentence")
k.data <- enron.sample[2:5]|> quanteda::tokens("sentence")
ref.data <- enron.sample[6:ndoc(enron.sample)] |> quanteda::tokens("sentence")
outputs <- lambdaG_visualize(q.data, k.data, ref.data, r = 2)
outputs$table
#> # A tibble: 13 × 8
#>    sentence_id token_id t          lambdaG sentence_lambdaG zlambdaG
#>          <int>    <int> <chr>        <dbl>            <dbl>    <dbl>
#>  1           1        1 J          0.00220            0.311   -0.055
#>  2           1        2 N          0.0641             0.311    0.102
#>  3           1        3 ,         -0.748              0.311   -1.96 
#>  4           1        4 but        0.430              0.311    1.03 
#>  5           1        5 that      -0.120              0.311   -0.365
#>  6           1        6 's         1.02               0.311    2.53 
#>  7           1        7 just      -0.0203             0.311   -0.112
#>  8           1        8 the        0.0379             0.311    0.035
#>  9           1        9 N          0.0181             0.311   -0.015
#> 10           1       10 it        -0.236              0.311   -0.658
#> 11           1       11 works     -0.0908             0.311   -0.291
#> 12           1       12 .          0.0214             0.311   -0.006
#> 13           1       13 ___EOS___ -0.0696             0.311   -0.237
#> # ℹ 2 more variables: token_contribution <dbl>, sent_contribution <dbl>
```
