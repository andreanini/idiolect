# vectorisation works

    Code
      vectorize(enron)
    Output
      Document-feature matrix of: 218 documents, 1,509 features (52.65% sparse) and 3 docvars.
                                              features
      docs                                           n n n        n n         n n w
        known [Kevin.hyatt - Mail_1].txt       0.002289639 0.008586148 0.0011448197
        known [Kevin.hyatt - Mail_3].txt       0.004084411 0.023825732 0.0020422056
        known [Kevin.hyatt - Mail_4].txt       0.001191895 0.006555423 0.0011918951
        known [Kevin.hyatt - Mail_5].txt       0.003021148 0.013897281 0.0024169184
        unknown [Kevin.hyatt - Mail_2].txt     0.003460208 0.019607843 0           
        unknown [Kimberly.watson - Mail_3].txt 0.001237624 0.008663366 0.0004125413
                                              features
      docs                                             n wa         want        s to 
        known [Kevin.hyatt - Mail_1].txt       0.0005724098 0.0034344591 0.0017172295
        known [Kevin.hyatt - Mail_3].txt       0.0013614704 0            0.0013614704
        known [Kevin.hyatt - Mail_4].txt       0.0005959476 0.0011918951 0           
        known [Kevin.hyatt - Mail_5].txt       0.0006042296 0            0           
        unknown [Kevin.hyatt - Mail_2].txt     0.0011534025 0.0005767013 0           
        unknown [Kimberly.watson - Mail_3].txt 0            0.0008250825 0.0004125413
                                              features
      docs                                             to b        to be        o be 
        known [Kevin.hyatt - Mail_1].txt       0.0011448197 0.0011448197 0.0011448197
        known [Kevin.hyatt - Mail_3].txt       0.0013614704 0.0006807352 0.0006807352
        known [Kevin.hyatt - Mail_4].txt       0.0011918951 0.0011918951 0.0005959476
        known [Kevin.hyatt - Mail_5].txt       0.0012084592 0.0012084592 0.0012084592
        unknown [Kevin.hyatt - Mail_2].txt     0.0005767013 0.0005767013 0.0005767013
        unknown [Kimberly.watson - Mail_3].txt 0.0004125413 0.0008250825 0.0004125413
                                              features
      docs                                            e n w
        known [Kevin.hyatt - Mail_1].txt       0.0011448197
        known [Kevin.hyatt - Mail_3].txt       0.0027229408
        known [Kevin.hyatt - Mail_4].txt       0.0011918951
        known [Kevin.hyatt - Mail_5].txt       0.0018126888
        unknown [Kevin.hyatt - Mail_2].txt     0.0023068051
        unknown [Kimberly.watson - Mail_3].txt 0.0004125413
      [ reached max_ndoc ... 212 more documents, reached max_nfeat ... 1,499 more features ]

