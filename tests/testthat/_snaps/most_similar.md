# most_similar works

    Code
      most_similar(d[6, ], d[-6, ], coefficient = "minmax", n = 2)
    Output
      Document-feature matrix of: 2 documents, 1,500 features (52.77% sparse) and 3 docvars.
                                            features
      docs                                         n n n        n n  n n w  n wa
        known [Kimberly.watson - Mail_4].txt 0           0.004554865     0     0
        known [Kimberly.watson - Mail_5].txt 0.001333333 0.006222222     0     0
                                            features
      docs                                           want        s to          to b
        known [Kimberly.watson - Mail_4].txt 0.0020703934 0            0.0004140787
        known [Kimberly.watson - Mail_5].txt 0.0008888889 0.0004444444 0.0004444444
                                            features
      docs                                          to be        o be         e n w
        known [Kimberly.watson - Mail_4].txt 0.0004140787 0.0004140787 0.0004140787
        known [Kimberly.watson - Mail_5].txt 0.0004444444 0.0004444444 0.0004444444
      [ reached max_nfeat ... 1,490 more features ]

---

    Code
      most_similar(d[6, ], d[-6, ], coefficient = "cosine", n = 2)
    Output
      Document-feature matrix of: 2 documents, 1,500 features (52.77% sparse) and 3 docvars.
                                            features
      docs                                         n n n        n n  n n w  n wa
        known [Kimberly.watson - Mail_4].txt 0           0.004554865     0     0
        known [Kimberly.watson - Mail_5].txt 0.001333333 0.006222222     0     0
                                            features
      docs                                           want        s to          to b
        known [Kimberly.watson - Mail_4].txt 0.0020703934 0            0.0004140787
        known [Kimberly.watson - Mail_5].txt 0.0008888889 0.0004444444 0.0004444444
                                            features
      docs                                          to be        o be         e n w
        known [Kimberly.watson - Mail_4].txt 0.0004140787 0.0004140787 0.0004140787
        known [Kimberly.watson - Mail_5].txt 0.0004444444 0.0004444444 0.0004444444
      [ reached max_nfeat ... 1,490 more features ]

---

    Code
      most_similar(d[6, ], d[-6, ], coefficient = "Phi", n = 2)
    Output
      Document-feature matrix of: 2 documents, 118,154 features (98.48% sparse) and 3 docvars.
                                            features
      docs                                   n n n n   n n n w n n n wa  n n wan
        known [Kimberly.watson - Mail_4].txt        0        0        0        0
        known [Kimberly.watson - Mail_5].txt        0        0        0        0
                                            features
      docs                                   n n want  n wants     n wants 
        known [Kimberly.watson - Mail_4].txt        0        0 0.0004409171
        known [Kimberly.watson - Mail_5].txt        0        0 0           
                                            features
      docs                                        wants t wants to ants to 
        known [Kimberly.watson - Mail_4].txt 0.0004409171        0        0
        known [Kimberly.watson - Mail_5].txt 0                   0        0
      [ reached max_nfeat ... 118,144 more features ]

