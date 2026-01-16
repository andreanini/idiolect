# concordancer works

    Code
      concordance(enron.sample[1], enron.sample[2], enron.sample[3:49], search = "wants to",
      token.type = "word")
    Output
               docname from  to                 pre     node           post
      1 Kevin_h_Mail_1    5   6             N N N N wants to be N when he V
      2 Lindy_d_Mail_5  160 161          D S D . he wants to   V to V the N
      3  Lynn_b_Mail_1  573 574 our N . anyone that wants to    V us is J .
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
      1     Kevin_h_Mail_1    9   13  N N  wants  to b          Q
      2     Kevin_h_Mail_1  250  254 ight  want  to ma          Q
      3     Kevin_h_Mail_1 1306 1310  n't  want  an N           Q
      4     Kevin_h_Mail_1 1339 1343  n't  want  to he          Q
      5     Kevin_h_Mail_1 2009 2013  you  want  help           Q
      6     Kevin_h_Mail_1 2131 2135  you  want  N or           Q
      7     Kevin_h_Mail_4 1531 1535 f we  wante d to   Reference
      8     Kevin_h_Mail_4 1611 1615  you  wante d to   Reference
      9     Kevin_h_Mail_2 2193 2197 have  wante d for  Reference
      10 Kimberly_w_Mail_3 1182 1186 just  want  to ma  Reference
      11 Kimberly_w_Mail_3 2818 2822 t he  wante d to   Reference
      12 Kimberly_w_Mail_1  655  659  , i  wante d to   Reference
      13 Kimberly_w_Mail_1  801  805 just  wante d to   Reference
      14 Kimberly_w_Mail_1 1716 1720 w we  want  to V   Reference
      15 Kimberly_w_Mail_1 1758 1762  , i  wante d you  Reference
      16 Kimberly_w_Mail_2 1099 1103 just  wante d to   Reference
      17 Kimberly_w_Mail_2 1684 1688 f we  want  to V   Reference
      18 Kimberly_w_Mail_2 2294 2298  you  want  me to  Reference
      19 Kimberly_w_Mail_2 2482 2486  n't  want  this   Reference
      20 Kimberly_w_Mail_2 2612 2616  and  wante d to   Reference
      21 Kimberly_w_Mail_4  559  563 just  wante d to   Reference
      22 Kimberly_w_Mail_4  703  707 just  want  to ma  Reference
      23 Kimberly_w_Mail_4 1467 1471  . N  wants  this  Reference
      24 Kimberly_w_Mail_4 1581 1585 just  wante d you  Reference
      25 Kimberly_w_Mail_4 2477 2481 also  want  a few  Reference
      26 Kimberly_w_Mail_5   69   73 just  wante d you  Reference
      27 Kimberly_w_Mail_5 2348 2352  P i  wante d to   Reference
      28    Larry_c_Mail_3 2636 2640  you  want  me to  Reference
      29    Larry_c_Mail_4 1002 1006 also  want  to V   Reference
      30    Larry_c_Mail_5  550  554  you  want  me to  Reference
      31    Lindy_d_Mail_4 2084 2088 just  wante d to   Reference
      32    Lindy_d_Mail_4 2264 2268  and  want  to ge  Reference
      33    Lindy_d_Mail_1 1826 1830 just  wante d to   Reference
      34    Lindy_d_Mail_2  193  197 w we  want  to le  Reference
      35    Lindy_d_Mail_2  877  881  ? i  want  to ma  Reference
      36    Lindy_d_Mail_2 1767 1771  and  wante d to   Reference
      37    Lindy_d_Mail_5  494  498 . he  wants  to V  Reference
      38    Lindy_d_Mail_5 1114 1118 just  wante d to   Reference
      39      Liz_t_Mail_2 1406 1410  P N  wanti ng to  Reference
      40      Liz_t_Mail_4 1273 1277 ould  want  to V   Reference
      41      Liz_t_Mail_4 2049 2053  you  want  to ta  Reference
      42   Louise_k_Mail_1  750  754  not  want  . obv  Reference
      43   Louise_k_Mail_1 1740 1744 t we  want  to sa  Reference
      44   Louise_k_Mail_2 1712 1716 ut i  wante d to   Reference
      45   Louise_k_Mail_2 1775 1779 they  want  a N o  Reference
      46   Louise_k_Mail_3 1800 1804 till  want  as mu  Reference
      47     Lynn_b_Mail_3  957  961  , i  wante d to   Reference
      48     Lynn_b_Mail_3 1036 1040  may  want  to lo  Reference
      49     Lynn_b_Mail_3 2242 2246  . i  want  to V   Reference
      50     Lynn_b_Mail_1 1716 1720  not  want  to V   Reference
      51     Lynn_b_Mail_1 1800 1804 that  wants  to V  Reference
      52     Lynn_b_Mail_4  399  403 just  wante d to   Reference
      53     Lynn_b_Mail_4 1208 1212 just  wante d to   Reference
      54     Lysa_a_Mail_2  317  321  you  want  to be  Reference
      55        M_f_Mail_1  227  231  P P  wants  me t  Reference
      56        M_f_Mail_1  434  438  P P  wants  me t  Reference
      57        M_f_Mail_1 1820 1824 do i  want  to li  Reference
      58        M_f_Mail_1 2620 2624  one  wants  me i  Reference
      59        M_f_Mail_2  233  237  S P  wants  this  Reference
      60        M_f_Mail_3  306  310 also  wante d to   Reference
      61        M_f_Mail_4 1791 1795 o nt  want  to le  Reference
      62        M_f_Mail_4 2564 2568 they  want  to V   Reference
      63        M_f_Mail_4 2827 2831  not  want  to V   Reference
      64        M_l_Mail_3 1296 1300  B i  want  this   Reference
      65        M_l_Mail_1  728  732 t we  wante d to   Reference
      66        M_l_Mail_1  872  876  you  want  to V   Reference
      67        M_l_Mail_1 2776 2780 d we  want  to be  Reference
      68        M_l_Mail_2  166  170 just  wante d to   Reference
      69        M_l_Mail_4  786  790  P i  wante d to   Reference
      70        M_l_Mail_4 1084 1088 just  want  a J N  Reference
      71        M_l_Mail_4 1488 1492 nd P  want  their  Reference
      72        M_l_Mail_4 1874 1878  and  want  a N o  Reference
      73        M_l_Mail_5  792  796  n't  want  me to  Reference
      74        M_l_Mail_5 1713 1717  may  want  to al  Reference
      75        M_l_Mail_5 1916 1920 will  want  to ke  Reference
      76        M_l_Mail_5 1980 1984 mply  wante d to   Reference

