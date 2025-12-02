# Calibrate scores into Log-Likelihood Ratios

This function is used to transform the scores returned by any of the
authorship analysis functions into a Log-Likelihood Ratio (LLR).

## Usage

``` r
calibrate_LLR(calibration.dataset, dataset, latex = FALSE)
```

## Arguments

- calibration.dataset:

  A data frame containing the calibration dataset, typically the output
  of an authorship analysis function like
  [`impostors()`](https://andreanini.github.io/idiolect/dev/reference/impostors.md).

- dataset:

  A data frame containing the scores that have to be calibrated into
  LLRs using the calibration dataset. This is typically the result of
  applying a function like
  [`impostors()`](https://andreanini.github.io/idiolect/dev/reference/impostors.md)
  to the Q texts.

- latex:

  A logical value. If FALSE (default), then the hypothesis labels are
  printed as plain text (Hp/Hd). If TRUE the labels are written to be
  read in LaTeX (\$H_p\$/\$H_d\$).

## Value

The function returns a data frame with the LLRs (base 10), as well as
the verbal label according to Marquis et al (2016) and a verbal
interpretation of the results.

## References

Marquis, Raymond, Alex Biedermann, Liv Cadola, Christophe Champod, Line
Gueissaz, Geneviève Massonnet, Williams David Mazzella, Franco Taroni &
Tacha Hicks. 2016. Discussion on how to implement a verbal scale in a
forensic laboratory: Benefits, pitfalls and suggestions to avoid
misunderstandings. Science & Justice 56(5). 364–370.
https://doi.org/10.1016/j.scijus.2016.05.009.

## Examples

``` r
calib <- data.frame(score = c(0.5, 0.2, 0.8, 0.01, 0.6), target = c(TRUE, FALSE, TRUE, FALSE, TRUE))
q <- data.frame(score = c(0.6, 0.002))
calibrate_LLR(calib, q)
#>   score     LLR                    Verbal label
#> 1 0.600  16.135 Extremely strong support for Hp
#> 2 0.002 -22.723 Extremely strong support for Hd
#>                                                                                                     Interpretation
#> 1    The similarity is 13645831365889294 times more likely to be observed in the case of Hp than in the case of Hd
#> 2 The similarity is 5.28445251775179e+22 times more likely to be observed in the case of Hd than in the case of Hp
```
