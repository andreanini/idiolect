# concordancer works

    Code
      concordance(enron.sample[1], enron.sample[2], enron.sample[3:49], search = "wants to",
      token.type = "word")
    Output
                      docname from  to                 pre     node           post
      1 known [Kh Mail_1].txt    5   6             N N N N wants to be N when he V
      2 known [Ld Mail_5].txt  160 161          D S D . he wants to   V to V the N
      3 known [Lb Mail_1].txt  573 574 our N . anyone that wants to    V us is J .
        authorship
      1          Q
      2  Reference
      3  Reference

---

    Code
      concordance(enron.sample[1], enron.sample[2], enron.sample[3:49], search = "want*",
      token.type = "character")
    Output
                         docname from   to   pre  node  post authorship
      1    known [Kh Mail_1].txt    9   13  N N  wants  to b          Q
      2    known [Kh Mail_1].txt  250  254 ight  want  to ma          Q
      3    known [Kh Mail_1].txt 1306 1310  n't  want  an N           Q
      4    known [Kh Mail_1].txt 1339 1343  n't  want  to he          Q
      5    known [Kh Mail_1].txt 2009 2013  you  want  help           Q
      6    known [Kh Mail_1].txt 2131 2135  you  want  N or           Q
      7    known [Kh Mail_4].txt 1531 1535 f we  wante d to   Reference
      8    known [Kh Mail_4].txt 1611 1615  you  wante d to   Reference
      9  unknown [Kh Mail_2].txt 2193 2197 have  wante d for  Reference
      10 unknown [Kw Mail_3].txt 1182 1186 just  want  to ma  Reference
      11 unknown [Kw Mail_3].txt 2818 2822 t he  wante d to   Reference
      12   known [Kw Mail_1].txt  655  659  , i  wante d to   Reference
      13   known [Kw Mail_1].txt  801  805 just  wante d to   Reference
      14   known [Kw Mail_1].txt 1716 1720 w we  want  to V   Reference
      15   known [Kw Mail_1].txt 1758 1762  , i  wante d you  Reference
      16   known [Kw Mail_2].txt 1099 1103 just  wante d to   Reference
      17   known [Kw Mail_2].txt 1684 1688 f we  want  to V   Reference
      18   known [Kw Mail_2].txt 2294 2298  you  want  me to  Reference
      19   known [Kw Mail_2].txt 2482 2486  n't  want  this   Reference
      20   known [Kw Mail_2].txt 2612 2616  and  wante d to   Reference
      21   known [Kw Mail_4].txt  559  563 just  wante d to   Reference
      22   known [Kw Mail_4].txt  703  707 just  want  to ma  Reference
      23   known [Kw Mail_4].txt 1467 1471  . N  wants  this  Reference
      24   known [Kw Mail_4].txt 1581 1585 just  wante d you  Reference
      25   known [Kw Mail_4].txt 2477 2481 also  want  a few  Reference
      26   known [Kw Mail_5].txt   69   73 just  wante d you  Reference
      27   known [Kw Mail_5].txt 2348 2352  P i  wante d to   Reference
      28   known [Lc Mail_3].txt 2636 2640  you  want  me to  Reference
      29   known [Lc Mail_4].txt 1002 1006 also  want  to V   Reference
      30   known [Lc Mail_5].txt  550  554  you  want  me to  Reference
      31 unknown [Ld Mail_4].txt 2084 2088 just  wante d to   Reference
      32 unknown [Ld Mail_4].txt 2264 2268  and  want  to ge  Reference
      33   known [Ld Mail_1].txt 1826 1830 just  wante d to   Reference
      34   known [Ld Mail_2].txt  193  197 w we  want  to le  Reference
      35   known [Ld Mail_2].txt  877  881  ? i  want  to ma  Reference
      36   known [Ld Mail_2].txt 1767 1771  and  wante d to   Reference
      37   known [Ld Mail_5].txt  494  498 . he  wants  to V  Reference
      38   known [Ld Mail_5].txt 1114 1118 just  wante d to   Reference
      39 unknown [Lt Mail_2].txt 1406 1410  P N  wanti ng to  Reference
      40   known [Lt Mail_4].txt 1273 1277 ould  want  to V   Reference
      41   known [Lt Mail_4].txt 2049 2053  you  want  to ta  Reference
      42   known [Lk Mail_1].txt  750  754  not  want  . obv  Reference
      43   known [Lk Mail_1].txt 1740 1744 t we  want  to sa  Reference
      44   known [Lk Mail_2].txt 1712 1716 ut i  wante d to   Reference
      45   known [Lk Mail_2].txt 1775 1779 they  want  a N o  Reference
      46   known [Lk Mail_3].txt 1800 1804 till  want  as mu  Reference
      47 unknown [Lb Mail_3].txt  957  961  , i  wante d to   Reference
      48 unknown [Lb Mail_3].txt 1036 1040  may  want  to lo  Reference
      49 unknown [Lb Mail_3].txt 2242 2246  . i  want  to V   Reference
      50   known [Lb Mail_1].txt 1716 1720  not  want  to V   Reference
      51   known [Lb Mail_1].txt 1800 1804 that  wants  to V  Reference
      52   known [Lb Mail_4].txt  399  403 just  wante d to   Reference
      53   known [Lb Mail_4].txt 1208 1212 just  wante d to   Reference
      54   known [La Mail_2].txt  317  321  you  want  to be  Reference
      55 unknown [Mf Mail_1].txt  227  231  P P  wants  me t  Reference
      56 unknown [Mf Mail_1].txt  434  438  P P  wants  me t  Reference
      57 unknown [Mf Mail_1].txt 1820 1824 do i  want  to li  Reference
      58 unknown [Mf Mail_1].txt 2620 2624  one  wants  me i  Reference
      59   known [Mf Mail_2].txt  233  237  S P  wants  this  Reference
      60   known [Mf Mail_3].txt  306  310 also  wante d to   Reference
      61   known [Mf Mail_4].txt 1791 1795 o nt  want  to le  Reference
      62   known [Mf Mail_4].txt 2564 2568 they  want  to V   Reference
      63   known [Mf Mail_4].txt 2827 2831  not  want  to V   Reference
      64 unknown [Ml Mail_3].txt 1296 1300  B i  want  this   Reference
      65   known [Ml Mail_1].txt  728  732 t we  wante d to   Reference
      66   known [Ml Mail_1].txt  872  876  you  want  to V   Reference
      67   known [Ml Mail_1].txt 2776 2780 d we  want  to be  Reference
      68   known [Ml Mail_2].txt  166  170 just  wante d to   Reference
      69   known [Ml Mail_4].txt  786  790  P i  wante d to   Reference
      70   known [Ml Mail_4].txt 1084 1088 just  want  a J N  Reference
      71   known [Ml Mail_4].txt 1488 1492 nd P  want  their  Reference
      72   known [Ml Mail_4].txt 1874 1878  and  want  a N o  Reference
      73   known [Ml Mail_5].txt  792  796  n't  want  me to  Reference
      74   known [Ml Mail_5].txt 1713 1717  may  want  to al  Reference
      75   known [Ml Mail_5].txt 1916 1920 will  want  to ke  Reference
      76   known [Ml Mail_5].txt 1980 1984 mply  wante d to   Reference

---

    Code
      concordance(enron.sample[1], enron.sample[2], search = "want*", token.type = "character")
    Output
                      docname from   to   pre  node  post authorship
      1 known [Kh Mail_1].txt    9   13  N N  wants  to b          Q
      2 known [Kh Mail_1].txt  250  254 ight  want  to ma          Q
      3 known [Kh Mail_1].txt 1306 1310  n't  want  an N           Q
      4 known [Kh Mail_1].txt 1339 1343  n't  want  to he          Q
      5 known [Kh Mail_1].txt 2009 2013  you  want  help           Q
      6 known [Kh Mail_1].txt 2131 2135  you  want  N or           Q