---

    Code
      concordance(enron.sample[1], enron.sample[2], search = "want*", token.type = "character")
    Output
               docname from   to   pre  node  post authorship
      1 Kevin_h_Mail_1    9   13  N N  wants  to b          Q
      2 Kevin_h_Mail_1  250  254 ight  want  to ma          Q
      3 Kevin_h_Mail_1 1306 1310  n't  want  an N           Q
      4 Kevin_h_Mail_1 1339 1343  n't  want  to he          Q
      5 Kevin_h_Mail_1 2009 2013  you  want  help           Q
      6 Kevin_h_Mail_1 2131 2135  you  want  N or           Q

---

    Code
      concordance(enron.sents[1], enron.sents[2], enron.sents[3:49], search = "? _EOS_",
      token.type = "word")
    Output
                   docname from   to                     pre    node
      1     Kevin_h_Mail_1  232  233         but more is B J ? _EOS_
      2     Kevin_h_Mail_1  279  280        it down , do you ? _EOS_
      3     Kevin_h_Mail_1  320  321            N N , do you ? _EOS_
      4     Kevin_h_Mail_1  642  643      look J with your N ? _EOS_
      5     Kevin_h_Mail_3  138  139            can V my J N ? _EOS_
      6     Kevin_h_Mail_4  115  116       N before you V it ? _EOS_
      7     Kevin_h_Mail_4  168  169     over the N , anyway ? _EOS_
      8     Kevin_h_Mail_5  146  147         with P P from P ? _EOS_
      9     Kevin_h_Mail_5  165  166     N following the J N ? _EOS_
      10    Kevin_h_Mail_5  641  642               a N D J D ? _EOS_
      11    Kevin_h_Mail_2   78   79          to P using P P ? _EOS_
      12    Kevin_h_Mail_2  106  107              N N N of D ? _EOS_
      13 Kimberly_w_Mail_3   86   87            have a N V N ? _EOS_
      14 Kimberly_w_Mail_3  193  194      and give us your N ? _EOS_
      15 Kimberly_w_Mail_3  277  278  any N regarding this N ? _EOS_
      16 Kimberly_w_Mail_3  362  363             for P ' s N ? _EOS_
      17 Kimberly_w_Mail_3  657  658      at this N , please ? _EOS_
      18 Kimberly_w_Mail_3  984  985             , N N and N ? _EOS_
      19 Kimberly_w_Mail_1   98   99            N from P P N ? _EOS_
      20 Kimberly_w_Mail_1  241  242         some N N J soon ? _EOS_
      21 Kimberly_w_Mail_1  514  515      to get to this one ? _EOS_
      22 Kimberly_w_Mail_1  898  899         one that V my N ? _EOS_
      23 Kimberly_w_Mail_2  224  225           N N after P V ? _EOS_
      24 Kimberly_w_Mail_2  481  482      your N N next week ? _EOS_
      25 Kimberly_w_Mail_2  813  814            in the P P N ? _EOS_
      26 Kimberly_w_Mail_2  841  842         the week of P D ? _EOS_
      27 Kimberly_w_Mail_4  254  255      you have N for all ? _EOS_
      28 Kimberly_w_Mail_4  378  379  your N since last week ? _EOS_
      29 Kimberly_w_Mail_4  391  392         N and N N again ? _EOS_
      30 Kimberly_w_Mail_5  165  166           J in may or P ? _EOS_
      31 Kimberly_w_Mail_5  342  343         N about the P N ? _EOS_
      32 Kimberly_w_Mail_5  396  397     but not all of them ? _EOS_
      33 Kimberly_w_Mail_5  413  414    with me about this N ? _EOS_
      34 Kimberly_w_Mail_5  499  500       to V with you yet ? _EOS_
      35 Kimberly_w_Mail_5  715  716            s N N this N ? _EOS_
      36    Larry_c_Mail_3  631  632             J N for a N ? _EOS_
      37    Larry_c_Mail_4   64   65               N N N P P ? _EOS_
      38    Larry_c_Mail_5  627  628      and what does it V ? _EOS_
      39    Lindy_d_Mail_4   77   78      J N could there be ? _EOS_
      40    Lindy_d_Mail_4  348  349       you V with this N ? _EOS_
      41    Lindy_d_Mail_4  566  567            N N of the N ? _EOS_
      42    Lindy_d_Mail_4  778  779          S N and call P ? _EOS_
      43    Lindy_d_Mail_1  270  271           be V J than P ? _EOS_
      44    Lindy_d_Mail_1  434  435         i using the J N ? _EOS_
      45    Lindy_d_Mail_1  606  607            N from P P N ? _EOS_
      46    Lindy_d_Mail_2  272  273              D by N N N ? _EOS_
      47    Lindy_d_Mail_2  298  299            N on the J N ? _EOS_
      48    Lindy_d_Mail_2  372  373  V this out to everyone ? _EOS_
      49    Lindy_d_Mail_3   80   81              a N or J N ? _EOS_
      50    Lindy_d_Mail_3  148  149       not B being V yet ? _EOS_
      51    Lindy_d_Mail_3  395  396           you B it to P ? _EOS_
      52    Lindy_d_Mail_3  548  549           her N N , etc ? _EOS_
      53    Lindy_d_Mail_5  281  282       N when you have N ? _EOS_
      54    Lindy_d_Mail_5  341  342        D N for me again ? _EOS_
      55   Louise_k_Mail_4   41   42    V to tell about this ? _EOS_
      56   Louise_k_Mail_4  176  177         P have in the N ? _EOS_
      57   Louise_k_Mail_1   11   12              N as a V N ? _EOS_
      58   Louise_k_Mail_1  177  178       and get them to V ? _EOS_
      59   Louise_k_Mail_1  186  187          you give P a N ? _EOS_
      60   Louise_k_Mail_3  540  541      - i really need it ? _EOS_
      61   Louise_k_Mail_5  104  105    B i should be asking ? _EOS_
      62   Louise_k_Mail_5  253  254        N that are now J ? _EOS_
      63   Louise_k_Mail_5  299  300          get in the J N ? _EOS_
      64   Louise_k_Mail_5  489  490              i V N on P ? _EOS_
      65   Louise_k_Mail_5  745  746             V on my N N ? _EOS_
      66     Lynn_b_Mail_3   61   62        is she on that N ? _EOS_
      67     Lynn_b_Mail_3   91   92        to be here for N ? _EOS_
      68     Lynn_b_Mail_3  119  120  that you were not hear ? _EOS_
      69     Lynn_b_Mail_3  188  189          of N on your N ? _EOS_
      70     Lynn_b_Mail_3  201  202        N V with you out ? _EOS_
      71     Lynn_b_Mail_4  109  110        in the three P P ? _EOS_
      72     Lynn_b_Mail_4  529  530          N from the J N ? _EOS_
      73     Lynn_b_Mail_4  547  548            to J J N out ? _EOS_
      74     Lynn_b_Mail_4  561  562              to V a P N ? _EOS_
      75     Lynn_b_Mail_4  608  609      and keep their N V ? _EOS_
      76     Lynn_b_Mail_4  636  637             for P ' s N ? _EOS_
      77     Lynn_b_Mail_4  783  784          N from the J N ? _EOS_
      78     Lynn_b_Mail_5   17   18            to J J N out ? _EOS_
      79     Lynn_b_Mail_5   31   32              to V a P N ? _EOS_
      80     Lynn_b_Mail_5   78   79      and keep their N V ? _EOS_
      81     Lynn_b_Mail_5  192  193            the J N as P ? _EOS_
      82     Lynn_b_Mail_5  212  213              V at a J N ? _EOS_
      83     Lynn_b_Mail_5  261  262      would our N V from ? _EOS_
      84     Lysa_a_Mail_3  782  783 been giving N all along ? _EOS_
      85     Lysa_a_Mail_4  551  552           to get N to V ? _EOS_
      86        M_f_Mail_1 1048 1049           N - what is V ? _EOS_
      87        M_f_Mail_2  440  441           in the N on P ? _EOS_
      88        M_f_Mail_2  633  634           is this J N J ? _EOS_
      89        M_f_Mail_2  657  658     nt showing on our N ? _EOS_
      90        M_f_Mail_2  772  773             my N on P N ? _EOS_
      91        M_f_Mail_2  800  801           N for P and P ? _EOS_
      92        M_f_Mail_3  603  604          the N that i V ? _EOS_
      93        M_f_Mail_4  124  125     . what do you think ? _EOS_
      94        M_f_Mail_5  397  398             all P J N N ? _EOS_
      95        M_l_Mail_3  163  164             N P V up to ? _EOS_
      96        M_l_Mail_3  186  187         to the P this N ? _EOS_
      97        M_l_Mail_4  209  210            a J N for me ? _EOS_
      98        M_l_Mail_5  253  254   come work for you too ? _EOS_
                                 post authorship
      1          _BOS_ let me know if          Q
      2         _BOS_ that would be J          Q
      3           _BOS_ if you wo n't          Q
      4         _BOS_ come to us with          Q
      5                 _BOS_ N , P P          K
      6           _BOS_ the N is that  Reference
      7          _BOS_ the N that you  Reference
      8            _BOS_ how B do you  Reference
      9            _BOS_ i would V to  Reference
      10                _BOS_ i ' m V  Reference
      11        _BOS_ what does the N  Reference
      12               _BOS_ J N at D  Reference
      13       _BOS_ also , there was  Reference
      14               _BOS_ P , as i  Reference
      15           _BOS_ J is V after  Reference
      16           _BOS_ when i was V  Reference
      17            _BOS_ P and i are  Reference
      18    _BOS_ we are also running  Reference
      19            _BOS_ her N N has  Reference
      20     _BOS_ sorry , my earlier  Reference
      21          _BOS_ i V that this  Reference
      22             _BOS_ also , i '  Reference
      23       _BOS_ i will then save  Reference
      24            _BOS_ we have a N  Reference
      25            _BOS_ P , we have  Reference
      26               _BOS_ my J N ,  Reference
      27             _BOS_ hi P and P  Reference
      28         _BOS_ may i have her  Reference
      29           _BOS_ it is very J  Reference
      30               _BOS_ B we V B  Reference
      31            _BOS_ i need to V  Reference
      32           _BOS_ are you J on  Reference
      33              _BOS_ P P and P  Reference
      34        _BOS_ i must not have  Reference
      35            _BOS_ it was so B  Reference
      36                _BOS_ P , i V  Reference
      37       _BOS_ just to keep all  Reference
      38  _BOS_ i need something from  Reference
      39             _BOS_ it was a N  Reference
      40            _BOS_ if we did V  Reference
      41         _BOS_ to save us the  Reference
      42           _BOS_ i need the J  Reference
      43         _BOS_ the first N is  Reference
      44     _BOS_ they are not going  Reference
      45              _BOS_ the P P N  Reference
      46         _BOS_ i want to make  Reference
      47           _BOS_ i do n't see  Reference
      48          _BOS_ P asked me to  Reference
      49       _BOS_ you had asked to  Reference
      50            _BOS_ i V it will  Reference
      51               _BOS_ he ' s J  Reference
      52            _BOS_ i V you all  Reference
      53               _BOS_ to V P '  Reference
      54                _BOS_ J P P N  Reference
      55                _BOS_ J N J N  Reference
      56              _BOS_ our J N N  Reference
      57          _BOS_ what is the V  Reference
      58         _BOS_ did you give P  Reference
      59            _BOS_ the N is to  Reference
      60          _BOS_ i called P at  Reference
      61               _BOS_ N up , i  Reference
      62          _BOS_ before P V he  Reference
      63         _BOS_ if you have an  Reference
      64       _BOS_ you should not V  Reference
      65            _BOS_ here ' s my  Reference
      66                _BOS_ P , i V  Reference
      67 _BOS_ since you are becoming  Reference
      68             _BOS_ V is the N  Reference
      69          _BOS_ did we B have  Reference
      70      _BOS_ just trying to be  Reference
      71     _BOS_ please let me know  Reference
      72       _BOS_ where can i find  Reference
      73          _BOS_ what N are in  Reference
      74                _BOS_ N - P P  Reference
      75             _BOS_ so B the J  Reference
      76          _BOS_ V we give you  Reference
      77                               Reference
      78          _BOS_ what N are in  Reference
      79                _BOS_ N - P P  Reference
      80           _BOS_ P we may not  Reference
      81        _BOS_ seems J since P  Reference
      82                _BOS_ a N N B  Reference
      83             _BOS_ N can V up  Reference
      84          _BOS_ P did say for  Reference
      85      _BOS_ the N has already  Reference
      86      _BOS_ what other N need  Reference
      87      _BOS_ we have already V  Reference
      88           _BOS_ is J N being  Reference
      89       _BOS_ any help you can  Reference
      90         _BOS_ let me know if  Reference
      91          _BOS_ we have had N  Reference
      92              _BOS_ i can V J  Reference
      93              _BOS_ my N is P  Reference
      94       _BOS_ you did this for  Reference
      95             _BOS_ i V she is  Reference
      96          _BOS_ just to V you  Reference
      97               _BOS_ i V so ,  Reference
      98          _BOS_ N N are going  Reference

