# vectorisation works

    Code
      vectorize(enron)
    Output
      Document-feature matrix of: 218 documents, 1,515 features (54.55% sparse) and 3 docvars.
                                              features
      docs                                           n n n        n n        n n w
        known [Kevin.hyatt - Mail_1].txt       0.002466091 0.009247842 0.001233046
        known [Kevin.hyatt - Mail_3].txt       0.004382761 0.025566107 0.002191381
        known [Kevin.hyatt - Mail_4].txt       0.001286174 0.007073955 0.001286174
        known [Kevin.hyatt - Mail_5].txt       0.003298153 0.015171504 0.002638522
        unknown [Kevin.hyatt - Mail_2].txt     0.003726708 0.021118012 0          
        unknown [Kimberly.watson - Mail_3].txt 0.001339884 0.009379187 0.000446628
                                              features
      docs                                             n wa         want       s to 
        known [Kevin.hyatt - Mail_1].txt       0.0006165228 0.0036991369 0.001849568
        known [Kevin.hyatt - Mail_3].txt       0.0014609204 0            0.001460920
        known [Kevin.hyatt - Mail_4].txt       0.0006430868 0.0012861736 0          
        known [Kevin.hyatt - Mail_5].txt       0.0006596306 0            0          
        unknown [Kevin.hyatt - Mail_2].txt     0.0012422360 0.0006211180 0          
        unknown [Kimberly.watson - Mail_3].txt 0            0.0008932559 0.000446628
                                              features
      docs                                             to b        to be        o be 
        known [Kevin.hyatt - Mail_1].txt       0.0012330456 0.0012330456 0.0012330456
        known [Kevin.hyatt - Mail_3].txt       0.0007304602 0.0007304602 0.0007304602
        known [Kevin.hyatt - Mail_4].txt       0.0012861736 0.0012861736 0.0006430868
        known [Kevin.hyatt - Mail_5].txt       0.0013192612 0.0013192612 0.0013192612
        unknown [Kevin.hyatt - Mail_2].txt     0.0006211180 0.0006211180 0.0006211180
        unknown [Kimberly.watson - Mail_3].txt 0.0004466280 0.0008932559 0.0004466280
                                              features
      docs                                           e n w
        known [Kevin.hyatt - Mail_1].txt       0.001233046
        known [Kevin.hyatt - Mail_3].txt       0.002921841
        known [Kevin.hyatt - Mail_4].txt       0.001286174
        known [Kevin.hyatt - Mail_5].txt       0.001978892
        unknown [Kevin.hyatt - Mail_2].txt     0.002484472
        unknown [Kimberly.watson - Mail_3].txt 0.000446628
      [ reached max_ndoc ... 212 more documents, reached max_nfeat ... 1,505 more features ]

