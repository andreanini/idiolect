# vectorisation works

    Code
      vectorize(enron, tokens = "character", remove_punct = F, remove_symbols = T,
        remove_numbers = T, lowercase = T, n = 5, weighting = "rel", trim = T,
        threshold = 1500)
    Output
      Document-feature matrix of: 218 documents, 1,500 features (54.35% sparse) and 3 docvars.
                                              features
      docs                                            n n n        n n         n n w
        known [Kevin.hyatt - Mail_1].txt       0.0015866720 0.005950020 0.0007933360
        known [Kevin.hyatt - Mail_3].txt       0.0031298905 0.018257694 0.0015649452
        known [Kevin.hyatt - Mail_4].txt       0.0008896797 0.004893238 0.0008896797
        known [Kevin.hyatt - Mail_5].txt       0.0021929825 0.010087719 0.0017543860
        unknown [Kevin.hyatt - Mail_2].txt     0.0026258206 0.014879650 0           
        unknown [Kimberly.watson - Mail_3].txt 0.0009976721 0.006983705 0.0003325574
                                              features
      docs                                             n wa         want        s to 
        known [Kevin.hyatt - Mail_1].txt       0.0003966680 0.0023800079 0.0011900040
        known [Kevin.hyatt - Mail_3].txt       0.0010432968 0            0.0010432968
        known [Kevin.hyatt - Mail_4].txt       0.0004448399 0.0008896797 0           
        known [Kevin.hyatt - Mail_5].txt       0.0004385965 0            0           
        unknown [Kevin.hyatt - Mail_2].txt     0.0008752735 0.0004376368 0           
        unknown [Kimberly.watson - Mail_3].txt 0            0.0006651147 0.0003325574
                                              features
      docs                                             to b        to be        o be 
        known [Kevin.hyatt - Mail_1].txt       0.0007933360 0.0007933360 0.0007933360
        known [Kevin.hyatt - Mail_3].txt       0.0005216484 0.0005216484 0.0005216484
        known [Kevin.hyatt - Mail_4].txt       0.0008896797 0.0008896797 0.0004448399
        known [Kevin.hyatt - Mail_5].txt       0.0008771930 0.0008771930 0.0008771930
        unknown [Kevin.hyatt - Mail_2].txt     0.0004376368 0.0004376368 0.0004376368
        unknown [Kimberly.watson - Mail_3].txt 0.0003325574 0.0006651147 0.0003325574
                                              features
      docs                                            e n w
        known [Kevin.hyatt - Mail_1].txt       0.0007933360
        known [Kevin.hyatt - Mail_3].txt       0.0020865936
        known [Kevin.hyatt - Mail_4].txt       0.0008896797
        known [Kevin.hyatt - Mail_5].txt       0.0013157895
        unknown [Kevin.hyatt - Mail_2].txt     0.0017505470
        unknown [Kimberly.watson - Mail_3].txt 0.0003325574
      [ reached max_ndoc ... 212 more documents, reached max_nfeat ... 1,490 more features ]

