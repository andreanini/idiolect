# lambdaG patterns works

    Code
      lambdaG_patterns(q.data, k.data, ref.data, r = 2)
    Output
      # A tibble: 27 x 4
         context       token     n    llr
         <chr>         <chr> <int>  <dbl>
       1 N ,           but       3 0.757 
       2 J N ,         but       4 0.645 
       3 ,             but       2 0.617 
       4 J N           ,         3 0.560 
       5 ___BOS___ J N ,         4 0.519 
       6 N             ,         2 0.481 
       7 ___BOS___     J         2 0.461 
       8 ___BOS___ J   N         3 0.229 
       9 J             N         2 0.113 
      10 the           N         2 0.0387
      # i 17 more rows

