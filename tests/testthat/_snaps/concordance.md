# concordancer works

    Code
      concordance(enron.sample[1], enron.sample[2], enron.sample[3:49], search = "wants to",
      token.type = "word")
    Output
                                  docname from  to                 pre  keyword
      1  known [Kevin.hyatt - Mail_1].txt    5   6             N N N N wants to
      2 known [Lindy.donoho - Mail_5].txt  160 161          D S D . he wants to
      3   known [Lynn.blair - Mail_1].txt  573 574 our N . anyone that wants to
                  post authorship
      1 be N when he V          Q
      2   V to V the N  Reference
      3    V us is J .  Reference

---

    Code
      concordance(enron.sample[1], enron.sample[2], enron.sample[3:49], search = "want*",
      token.type = "character")
    Output
                                        docname from   to   pre keyword  post
      1        known [Kevin.hyatt - Mail_1].txt    9   13  N N    wants  to b
      2        known [Kevin.hyatt - Mail_1].txt  250  254 ight    want  to ma
      3        known [Kevin.hyatt - Mail_1].txt 1306 1310  n't    want  an N 
      4        known [Kevin.hyatt - Mail_1].txt 1339 1343  n't    want  to he
      5        known [Kevin.hyatt - Mail_1].txt 2009 2013  you    want  help 
      6        known [Kevin.hyatt - Mail_1].txt 2131 2135  you    want  N or 
      7        known [Kevin.hyatt - Mail_4].txt 1531 1535 f we    wante d to 
      8        known [Kevin.hyatt - Mail_4].txt 1611 1615  you    wante d to 
      9      unknown [Kevin.hyatt - Mail_2].txt 2193 2197 have    wante d for
      10 unknown [Kimberly.watson - Mail_3].txt 1182 1186 just    want  to ma
      11 unknown [Kimberly.watson - Mail_3].txt 2818 2822 t he    wante d to 
      12   known [Kimberly.watson - Mail_1].txt  655  659  , i    wante d to 
      13   known [Kimberly.watson - Mail_1].txt  801  805 just    wante d to 
      14   known [Kimberly.watson - Mail_1].txt 1716 1720 w we    want  to V 
      15   known [Kimberly.watson - Mail_1].txt 1758 1762  , i    wante d you
      16   known [Kimberly.watson - Mail_2].txt 1099 1103 just    wante d to 
      17   known [Kimberly.watson - Mail_2].txt 1684 1688 f we    want  to V 
      18   known [Kimberly.watson - Mail_2].txt 2294 2298  you    want  me to
      19   known [Kimberly.watson - Mail_2].txt 2482 2486  n't    want  this 
      20   known [Kimberly.watson - Mail_2].txt 2612 2616  and    wante d to 
      21   known [Kimberly.watson - Mail_4].txt  559  563 just    wante d to 
      22   known [Kimberly.watson - Mail_4].txt  703  707 just    want  to ma
      23   known [Kimberly.watson - Mail_4].txt 1467 1471  . N    wants  this
      24   known [Kimberly.watson - Mail_4].txt 1581 1585 just    wante d you
      25   known [Kimberly.watson - Mail_4].txt 2477 2481 also    want  a few
      26   known [Kimberly.watson - Mail_5].txt   69   73 just    wante d you
      27   known [Kimberly.watson - Mail_5].txt 2348 2352  P i    wante d to 
      28    known [Larry.campbell - Mail_3].txt 2636 2640  you    want  me to
      29    known [Larry.campbell - Mail_4].txt 1002 1006 also    want  to V 
      30    known [Larry.campbell - Mail_5].txt  550  554  you    want  me to
      31    unknown [Lindy.donoho - Mail_4].txt 2084 2088 just    wante d to 
      32    unknown [Lindy.donoho - Mail_4].txt 2264 2268  and    want  to ge
      33      known [Lindy.donoho - Mail_1].txt 1826 1830 just    wante d to 
      34      known [Lindy.donoho - Mail_2].txt  193  197 w we    want  to le
      35      known [Lindy.donoho - Mail_2].txt  877  881  ? i    want  to ma
      36      known [Lindy.donoho - Mail_2].txt 1767 1771  and    wante d to 
      37      known [Lindy.donoho - Mail_5].txt  494  498 . he    wants  to V
      38      known [Lindy.donoho - Mail_5].txt 1114 1118 just    wante d to 
      39      unknown [Liz.taylor - Mail_2].txt 1406 1410  P N    wanti ng to
      40        known [Liz.taylor - Mail_4].txt 1273 1277 ould    want  to V 
      41        known [Liz.taylor - Mail_4].txt 2049 2053  you    want  to ta
      42    known [Louise.kitchen - Mail_1].txt  750  754  not    want  . obv
      43    known [Louise.kitchen - Mail_1].txt 1740 1744 t we    want  to sa
      44    known [Louise.kitchen - Mail_2].txt 1712 1716 ut i    wante d to 
      45    known [Louise.kitchen - Mail_2].txt 1775 1779 they    want  a N o
      46    known [Louise.kitchen - Mail_3].txt 1800 1804 till    want  as mu
      47      unknown [Lynn.blair - Mail_3].txt  957  961  , i    wante d to 
      48      unknown [Lynn.blair - Mail_3].txt 1036 1040  may    want  to lo
      49      unknown [Lynn.blair - Mail_3].txt 2242 2246  . i    want  to V 
      50        known [Lynn.blair - Mail_1].txt 1716 1720  not    want  to V 
      51        known [Lynn.blair - Mail_1].txt 1800 1804 that    wants  to V
      52        known [Lynn.blair - Mail_4].txt  399  403 just    wante d to 
      53        known [Lynn.blair - Mail_4].txt 1208 1212 just    wante d to 
      54         known [Lysa.akin - Mail_2].txt  317  321  you    want  to be
      55        unknown [M.forney - Mail_1].txt  227  231  P P    wants  me t
      56        unknown [M.forney - Mail_1].txt  434  438  P P    wants  me t
      57        unknown [M.forney - Mail_1].txt 1820 1824 do i    want  to li
      58        unknown [M.forney - Mail_1].txt 2620 2624  one    wants  me i
      59          known [M.forney - Mail_2].txt  233  237  S P    wants  this
      60          known [M.forney - Mail_3].txt  306  310 also    wante d to 
      61          known [M.forney - Mail_4].txt 1791 1795 o nt    want  to le
      62          known [M.forney - Mail_4].txt 2564 2568 they    want  to V 
      63          known [M.forney - Mail_4].txt 2827 2831  not    want  to V 
      64          unknown [M.love - Mail_3].txt 1296 1300  B i    want  this 
      65            known [M.love - Mail_1].txt  728  732 t we    wante d to 
      66            known [M.love - Mail_1].txt  872  876  you    want  to V 
      67            known [M.love - Mail_1].txt 2776 2780 d we    want  to be
      68            known [M.love - Mail_2].txt  166  170 just    wante d to 
      69            known [M.love - Mail_4].txt  786  790  P i    wante d to 
      70            known [M.love - Mail_4].txt 1084 1088 just    want  a J N
      71            known [M.love - Mail_4].txt 1488 1492 nd P    want  their
      72            known [M.love - Mail_4].txt 1874 1878  and    want  a N o
      73            known [M.love - Mail_5].txt  792  796  n't    want  me to
      74            known [M.love - Mail_5].txt 1713 1717  may    want  to al
      75            known [M.love - Mail_5].txt 1916 1920 will    want  to ke
      76            known [M.love - Mail_5].txt 1980 1984 mply    wante d to 
         authorship
      1           Q
      2           Q
      3           Q
      4           Q
      5           Q
      6           Q
      7   Reference
      8   Reference
      9   Reference
      10  Reference
      11  Reference
      12  Reference
      13  Reference
      14  Reference
      15  Reference
      16  Reference
      17  Reference
      18  Reference
      19  Reference
      20  Reference
      21  Reference
      22  Reference
      23  Reference
      24  Reference
      25  Reference
      26  Reference
      27  Reference
      28  Reference
      29  Reference
      30  Reference
      31  Reference
      32  Reference
      33  Reference
      34  Reference
      35  Reference
      36  Reference
      37  Reference
      38  Reference
      39  Reference
      40  Reference
      41  Reference
      42  Reference
      43  Reference
      44  Reference
      45  Reference
      46  Reference
      47  Reference
      48  Reference
      49  Reference
      50  Reference
      51  Reference
      52  Reference
      53  Reference
      54  Reference
      55  Reference
      56  Reference
      57  Reference
      58  Reference
      59  Reference
      60  Reference
      61  Reference
      62  Reference
      63  Reference
      64  Reference
      65  Reference
      66  Reference
      67  Reference
      68  Reference
      69  Reference
      70  Reference
      71  Reference
      72  Reference
      73  Reference
      74  Reference
      75  Reference
      76  Reference

