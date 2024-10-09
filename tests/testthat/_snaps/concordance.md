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

---

    Code
      concordance(enron.sents[1], enron.sents[2], enron.sents[3:49], search = "? _EOS_",
      token.type = "word")
    Output
                         docname from   to                     pre    node
      1    known [Kh Mail_1].txt  232  233         but more is B J ? _EOS_
      2    known [Kh Mail_1].txt  279  280        it down , do you ? _EOS_
      3    known [Kh Mail_1].txt  320  321            N N , do you ? _EOS_
      4    known [Kh Mail_1].txt  642  643      look J with your N ? _EOS_
      5    known [Kh Mail_3].txt  138  139            can V my J N ? _EOS_
      6    known [Kh Mail_4].txt  115  116       N before you V it ? _EOS_
      7    known [Kh Mail_4].txt  168  169     over the N , anyway ? _EOS_
      8    known [Kh Mail_5].txt  146  147         with P P from P ? _EOS_
      9    known [Kh Mail_5].txt  165  166     N following the J N ? _EOS_
      10   known [Kh Mail_5].txt  641  642               a N D J D ? _EOS_
      11 unknown [Kh Mail_2].txt   78   79          to P using P P ? _EOS_
      12 unknown [Kh Mail_2].txt  106  107              N N N of D ? _EOS_
      13 unknown [Kw Mail_3].txt   86   87            have a N V N ? _EOS_
      14 unknown [Kw Mail_3].txt  193  194      and give us your N ? _EOS_
      15 unknown [Kw Mail_3].txt  277  278  any N regarding this N ? _EOS_
      16 unknown [Kw Mail_3].txt  362  363             for P ' s N ? _EOS_
      17 unknown [Kw Mail_3].txt  657  658      at this N , please ? _EOS_
      18 unknown [Kw Mail_3].txt  984  985             , N N and N ? _EOS_
      19   known [Kw Mail_1].txt   98   99            N from P P N ? _EOS_
      20   known [Kw Mail_1].txt  241  242         some N N J soon ? _EOS_
      21   known [Kw Mail_1].txt  514  515      to get to this one ? _EOS_
      22   known [Kw Mail_1].txt  898  899         one that V my N ? _EOS_
      23   known [Kw Mail_2].txt  224  225           N N after P V ? _EOS_
      24   known [Kw Mail_2].txt  481  482      your N N next week ? _EOS_
      25   known [Kw Mail_2].txt  813  814            in the P P N ? _EOS_
      26   known [Kw Mail_2].txt  841  842         the week of P D ? _EOS_
      27   known [Kw Mail_4].txt  254  255      you have N for all ? _EOS_
      28   known [Kw Mail_4].txt  378  379  your N since last week ? _EOS_
      29   known [Kw Mail_4].txt  391  392         N and N N again ? _EOS_
      30   known [Kw Mail_5].txt  165  166           J in may or P ? _EOS_
      31   known [Kw Mail_5].txt  342  343         N about the P N ? _EOS_
      32   known [Kw Mail_5].txt  396  397     but not all of them ? _EOS_
      33   known [Kw Mail_5].txt  413  414    with me about this N ? _EOS_
      34   known [Kw Mail_5].txt  499  500       to V with you yet ? _EOS_
      35   known [Kw Mail_5].txt  715  716            s N N this N ? _EOS_
      36   known [Lc Mail_3].txt  631  632             J N for a N ? _EOS_
      37   known [Lc Mail_4].txt   64   65               N N N P P ? _EOS_
      38   known [Lc Mail_5].txt  627  628      and what does it V ? _EOS_
      39 unknown [Ld Mail_4].txt   77   78      J N could there be ? _EOS_
      40 unknown [Ld Mail_4].txt  348  349       you V with this N ? _EOS_
      41 unknown [Ld Mail_4].txt  566  567            N N of the N ? _EOS_
      42 unknown [Ld Mail_4].txt  778  779          S N and call P ? _EOS_
      43   known [Ld Mail_1].txt  270  271           be V J than P ? _EOS_
      44   known [Ld Mail_1].txt  434  435         i using the J N ? _EOS_
      45   known [Ld Mail_1].txt  606  607            N from P P N ? _EOS_
      46   known [Ld Mail_2].txt  272  273              D by N N N ? _EOS_
      47   known [Ld Mail_2].txt  298  299            N on the J N ? _EOS_
      48   known [Ld Mail_2].txt  372  373  V this out to everyone ? _EOS_
      49   known [Ld Mail_3].txt   80   81              a N or J N ? _EOS_
      50   known [Ld Mail_3].txt  148  149       not B being V yet ? _EOS_
      51   known [Ld Mail_3].txt  395  396           you B it to P ? _EOS_
      52   known [Ld Mail_3].txt  548  549           her N N , etc ? _EOS_
      53   known [Ld Mail_5].txt  281  282       N when you have N ? _EOS_
      54   known [Ld Mail_5].txt  341  342        D N for me again ? _EOS_
      55 unknown [Lk Mail_4].txt   41   42    V to tell about this ? _EOS_
      56 unknown [Lk Mail_4].txt  176  177         P have in the N ? _EOS_
      57   known [Lk Mail_1].txt   11   12              N as a V N ? _EOS_
      58   known [Lk Mail_1].txt  177  178       and get them to V ? _EOS_
      59   known [Lk Mail_1].txt  186  187          you give P a N ? _EOS_
      60   known [Lk Mail_3].txt  540  541      - i really need it ? _EOS_
      61   known [Lk Mail_5].txt  104  105    B i should be asking ? _EOS_
      62   known [Lk Mail_5].txt  253  254        N that are now J ? _EOS_
      63   known [Lk Mail_5].txt  299  300          get in the J N ? _EOS_
      64   known [Lk Mail_5].txt  489  490              i V N on P ? _EOS_
      65   known [Lk Mail_5].txt  745  746             V on my N N ? _EOS_
      66 unknown [Lb Mail_3].txt   61   62        is she on that N ? _EOS_
      67 unknown [Lb Mail_3].txt   91   92        to be here for N ? _EOS_
      68 unknown [Lb Mail_3].txt  119  120  that you were not hear ? _EOS_
      69 unknown [Lb Mail_3].txt  188  189          of N on your N ? _EOS_
      70 unknown [Lb Mail_3].txt  201  202        N V with you out ? _EOS_
      71   known [Lb Mail_4].txt  109  110        in the three P P ? _EOS_
      72   known [Lb Mail_4].txt  529  530          N from the J N ? _EOS_
      73   known [Lb Mail_4].txt  547  548            to J J N out ? _EOS_
      74   known [Lb Mail_4].txt  561  562              to V a P N ? _EOS_
      75   known [Lb Mail_4].txt  608  609      and keep their N V ? _EOS_
      76   known [Lb Mail_4].txt  636  637             for P ' s N ? _EOS_
      77   known [Lb Mail_4].txt  783  784          N from the J N ? _EOS_
      78   known [Lb Mail_5].txt   17   18            to J J N out ? _EOS_
      79   known [Lb Mail_5].txt   31   32              to V a P N ? _EOS_
      80   known [Lb Mail_5].txt   78   79      and keep their N V ? _EOS_
      81   known [Lb Mail_5].txt  192  193            the J N as P ? _EOS_
      82   known [Lb Mail_5].txt  212  213              V at a J N ? _EOS_
      83   known [Lb Mail_5].txt  261  262      would our N V from ? _EOS_
      84 unknown [La Mail_3].txt  782  783 been giving N all along ? _EOS_
      85   known [La Mail_4].txt  551  552           to get N to V ? _EOS_
      86 unknown [Mf Mail_1].txt 1048 1049           N - what is V ? _EOS_
      87   known [Mf Mail_2].txt  440  441           in the N on P ? _EOS_
      88   known [Mf Mail_2].txt  633  634           is this J N J ? _EOS_
      89   known [Mf Mail_2].txt  657  658     nt showing on our N ? _EOS_
      90   known [Mf Mail_2].txt  772  773             my N on P N ? _EOS_
      91   known [Mf Mail_2].txt  800  801           N for P and P ? _EOS_
      92   known [Mf Mail_3].txt  603  604          the N that i V ? _EOS_
      93   known [Mf Mail_4].txt  124  125     . what do you think ? _EOS_
      94   known [Mf Mail_5].txt  397  398             all P J N N ? _EOS_
      95 unknown [Ml Mail_3].txt  163  164             N P V up to ? _EOS_
      96 unknown [Ml Mail_3].txt  186  187         to the P this N ? _EOS_
      97   known [Ml Mail_4].txt  209  210            a J N for me ? _EOS_
      98   known [Ml Mail_5].txt  253  254   come work for you too ? _EOS_
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

