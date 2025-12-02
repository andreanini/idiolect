# Performance evaluation

This function is used to the test the performance of an authorship
analysis method.

## Usage

``` r
performance(training, test = NULL, by = "case", progress = TRUE)
```

## Arguments

- training:

  The data frame with the results to evaluate, typically the output of
  an authorship analysis function, such as
  [`impostors()`](https://andreanini.github.io/idiolect/dev/reference/impostors.md).
  If only training is present then the function will perform a
  leave-one-out cross-validation.

- test:

  Optional data frame of results. If present then a calibration model is
  extracted from training and its performance is evaluated on this data
  set.

- by:

  Either "case" or "author". If the performance is evaluated
  leave-one-out, then "case" would go through the table row by row
  while, if "author" is selected, then the performance is calculated
  after taking out each author (identified as a value of the K column).

- progress:

  Logical. If TRUE (default) then a progress bar is diplayed.

## Value

The function returns a list containing a data frame with performance
statistics, including an object that can be used to make a tippet plot
using the `tippet.plot()` function of the `ROC` package
(https://github.com/davidavdav/ROC).

## Details

Before applying a method to a real authorship case, it is good practice
to test it on known ground truth data. This function performs this test
by taking as input either a single table of results or two tables, one
for training and one for the test, and then returning as output a list
with the following performance statistics: the log-likelihood ratio cost
(both \\C\_{llr}\\ and \\C\_{llr}^{min}\\), Equal Error Rate (ERR), the
mean values of the log-likelihood ratio for both the same-author (TRUE)
and different-author (FALSE) cases, the Area Under the Curve (AUC),
Balanced Accuracy, Precision, Recall, F1, and the full confusion matrix.
The binary classification statistics are all calculated considering a
Log-Likelihood Ratio score of 0 as a threshold.

## Examples

``` r
results <- data.frame(score = c(0.5, 0.2, 0.8, 0.01), target = c(TRUE, FALSE, TRUE, FALSE))
perf <- performance(results)
#>   |                                                                              |                                                                      |   0%  |                                                                              |=======================                                               |  33%  |                                                                              |===============================================                       |  67%  |                                                                              |======================================================================| 100%
perf$evaluation
#>        Cllr  Cllr_min EER Mean TRUE LLR Mean FALSE LLR TRUE trials FALSE trials
#> 1 0.2422848 0.4150375  25      14.91206      -12.77601           4            4
#>   AUC Balanced Accuracy Precision Recall F1 TP FN FP TN
#> 1   1                 1         1      1  1  2  0  0  2
```
