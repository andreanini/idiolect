# lambdaG visualize works

    Code
      lambdaG_visualize(q.data, k.data, ref.data, r = 2, print = "")
    Output
      $table
      # A tibble: 13 x 8
         sentence_id token_id t         lambdaG sentence_lambdaG zlambdaG
               <int>    <int> <chr>       <dbl>            <dbl>    <dbl>
       1           1        1 J          0.741            -0.767    1.28 
       2           1        2 N          0.325            -0.767    0.616
       3           1        3 ,         -1.08             -0.767   -1.64 
       4           1        4 but       -0.122            -0.767   -0.101
       5           1        5 that       0.148            -0.767    0.331
       6           1        6 's         1.03             -0.767    1.75 
       7           1        7 just      -1.05             -0.767   -1.58 
       8           1        8 the        0.178            -0.767    0.381
       9           1        9 N          0.0619           -0.767    0.194
      10           1       10 it        -0.773            -0.767   -1.15 
      11           1       11 works     -0.167            -0.767   -0.174
      12           1       12 .          0.0786           -0.767    0.221
      13           1       13 ___EOS___ -0.141            -0.767   -0.132
      # i 2 more variables: token_contribution <dbl>, sent_contribution <dbl>
      
      $colourcoded_text
      [1] " <span style=\"background-color: #fdedec;\">J</span> <span style=\"background-color: #FFFFFF;\">N</span> , but <span style=\"background-color: #FFFFFF;\">that</span> <span style=\"background-color: #f5b7b1;\">'s</span> just <span style=\"background-color: #FFFFFF;\">the</span> <span style=\"background-color: #FFFFFF;\">N</span> it works <span style=\"background-color: #FFFFFF;\">.</span> <br>"
      

---

    Code
      lambdaG_visualize(q.data, k.data, ref.data, r = 2, print = "", scale = "relative")
    Output
      $table
      # A tibble: 13 x 8
         sentence_id token_id t          lambdaG sentence_lambdaG zlambdaG
               <int>    <int> <chr>        <dbl>            <dbl>    <dbl>
       1           1        1 J          0.872              -0.16    1.19 
       2           1        2 N          0.225              -0.16    0.32 
       3           1        3 ,         -0.414              -0.16   -0.541
       4           1        4 but       -0.0897             -0.16   -0.104
       5           1        5 that      -1.82               -0.16   -2.44 
       6           1        6 's         1.49               -0.16    2.02 
       7           1        7 just      -0.281              -0.16   -0.361
       8           1        8 the        0.0341             -0.16    0.063
       9           1        9 N          0.0272             -0.16    0.053
      10           1       10 it        -0.0252             -0.16   -0.017
      11           1       11 works     -0.104              -0.16   -0.123
      12           1       12 .         -0.00152            -0.16    0.015
      13           1       13 ___EOS___ -0.0687             -0.16   -0.076
      # i 2 more variables: token_contribution <dbl>, sent_contribution <dbl>
      
      $colourcoded_text
      [1] " <span style=\"background-color: #F1948A;\">J</span> N , but that <span style=\"background-color: #E74C3C;\">'s</span> just the N it works . <br>"
      

