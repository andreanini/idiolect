# most_similar works

    Code
      most_similar(d[6, ], d[-6, ], measure = "minmax", n = 2)
    Output
      Document-feature matrix of: 2 documents, 1,515 features (52.90% sparse) and 3 docvars.
                                            features
      docs                                         n n n        n n  n n w  n wa
        known [Kimberly.watson - Mail_4].txt 0           0.006027397     0     0
        known [Kimberly.watson - Mail_5].txt 0.001747234 0.008153757     0     0
                                            features
      docs                                          want        s to          to b
        known [Kimberly.watson - Mail_4].txt 0.002739726 0            0.0005479452
        known [Kimberly.watson - Mail_5].txt 0.001164822 0.0005824112 0.0005824112
                                            features
      docs                                          to be        o be         e n w
        known [Kimberly.watson - Mail_4].txt 0.0005479452 0.0005479452 0.0005479452
        known [Kimberly.watson - Mail_5].txt 0.0005824112 0.0005824112 0.0005824112
      [ reached max_nfeat ... 1,505 more features ]

---

    Code
      most_similar(d[6, ], d[-6, ], measure = "Phi", n = 2)
    Output
      Document-feature matrix of: 2 documents, 49,917 features (96.84% sparse) and 3 docvars.
                                            features
      docs                                   n n n n   n n n w n n n wa  n n wan
        known [Kimberly.watson - Mail_4].txt        0        0        0        0
        known [Kimberly.watson - Mail_5].txt        0        0        0        0
                                            features
      docs                                   n n want  n wants    n wants 
        known [Kimberly.watson - Mail_4].txt        0        0 0.000489716
        known [Kimberly.watson - Mail_5].txt        0        0 0          
                                            features
      docs                                       wants t wants to ants to 
        known [Kimberly.watson - Mail_4].txt 0.000489716        0        0
        known [Kimberly.watson - Mail_5].txt 0                  0        0
      [ reached max_nfeat ... 49,907 more features ]

