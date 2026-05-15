# Posterior prosecution probabilities and odds

This function takes as input a value of the Log-Likelihood Ratio and
returns a table that shows the impact on some simulated prior
probabilities for the prosecution hypothesis.

## Usage

``` r
posterior(LLR, prior = NULL)
```

## Arguments

- LLR:

  One single numeric value corresponding to a Log-Likelihood Ratio (base
  10).

- prior:

  A prior probability or a vector or prior probabilities (for the
  prosecution hypothesis). If missing then a range of prior
  probabilities is provided.

## Value

A data frame containing some simulated prior probabilities/odds for the
prosecution and the resulting posterior probabilities/odds after the
LLR.

## Examples

``` r
posterior(LLR = 0)
#> # A tibble: 11 × 6
#>    prosecution_prior_probs prior_odds   LLR    LR  post_odds
#>                      <dbl>      <dbl> <dbl> <dbl>      <dbl>
#>  1                0.000001 0.00000100     0     1 0.00000100
#>  2                0.01     0.0101         0     1 0.0101    
#>  3                0.1      0.111          0     1 0.111     
#>  4                0.2      0.25           0     1 0.25      
#>  5                0.3      0.429          0     1 0.429     
#>  6                0.4      0.667          0     1 0.667     
#>  7                0.5      1              0     1 1         
#>  8                0.6      1.5            0     1 1.5       
#>  9                0.7      2.33           0     1 2.33      
#> 10                0.8      4              0     1 4         
#> 11                0.9      9              0     1 9         
#> # ℹ 1 more variable: prosecution_post_probs <dbl>
posterior(LLR = 1.8)
#> # A tibble: 11 × 6
#>    prosecution_prior_probs prior_odds   LLR    LR   post_odds
#>                      <dbl>      <dbl> <dbl> <dbl>       <dbl>
#>  1                0.000001 0.00000100   1.8  63.1   0.0000631
#>  2                0.01     0.0101       1.8  63.1   0.637    
#>  3                0.1      0.111        1.8  63.1   7.01     
#>  4                0.2      0.25         1.8  63.1  15.8      
#>  5                0.3      0.429        1.8  63.1  27.0      
#>  6                0.4      0.667        1.8  63.1  42.1      
#>  7                0.5      1            1.8  63.1  63.1      
#>  8                0.6      1.5          1.8  63.1  94.6      
#>  9                0.7      2.33         1.8  63.1 147.       
#> 10                0.8      4            1.8  63.1 252.       
#> 11                0.9      9            1.8  63.1 568.       
#> # ℹ 1 more variable: prosecution_post_probs <dbl>
posterior(LLR = -0.5, prior = 0.9)
#> # A tibble: 1 × 6
#>   prosecution_prior_pr…¹ prior_odds   LLR    LR post_odds prosecution_post_probs
#>                    <dbl>      <dbl> <dbl> <dbl>     <dbl>                  <dbl>
#> 1                    0.9          9  -0.5 0.316      2.85                  0.740
#> # ℹ abbreviated name: ¹​prosecution_prior_probs
posterior(LLR = -0.5, prior = c(0.1, 0.9))
#> # A tibble: 2 × 6
#>   prosecution_prior_pr…¹ prior_odds   LLR    LR post_odds prosecution_post_probs
#>                    <dbl>      <dbl> <dbl> <dbl>     <dbl>                  <dbl>
#> 1                    0.1      0.111  -0.5 0.316    0.0351                 0.0339
#> 2                    0.9      9      -0.5 0.316    2.85                   0.740 
#> # ℹ abbreviated name: ¹​prosecution_prior_probs
```
