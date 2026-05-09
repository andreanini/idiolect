# calibration works

    Code
      results
    Output
      # A tibble: 10 x 7
         k               q           target score    LLR `Verbal label` Interpretation
         <chr>           <chr>       <lgl>  <dbl>  <dbl> <chr>          <chr>         
       1 Kevin.hyatt     unknown [K~ TRUE   0.468  0.063 Weak support ~ The similarit~
       2 Kevin.hyatt     unknown [K~ FALSE  0.134 -0.892 Weak support ~ The similarit~
       3 Kimberly.watson unknown [K~ TRUE   1      1.58  Moderate supp~ The similarit~
       4 Kimberly.watson unknown [L~ FALSE  0.11  -0.961 Weak support ~ The similarit~
       5 Larry.campbell  unknown [L~ TRUE   1      1.58  Moderate supp~ The similarit~
       6 Larry.campbell  unknown [L~ FALSE  0.468  0.063 Weak support ~ The similarit~
       7 Lindy.donoho    unknown [L~ TRUE   0.858  1.18  Moderate supp~ The similarit~
       8 Lindy.donoho    unknown [L~ FALSE  0.165 -0.803 Weak support ~ The similarit~
       9 Liz.taylor      unknown [L~ TRUE   0.589  0.41  Weak support ~ The similarit~
      10 Liz.taylor      unknown [L~ FALSE  0.405 -0.117 Weak support ~ The similarit~

# calibration leave-one-out works

    Code
      results2
    Output
                       k                                      q target score     LLR
      1      Kevin.hyatt     unknown [Kevin.hyatt - Mail_2].txt   TRUE 0.468  -9.154
      2      Kevin.hyatt unknown [Kimberly.watson - Mail_3].txt  FALSE 0.134 -42.994
      3  Kimberly.watson unknown [Kimberly.watson - Mail_3].txt   TRUE 1.000  69.506
      4  Kimberly.watson  unknown [Larry.campbell - Mail_1].txt  FALSE 0.110 -46.115
      5   Larry.campbell  unknown [Larry.campbell - Mail_1].txt   TRUE 1.000  69.506
      6   Larry.campbell    unknown [Lindy.donoho - Mail_4].txt  FALSE 0.468   9.211
      7     Lindy.donoho    unknown [Lindy.donoho - Mail_4].txt   TRUE 0.858  50.676
      8     Lindy.donoho      unknown [Liz.taylor - Mail_2].txt  FALSE 0.165 -38.975
      9       Liz.taylor      unknown [Liz.taylor - Mail_2].txt   TRUE 0.589  15.646
      10      Liz.taylor  unknown [Louise.kitchen - Mail_4].txt  FALSE 0.405  -4.317
                            Verbal label
      1  Extremely strong support for Hd
      2  Extremely strong support for Hd
      3  Extremely strong support for Hp
      4  Extremely strong support for Hd
      5  Extremely strong support for Hp
      6  Extremely strong support for Hp
      7  Extremely strong support for Hp
      8  Extremely strong support for Hd
      9  Extremely strong support for Hp
      10 Extremely strong support for Hd
                                                                                                           Interpretation
      1          The similarity is 1425607593.6 times more likely to be observed in the case of Hd than in the case of Hp
      2   The similarity is 9.8627948563121e+42 times more likely to be observed in the case of Hd than in the case of Hp
      3  The similarity is 3.20626932450547e+69 times more likely to be observed in the case of Hp than in the case of Hd
      4  The similarity is 1.30316677845231e+46 times more likely to be observed in the case of Hd than in the case of Hp
      5  The similarity is 3.20626932450547e+69 times more likely to be observed in the case of Hp than in the case of Hd
      6         The similarity is 1625548755.75 times more likely to be observed in the case of Hp than in the case of Hd
      7  The similarity is 4.74241985260247e+50 times more likely to be observed in the case of Hp than in the case of Hd
      8  The similarity is 9.44060876285926e+38 times more likely to be observed in the case of Hd than in the case of Hp
      9      The similarity is 4425883723626274 times more likely to be observed in the case of Hp than in the case of Hd
      10             The similarity is 20749.14 times more likely to be observed in the case of Hd than in the case of Hp

