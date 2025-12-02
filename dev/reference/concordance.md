# Qualitative examination of evidence

This function uses
[`quanteda::kwic()`](https://quanteda.io/reference/kwic.html) to return
a concordance for a search pattern. The function takes as input three
datasets and a pattern and returns a data frame with the hits labelled
for authorship.

## Usage

``` r
concordance(
  q.data,
  k.data,
  reference.data,
  search,
  token.type = "word",
  window = 5,
  case_insensitive = TRUE
)
```

## Arguments

- q.data:

  A `quanteda` corpus object, such as the output of
  [`create_corpus()`](https://andreanini.github.io/idiolect/dev/reference/create_corpus.md),
  or a tokens object with tokens being sentences, such as the output of
  [`tokenize_sents()`](https://andreanini.github.io/idiolect/dev/reference/tokenize_sents.md).

- k.data:

  A `quanteda` corpus object, such as the output of
  [`create_corpus()`](https://andreanini.github.io/idiolect/dev/reference/create_corpus.md),
  or a tokens object with tokens being sentences, such as the output of
  [`tokenize_sents()`](https://andreanini.github.io/idiolect/dev/reference/tokenize_sents.md).

- reference.data:

  A `quanteda` corpus object, such as the output of
  [`create_corpus()`](https://andreanini.github.io/idiolect/dev/reference/create_corpus.md),
  or a tokens object with tokens being sentences, such as the output of
  [`tokenize_sents()`](https://andreanini.github.io/idiolect/dev/reference/tokenize_sents.md).
  This is optional.

- search:

  A string. It can be any sequence of characters and it also accepts the
  use of \* as a wildcard. The special tokens for sentence boundaries
  are '*BOS*' for beginning of sentence and '*EOS*' for end of sentence.

- token.type:

  Choice between "word" (default), which searches for word or
  punctuation mark tokens, or "character", which instead uses a single
  character search.

- window:

  The number of context items to be displayed around the keyword (a
  [`quanteda::kwic()`](https://quanteda.io/reference/kwic.html)
  parameter).

- case_insensitive:

  Logical; if TRUE, ignore case (a
  [`quanteda::kwic()`](https://quanteda.io/reference/kwic.html)
  parameter).

## Value

The function returns a data frame containing the concordances for the
search pattern.

## Examples

``` r
concordance(enron.sample[1], enron.sample[2], enron.sample[3:49], "wants to", token.type = "word")
#>                 docname from  to                 pre     node           post
#> 1 known [Kh Mail_1].txt    5   6             N N N N wants to be N when he V
#> 2 known [Ld Mail_5].txt  160 161          D S D . he wants to   V to V the N
#> 3 known [Lb Mail_1].txt  573 574 our N . anyone that wants to    V us is J .
#>   authorship
#> 1          Q
#> 2  Reference
#> 3  Reference

#using wildcards
concordance(enron.sample[1], enron.sample[2], enron.sample[3:49], "want * to", token.type = "word")
#>                 docname from  to                pre       node
#> 1 known [Kw Mail_2].txt  672 674 let me know if you want me to
#> 2 known [Lc Mail_5].txt  175 177       s N . if you want me to
#> 3 known [Ml Mail_5].txt  242 244  need . you do n't want me to
#>                    post authorship
#> 1       V on other N in  Reference
#> 2        , i can put on  Reference
#> 3 come work for you too  Reference

#searching character sequences with wildcards
concordance(enron.sample[1], enron.sample[2], enron.sample[3:49], "help*", token.type = "character")
#>                    docname from   to   pre  node  post authorship
#> 1    known [Kh Mail_1].txt  703  707 need  help  V it           Q
#> 2    known [Kh Mail_1].txt 2014 2018 want  help  V it           Q
#> 3    known [Kh Mail_3].txt 1797 1801  N ,  helpe d the          K
#> 4    known [Kh Mail_4].txt   52   56  P P  helpe d the  Reference
#> 5  unknown [Kw Mail_3].txt 2756 2760 ding  help  in th  Reference
#> 6    known [Kw Mail_5].txt   31   35 your  help  and N  Reference
#> 7    known [Kw Mail_5].txt 1463 1467 need  help  in do  Reference
#> 8    known [Lc Mail_2].txt 1600 1604 some  help  . why  Reference
#> 9    known [Lc Mail_5].txt 1163 1167 d of  help  and B  Reference
#> 10   known [Ld Mail_2].txt  285  289 ally  help  us ou  Reference
#> 11   known [Lt Mail_1].txt  884  888 r be  helpi ng to  Reference
#> 12   known [Lt Mail_1].txt  919  923 , or  help  V a N  Reference
#> 13   known [Lt Mail_3].txt  910  914 your  help  as a   Reference
#> 14   known [Lt Mail_4].txt 1611 1615 ttle  help  from   Reference
#> 15 unknown [Lk Mail_4].txt 1243 1247 N to  help  V N f  Reference
#> 16 unknown [Lk Mail_4].txt 1272 1276 N to  help  V the  Reference
#> 17   known [Lk Mail_1].txt 1512 1516 ease  help  him w  Reference
#> 18   known [Lk Mail_2].txt  387  391 ight  help  . ple  Reference
#> 19   known [Lk Mail_3].txt  994  998 ease  help  him a  Reference
#> 20 unknown [Lb Mail_3].txt 2279 2283 N to  help  our N  Reference
#> 21 unknown [Lb Mail_3].txt 2405 2409  and  help  the N  Reference
#> 22 unknown [Lb Mail_3].txt 2479 2483 g to  help  out w  Reference
#> 23 unknown [Lb Mail_3].txt 2617 2621  and  help  them   Reference
#> 24   known [Lb Mail_1].txt 1363 1367 d to  help  you i  Reference
#> 25   known [Lb Mail_2].txt 1652 1656  and  help  in V   Reference
#> 26   known [Lb Mail_2].txt 1676 1680  and  helpi ng ea  Reference
#> 27   known [Lb Mail_4].txt 1038 1042 e to  help  P N a  Reference
#> 28   known [Lb Mail_5].txt 1066 1070 this  helps  V ou  Reference
#> 29   known [La Mail_2].txt 2086 2090 ould  help  V the  Reference
#> 30   known [La Mail_2].txt 2494 2498 ould  help  get t  Reference
#> 31   known [La Mail_4].txt 1908 1912 also  help  V N .  Reference
#> 32   known [La Mail_5].txt 2424 2428 will  help  the N  Reference
#> 33   known [Mf Mail_2].txt  805  809 your  help  . thi  Reference
#> 34   known [Mf Mail_2].txt 2097 2101  any  help  you c  Reference
#> 35   known [Mf Mail_2].txt 2458 2462  can  help  with   Reference
#> 36   known [Ml Mail_1].txt  596  600  you  help  and V  Reference
#> 37   known [Ml Mail_1].txt 1223 1227 your  help  and l  Reference
#> 38   known [Ml Mail_1].txt 2492 2496  and  help  save   Reference
#> 39   known [Ml Mail_1].txt 2598 2602 your  help  and V  Reference
#> 40   known [Ml Mail_2].txt   12   16 your  help  and V  Reference
#> 41   known [Ml Mail_4].txt  622  626 your  help  in V   Reference
#> 42   known [Ml Mail_4].txt 1296 1300 ou N  helpe d us   Reference
#> 43   known [Ml Mail_4].txt 1589 1593 your  help  so th  Reference
#> 44   known [Ml Mail_4].txt 1962 1966 your  help  and V  Reference
#> 45   known [Ml Mail_5].txt  475  479 an B  help  you V  Reference

#using sentences
enron.sents <- tokens(enron.sample, "sentence")
concordance(enron.sents[1], enron.sents[2], enron.sents[3:49], ". _EOS_", token.type = "word")
#>                     docname from   to                              pre    node
#> 1     known [Kh Mail_1].txt  114  115                      N , but V D . _EOS_
#> 2     known [Kh Mail_1].txt  160  161                   D N in first N . _EOS_
#> 3     known [Kh Mail_1].txt  189  190                    N about a N N . _EOS_
#> 4     known [Kh Mail_1].txt  369  370                    and we V to V . _EOS_
#> 5     known [Kh Mail_1].txt  409  410                  ' re V with her . _EOS_
#> 6     known [Kh Mail_1].txt  545  546                   the N of the N . _EOS_
#> 7     known [Kh Mail_1].txt  698  699         V in you getting neither . _EOS_
#> 8     known [Kh Mail_1].txt  713  714              just the N it works . _EOS_
#> 9     known [Kh Mail_1].txt  735  736                       N is a J N . _EOS_
#> 10    known [Kh Mail_1].txt  873  874             have to say during N . _EOS_
#> 11    known [Kh Mail_3].txt  173  174                       J as a J N . _EOS_
#> 12    known [Kh Mail_3].txt  235  236              get V into the call . _EOS_
#> 13    known [Kh Mail_3].txt  285  286             , please let me know . _EOS_
#> 14    known [Kh Mail_3].txt  341  342                   you who V of N . _EOS_
#> 15    known [Kh Mail_3].txt  366  367                      B for a N N . _EOS_
#> 16    known [Kh Mail_3].txt  410  411            P went well last week . _EOS_
#> 17    known [Kh Mail_3].txt  560  561                    of N in its N . _EOS_
#> 18    known [Kh Mail_3].txt  599  600                    for the B J N . _EOS_
#> 19    known [Kh Mail_3].txt  625  626                      N N and N N . _EOS_
#> 20    known [Kh Mail_3].txt  715  716                        N J J J N . _EOS_
#> 21    known [Kh Mail_4].txt  222  223                   , and V your N . _EOS_
#> 22    known [Kh Mail_4].txt  302  303                   J N with the N . _EOS_
#> 23    known [Kh Mail_4].txt  666  667                    V for a few N . _EOS_
#> 24    known [Kh Mail_4].txt  716  717        especially on the first N . _EOS_
#> 25    known [Kh Mail_4].txt  754  755                    her to N on N . _EOS_
#> 26    known [Kh Mail_4].txt  774  775                after the N has V . _EOS_
#> 27    known [Kh Mail_4].txt  785  786                    to N on the N . _EOS_
#> 28    known [Kh Mail_5].txt   31   32                      can V a J N . _EOS_
#> 29    known [Kh Mail_5].txt  111  112                     to V B N too . _EOS_
#> 30    known [Kh Mail_5].txt  193  194                     the N on P N . _EOS_
#> 31    known [Kh Mail_5].txt  214  215                    J for the P N . _EOS_
#> 32    known [Kh Mail_5].txt  248  249                       P N N by N . _EOS_
#> 33    known [Kh Mail_5].txt  319  320                      was P D , D . _EOS_
#> 34    known [Kh Mail_5].txt  392  393                    in V on the N . _EOS_
#> 35    known [Kh Mail_5].txt  546  547                see if they are J . _EOS_
#> 36    known [Kh Mail_5].txt  563  564                a N a N afterward . _EOS_
#> 37    known [Kh Mail_5].txt  666  667                  N N B next week . _EOS_
#> 38    known [Kh Mail_5].txt  767  768                  N as this one N . _EOS_
#> 39    known [Kh Mail_5].txt  813  814                        P P P P N . _EOS_
#> 40    known [Kh Mail_5].txt  837  838                     s very J N N . _EOS_
#> 41    known [Kh Mail_5].txt  850  851                      N who B V N . _EOS_
#> 42  unknown [Kh Mail_2].txt   37   38               call me with any N . _EOS_
#> 43  unknown [Kh Mail_2].txt   54   55                 N you feel are J . _EOS_
#> 44  unknown [Kh Mail_2].txt  128  129                        P N N N N . _EOS_
#> 45  unknown [Kh Mail_2].txt  758  759                       V at J N N . _EOS_
#> 46  unknown [Kh Mail_2].txt  817  818                      , J N , etc . _EOS_
#> 47  unknown [Kh Mail_2].txt  833  834                        V J N N N . _EOS_
#> 48  unknown [Kw Mail_3].txt  171  172                   the N of the N . _EOS_
#> 49  unknown [Kw Mail_3].txt  288  289                   after D N of N . _EOS_
#> 50  unknown [Kw Mail_3].txt  400  401                   get V in the N . _EOS_
#> 51  unknown [Kw Mail_3].txt  445  446                   to V it to you . _EOS_
#> 52  unknown [Kw Mail_3].txt  477  478               V with each of you . _EOS_
#> 53  unknown [Kw Mail_3].txt  528  529                       to V a J N . _EOS_
#> 54  unknown [Kw Mail_3].txt  550  551                 a start to the P . _EOS_
#> 55  unknown [Kw Mail_3].txt  639  640                    an N from P P . _EOS_
#> 56  unknown [Kw Mail_3].txt  997  998                 few more N for P . _EOS_
#> 57  unknown [Kw Mail_3].txt 1072 1073                       N N on P D . _EOS_
#> 58    known [Kw Mail_1].txt   47   48                  V for at this N . _EOS_
#> 59    known [Kw Mail_1].txt   83   84                  of the N for us . _EOS_
#> 60    known [Kw Mail_1].txt  208  209              be getting all my N . _EOS_
#> 61    known [Kw Mail_1].txt  257  258                    V and V to me . _EOS_
#> 62    known [Kw Mail_1].txt  357  358              came in several N B . _EOS_
#> 63    known [Kw Mail_1].txt  551  552              J N starting next P . _EOS_
#> 64    known [Kw Mail_1].txt  632  633                 they were V in P . _EOS_
#> 65    known [Kw Mail_1].txt  707  708                could get B and V . _EOS_
#> 66    known [Kw Mail_1].txt  780  781                       on P , P D . _EOS_
#> 67    known [Kw Mail_1].txt  834  835                    my N last P N . _EOS_
#> 68    known [Kw Mail_1].txt  853  854                V that it was you . _EOS_
#> 69    known [Kw Mail_1].txt  993  994              are seeing on the N . _EOS_
#> 70    known [Kw Mail_2].txt   46   47                    we have N V N . _EOS_
#> 71    known [Kw Mail_2].txt   90   91                 we can V as well . _EOS_
#> 72    known [Kw Mail_2].txt  146  147                   you V on our N . _EOS_
#> 73    known [Kw Mail_2].txt  201  202                  who V all the N . _EOS_
#> 74    known [Kw Mail_2].txt  245  246               start the next N N . _EOS_
#> 75    known [Kw Mail_2].txt  372  373                       on P , P D . _EOS_
#> 76    known [Kw Mail_2].txt  418  419                if you have any N . _EOS_
#> 77    known [Kw Mail_2].txt  669  670           again if everyone is N . _EOS_
#> 78    known [Kw Mail_2].txt  715  716                     ' ll V the N . _EOS_
#> 79    known [Kw Mail_2].txt  765  766             want this N V around . _EOS_
#> 80    known [Kw Mail_2].txt  909  910                     N the N is V . _EOS_
#> 81    known [Kw Mail_4].txt   10   11                     the J N on D . _EOS_
#> 82    known [Kw Mail_4].txt   34   35                 this N in your N . _EOS_
#> 83    known [Kw Mail_4].txt   55   56                      a D N N yet . _EOS_
#> 84    known [Kw Mail_4].txt   78   79                if you have any N . _EOS_
#> 85    known [Kw Mail_4].txt  150  151                     the N by N N . _EOS_
#> 86    known [Kw Mail_4].txt  292  293               with N to the move . _EOS_
#> 87    known [Kw Mail_4].txt  364  365                   N when the N V . _EOS_
#> 88    known [Kw Mail_4].txt  464  465                      - N N , etc . _EOS_
#> 89    known [Kw Mail_4].txt  480  481                     N to V for N . _EOS_
#> 90    known [Kw Mail_4].txt  523  524                       to P P N N . _EOS_
#> 91    known [Kw Mail_4].txt  580  581               to V from you soon . _EOS_
#> 92    known [Kw Mail_4].txt  599  600                    P N in last N . _EOS_
#> 93    known [Kw Mail_4].txt  612  613                  the N of this N . _EOS_
#> 94    known [Kw Mail_4].txt  645  646                 with P as they V . _EOS_
#> 95    known [Kw Mail_4].txt  689  690           this if you would like . _EOS_
#> 96    known [Kw Mail_4].txt  808  809                  before i V to P . _EOS_
#> 97    known [Kw Mail_4].txt  849  850             well as the N itself . _EOS_
#> 98    known [Kw Mail_5].txt   62   63             i called them this N . _EOS_
#> 99    known [Kw Mail_5].txt  209  210                  P P P next week . _EOS_
#> 100   known [Kw Mail_5].txt  245  246                    i can be of N . _EOS_
#> 101   known [Kw Mail_5].txt  268  269                 the N for next P . _EOS_
#> 102   known [Kw Mail_5].txt  356  357                  and V up this N . _EOS_
#> 103   known [Kw Mail_5].txt  797  798                 n't V to call me . _EOS_
#> 104 unknown [Lc Mail_1].txt   51   52                    V was B one N . _EOS_
#> 105 unknown [Lc Mail_1].txt   93   94               through of the J N . _EOS_
#> 106 unknown [Lc Mail_1].txt  109  110                     J N of the N . _EOS_
#> 107 unknown [Lc Mail_1].txt  212  213                    J N of both N . _EOS_
#> 108 unknown [Lc Mail_1].txt  488  489                       V to P P N . _EOS_
#> 109 unknown [Lc Mail_1].txt  537  538                     and V by J N . _EOS_
#> 110 unknown [Lc Mail_1].txt  695  696                   like J N to me . _EOS_
#> 111 unknown [Lc Mail_1].txt  838  839                     N of the N N . _EOS_
#> 112   known [Lc Mail_2].txt  111  112                     will V N V N . _EOS_
#> 113   known [Lc Mail_2].txt  153  154                showing the N N N . _EOS_
#> 114   known [Lc Mail_2].txt  191  192                   the J N near P . _EOS_
#> 115   known [Lc Mail_2].txt  249  250                       on P D , D . _EOS_
#> 116   known [Lc Mail_2].txt  276  277                      J N N V etc . _EOS_
#> 117   known [Lc Mail_2].txt  392  393                   was V to the N . _EOS_
#> 118   known [Lc Mail_2].txt  486  487                    V on to the N . _EOS_
#> 119   known [Lc Mail_2].txt  511  512                    N of N were V . _EOS_
#> 120   known [Lc Mail_2].txt  528  529                        P J N N N . _EOS_
#> 121   known [Lc Mail_2].txt  542  543                        P J N N N . _EOS_
#> 122   known [Lc Mail_2].txt  562  563                        P J N N N . _EOS_
#> 123   known [Lc Mail_2].txt  778  779                      V V V the N . _EOS_
#> 124   known [Lc Mail_3].txt   13   14                     V on the P N . _EOS_
#> 125   known [Lc Mail_3].txt   98   99                   the N by the N . _EOS_
#> 126   known [Lc Mail_3].txt  326  327                   N would be B V . _EOS_
#> 127   known [Lc Mail_3].txt  411  412                     N N V as yet . _EOS_
#> 128   known [Lc Mail_3].txt  427  428                     N of the P N . _EOS_
#> 129   known [Lc Mail_3].txt  443  444                     of N J for N . _EOS_
#> 130   known [Lc Mail_3].txt  472  473                   to give P my N . _EOS_
#> 131   known [Lc Mail_3].txt  481  482              are B J around here . _EOS_
#> 132   known [Lc Mail_3].txt  874  875                 is part of the N . _EOS_
#> 133   known [Lc Mail_4].txt   52   53                   may V us to do . _EOS_
#> 134   known [Lc Mail_4].txt   93   94                      D and D N N . _EOS_
#> 135   known [Lc Mail_4].txt  121  122                     V with a J N . _EOS_
#> 136   known [Lc Mail_4].txt  282  283                the N of the week . _EOS_
#> 137   known [Lc Mail_4].txt  356  357                  have any N or N . _EOS_
#> 138   known [Lc Mail_4].txt  650  651                    N and V any N . _EOS_
#> 139   known [Lc Mail_4].txt  819  820             the N that are there . _EOS_
#> 140   known [Lc Mail_5].txt   29   30       once the N actually begins . _EOS_
#> 141   known [Lc Mail_5].txt   51   52              B and all went well . _EOS_
#> 142   known [Lc Mail_5].txt   85   86                 for that N and N . _EOS_
#> 143   known [Lc Mail_5].txt  131  132                  N but no more N . _EOS_
#> 144   known [Lc Mail_5].txt  213  214               their N and N also . _EOS_
#> 145   known [Lc Mail_5].txt  247  248                     N of the P P . _EOS_
#> 146   known [Lc Mail_5].txt  465  466                     V on how N V . _EOS_
#> 147   known [Lc Mail_5].txt  664  665                 J to take it out . _EOS_
#> 148   known [Lc Mail_5].txt  792  793                        P P N P P . _EOS_
#> 149   known [Lc Mail_5].txt  814  815                    P for his N N . _EOS_
#> 150 unknown [Ld Mail_4].txt  126  127                if you have any N . _EOS_
#> 151 unknown [Ld Mail_4].txt  152  153                  first N for V N . _EOS_
#> 152 unknown [Ld Mail_4].txt  209  210                N to her during N . _EOS_
#> 153 unknown [Ld Mail_4].txt  246  247                if you have any N . _EOS_
#> 154 unknown [Ld Mail_4].txt  297  298                   J N for your N . _EOS_
#> 155 unknown [Ld Mail_4].txt  329  330                        P P N N N . _EOS_
#> 156 unknown [Ld Mail_4].txt  389  390               through D with a D . _EOS_
#> 157 unknown [Ld Mail_4].txt  651  652                   m J to these N . _EOS_
#> 158 unknown [Ld Mail_4].txt  707  708          soon for N or something . _EOS_
#> 159 unknown [Ld Mail_4].txt  751  752                  to get it all B . _EOS_
#> 160   known [Ld Mail_1].txt   75   76                    of V up our N . _EOS_
#> 161   known [Ld Mail_1].txt   88   89          running this all past P . _EOS_
#> 162   known [Ld Mail_1].txt  135  136          need anything B from me . _EOS_
#> 163   known [Ld Mail_1].txt  170  171                there are any N N . _EOS_
#> 164   known [Ld Mail_1].txt  423  424             N we should get into . _EOS_
#> 165   known [Ld Mail_1].txt  587  588                  to look for a N . _EOS_
#> 166   known [Ld Mail_1].txt  706  707               i could get a look . _EOS_
#> 167   known [Ld Mail_1].txt  769  770                     ' m on D now . _EOS_
#> 168   known [Ld Mail_1].txt  796  797                  a N with this N . _EOS_
#> 169   known [Ld Mail_1].txt  809  810              with P about this N . _EOS_
#> 170   known [Ld Mail_2].txt  147  148             with the overall D N . _EOS_
#> 171   known [Ld Mail_2].txt  207  208           next week to V further . _EOS_
#> 172   known [Ld Mail_2].txt  236  237           you need any further N . _EOS_
#> 173   known [Ld Mail_2].txt  310  311              anything in the N N . _EOS_
#> 174   known [Ld Mail_2].txt  445  446                  in her N this N . _EOS_
#> 175   known [Ld Mail_2].txt  578  579                        s N ' s N . _EOS_
#> 176   known [Ld Mail_2].txt  716  717                      and P ' s N . _EOS_
#> 177   known [Ld Mail_3].txt  231  232                  in these N is J . _EOS_
#> 178   known [Ld Mail_3].txt  267  268                       N B d be V . _EOS_
#> 179   known [Ld Mail_3].txt  289  290                on P on another N . _EOS_
#> 180   known [Ld Mail_3].txt  359  360                  to put in the N . _EOS_
#> 181   known [Ld Mail_3].txt  424  425                V the N through D . _EOS_
#> 182   known [Ld Mail_3].txt  471  472                   to V P as well . _EOS_
#> 183   known [Ld Mail_5].txt   87   88                      , D in P no . _EOS_
#> 184   known [Ld Mail_5].txt  423  424                        , P P P N . _EOS_
#> 185 unknown [Lt Mail_2].txt   68   69                     to P for P P . _EOS_
#> 186 unknown [Lt Mail_2].txt  206  207                       J N to P N . _EOS_
#> 187 unknown [Lt Mail_2].txt  275  276                     have V D D N . _EOS_
#> 188 unknown [Lt Mail_2].txt  354  355            following the N and N . _EOS_
#> 189 unknown [Lt Mail_2].txt  365  366                      V the P D N . _EOS_
#> 190 unknown [Lt Mail_2].txt  450  451                   and N of the N . _EOS_
#> 191 unknown [Lt Mail_2].txt  500  501              N wanting to come N . _EOS_
#> 192 unknown [Lt Mail_2].txt  560  561                 and N from the N . _EOS_
#> 193 unknown [Lt Mail_2].txt  577  578                 of your N more B . _EOS_
#> 194 unknown [Lt Mail_2].txt  767  768                N in your N below . _EOS_
#> 195   known [Lt Mail_1].txt   15   16                   V me on this N . _EOS_
#> 196   known [Lt Mail_1].txt   47   48                    V this N to P . _EOS_
#> 197   known [Lt Mail_1].txt   63   64                   for P V this N . _EOS_
#> 198   known [Lt Mail_1].txt  109  110                  is V for your N . _EOS_
#> 199   known [Lt Mail_1].txt  155  156                  N V J between D . _EOS_
#> 200   known [Lt Mail_1].txt  175  176                      P , P and P . _EOS_
#> 201   known [Lt Mail_1].txt  220  221                   V or V these N . _EOS_
#> 202   known [Lt Mail_1].txt  260  261                        , P , P D . _EOS_
#> 203   known [Lt Mail_1].txt  425  426               talking to you V N . _EOS_
#> 204   known [Lt Mail_1].txt  488  489         N more frequently than P . _EOS_
#> 205   known [Lt Mail_1].txt  523  524                      P for a J N . _EOS_
#> 206   known [Lt Mail_1].txt  557  558                me in P this week . _EOS_
#> 207   known [Lt Mail_1].txt  577  578                      P P etc . , . _EOS_
#> 208   known [Lt Mail_1].txt  596  597                      J in N in P . _EOS_
#> 209   known [Lt Mail_1].txt  630  631                        N N S N N . _EOS_
#> 210   known [Lt Mail_3].txt   11   12                     P are J to V . _EOS_
#> 211   known [Lt Mail_3].txt  106  107                     V by all N N . _EOS_
#> 212   known [Lt Mail_3].txt  140  141                  up some N for P . _EOS_
#> 213   known [Lt Mail_3].txt  189  190            between now and the N . _EOS_
#> 214   known [Lt Mail_3].txt  257  258                , N N or whatever . _EOS_
#> 215   known [Lt Mail_3].txt  285  286                  P from this N N . _EOS_
#> 216   known [Lt Mail_3].txt  422  423                   is only at D N . _EOS_
#> 217   known [Lt Mail_3].txt  514  515                      N and J N N . _EOS_
#> 218   known [Lt Mail_3].txt  615  616                , please call P D . _EOS_
#> 219   known [Lt Mail_3].txt  651  652                 if you have an N . _EOS_
#> 220   known [Lt Mail_4].txt   68   69               V with both of you . _EOS_
#> 221   known [Lt Mail_4].txt   94   95                       on P , P D . _EOS_
#> 222   known [Lt Mail_4].txt  125  126                N that would be J . _EOS_
#> 223   known [Lt Mail_4].txt  142  143                      the D P ' N . _EOS_
#> 224   known [Lt Mail_4].txt  161  162                      N N and N N . _EOS_
#> 225   known [Lt Mail_4].txt  205  206                        N - N N N . _EOS_
#> 226   known [Lt Mail_4].txt  279  280           as we had previously V . _EOS_
#> 227   known [Lt Mail_4].txt  577  578                     for J N at P . _EOS_
#> 228   known [Lt Mail_4].txt  592  593                     N in the J N . _EOS_
#> 229   known [Lt Mail_4].txt  606  607                     in the J N D . _EOS_
#> 230   known [Lt Mail_4].txt  709  710                     can V on a N . _EOS_
#> 231   known [Lt Mail_4].txt  720  721                  for your N to V . _EOS_
#> 232   known [Lt Mail_4].txt  730  731            not V his N regularly . _EOS_
#> 233 unknown [Lk Mail_4].txt   51   52                      J N D N out . _EOS_
#> 234 unknown [Lk Mail_4].txt  120  121             get some of this off . _EOS_
#> 235 unknown [Lk Mail_4].txt  205  206                 needs of our J N . _EOS_
#> 236 unknown [Lk Mail_4].txt  274  275                      P and P P B . _EOS_
#> 237 unknown [Lk Mail_4].txt  352  353                   B with the J N . _EOS_
#> 238 unknown [Lk Mail_4].txt  488  489                 needs of our J N . _EOS_
#> 239 unknown [Lk Mail_4].txt  557  558                      P and P P B . _EOS_
#> 240 unknown [Lk Mail_4].txt  635  636                   B with the J N . _EOS_
#> 241 unknown [Lk Mail_4].txt  672  673                     N in the P P . _EOS_
#> 242 unknown [Lk Mail_4].txt  759  760          V doing the following D . _EOS_
#> 243 unknown [Lk Mail_4].txt  887  888                   go all the N B . _EOS_
#> 244 unknown [Lk Mail_4].txt  949  950                   N to look B to . _EOS_
#> 245   known [Lk Mail_1].txt   21   22              the V N including P . _EOS_
#> 246   known [Lk Mail_1].txt   71   72                if so let me know . _EOS_
#> 247   known [Lk Mail_1].txt  219  220       immediately but within a N . _EOS_
#> 248   known [Lk Mail_1].txt  262  263          N or anything like that . _EOS_
#> 249   known [Lk Mail_1].txt  277  278             need to V up quickly . _EOS_
#> 250   known [Lk Mail_1].txt  445  446                   N V around P D . _EOS_
#> 251   known [Lk Mail_1].txt  464  465                this week P and P . _EOS_
#> 252   known [Lk Mail_1].txt  534  535                    N for the N N . _EOS_
#> 253   known [Lk Mail_1].txt  646  647              you V this work out . _EOS_
#> 254   known [Lk Mail_1].txt  667  668               P N with another N . _EOS_
#> 255   known [Lk Mail_1].txt  698  699                 all those N to P . _EOS_
#> 256   known [Lk Mail_1].txt  709  710                    V N and N etc . _EOS_
#> 257   known [Lk Mail_1].txt  857  858                  off on V that N . _EOS_
#> 258   known [Lk Mail_2].txt   38   39                     have a B J N . _EOS_
#> 259   known [Lk Mail_2].txt  132  133                    will V B or B . _EOS_
#> 260   known [Lk Mail_2].txt  316  317                     not V my N N . _EOS_
#> 261   known [Lk Mail_2].txt  374  375                     to the N N N . _EOS_
#> 262   known [Lk Mail_2].txt  425  426              V anything with J N . _EOS_
#> 263   known [Lk Mail_2].txt  639  640                   them - J and J . _EOS_
#> 264   known [Lk Mail_2].txt  711  712              are J just before N . _EOS_
#> 265   known [Lk Mail_2].txt  745  746                  N will not be V . _EOS_
#> 266   known [Lk Mail_2].txt  781  782                      N is J to N . _EOS_
#> 267   known [Lk Mail_2].txt  804  805                      D N P and P . _EOS_
#> 268   known [Lk Mail_2].txt  849  850               are V inside the P . _EOS_
#> 269   known [Lk Mail_3].txt   46   47                       V to V N N . _EOS_
#> 270   known [Lk Mail_3].txt  165  166               N are also V below . _EOS_
#> 271   known [Lk Mail_3].txt  181  182               for those V from P . _EOS_
#> 272   known [Lk Mail_3].txt  201  202                  V to and from P . _EOS_
#> 273   known [Lk Mail_3].txt  467  468                    N for the J N . _EOS_
#> 274   known [Lk Mail_3].txt  493  494         N but nobody had started . _EOS_
#> 275   known [Lk Mail_3].txt  603  604            of that N as possible . _EOS_
#> 276   known [Lk Mail_3].txt  659  660                 we can V on this . _EOS_
#> 277   known [Lk Mail_3].txt  694  695              start V in one hour . _EOS_
#> 278   known [Lk Mail_5].txt  275  276                       to P D , D . _EOS_
#> 279   known [Lk Mail_5].txt  384  385                   need to V on P . _EOS_
#> 280   known [Lk Mail_5].txt  418  419                    are P P and P . _EOS_
#> 281   known [Lk Mail_5].txt  569  570                 N and other N do . _EOS_
#> 282   known [Lk Mail_5].txt  599  600             therefore V with N N . _EOS_
#> 283   known [Lk Mail_5].txt  631  632                     N is the J N . _EOS_
#> 284   known [Lk Mail_5].txt  672  673                 N is made with N . _EOS_
#> 285   known [Lk Mail_5].txt  759  760                     on our D S D . _EOS_
#> 286 unknown [Lb Mail_3].txt  161  162             , please let me know . _EOS_
#> 287 unknown [Lb Mail_3].txt  217  218                      J N for N N . _EOS_
#> 288 unknown [Lb Mail_3].txt  280  281                 , please let P P . _EOS_
#> 289 unknown [Lb Mail_3].txt  441  442             , please let me know . _EOS_
#> 290 unknown [Lb Mail_3].txt  484  485                if you have any N . _EOS_
#> 291 unknown [Lb Mail_3].txt  508  509           N with the following N . _EOS_
#> 292 unknown [Lb Mail_3].txt  667  668                  N to take any N . _EOS_
#> 293 unknown [Lb Mail_3].txt  679  680                    N for us to V . _EOS_
#> 294 unknown [Lb Mail_3].txt  827  828            them through this J N . _EOS_
#> 295 unknown [Lb Mail_3].txt  893  894                       N of P , D . _EOS_
#> 296   known [Lb Mail_1].txt   78   79             , please let me know . _EOS_
#> 297   known [Lb Mail_1].txt  282  283                    N this N to V . _EOS_
#> 298   known [Lb Mail_1].txt  430  431                   ask P for an N . _EOS_
#> 299   known [Lb Mail_1].txt  523  524                    B D for the N . _EOS_
#> 300   known [Lb Mail_1].txt  559  560                want to V these N . _EOS_
#> 301   known [Lb Mail_1].txt  725  726             , please let me know . _EOS_
#> 302   known [Lb Mail_1].txt  811  812             , please let me know . _EOS_
#> 303   known [Lb Mail_2].txt   70   71                  the week of P N . _EOS_
#> 304   known [Lb Mail_2].txt   88   89            will be out that week . _EOS_
#> 305   known [Lb Mail_2].txt  118  119               did put her N down . _EOS_
#> 306   known [Lb Mail_2].txt  150  151                    for the N N N . _EOS_
#> 307   known [Lb Mail_2].txt  177  178                if you have any N . _EOS_
#> 308   known [Lb Mail_2].txt  204  205                if you have any N . _EOS_
#> 309   known [Lb Mail_2].txt  233  234                if you have any N . _EOS_
#> 310   known [Lb Mail_2].txt  262  263                if you have any N . _EOS_
#> 311   known [Lb Mail_2].txt  290  291                if you have any N . _EOS_
#> 312   known [Lb Mail_2].txt  358  359                    V out the J N . _EOS_
#> 313   known [Lb Mail_2].txt  386  387                her up coming N N . _EOS_
#> 314   known [Lb Mail_2].txt  406  407           in N anything comes up . _EOS_
#> 315   known [Lb Mail_2].txt  456  457                 how many are J D . _EOS_
#> 316   known [Lb Mail_2].txt  465  466                       N of P N N . _EOS_
#> 317   known [Lb Mail_2].txt  589  590                  let P or i know . _EOS_
#> 318   known [Lb Mail_2].txt  615  616                     B to V the N . _EOS_
#> 319   known [Lb Mail_2].txt  744  745                 each other ' s N . _EOS_
#> 320   known [Lb Mail_2].txt  769  770                     P has P as P . _EOS_
#> 321   known [Lb Mail_2].txt  808  809                    need J B up P . _EOS_
#> 322   known [Lb Mail_4].txt   51   52             , please let me know . _EOS_
#> 323   known [Lb Mail_4].txt   91   92             V this N if possible . _EOS_
#> 324   known [Lb Mail_4].txt  128  129                     N in the P P . _EOS_
#> 325   known [Lb Mail_4].txt  157  158                    n't V to V me . _EOS_
#> 326   known [Lb Mail_4].txt  176  177                     on the V N D . _EOS_
#> 327   known [Lb Mail_4].txt  210  211                      the J J N D . _EOS_
#> 328   known [Lb Mail_4].txt  228  229                     N and N on P . _EOS_
#> 329   known [Lb Mail_4].txt  241  242                      P P and N D . _EOS_
#> 330   known [Lb Mail_4].txt  255  256               working with P P D . _EOS_
#> 331   known [Lb Mail_4].txt  281  282                        , P , P D . _EOS_
#> 332   known [Lb Mail_4].txt  305  306                       P P or P P . _EOS_
#> 333   known [Lb Mail_4].txt  356  357               on the N went well . _EOS_
#> 334   known [Lb Mail_4].txt  389  390 which were turned around quickly . _EOS_
#> 335   known [Lb Mail_4].txt  469  470                    then V to P P . _EOS_
#> 336   known [Lb Mail_4].txt  662  663                     N on the N N . _EOS_
#> 337   known [Lb Mail_4].txt  683  684                    not be J to V . _EOS_
#> 338   known [Lb Mail_4].txt  714  715             and get our N across . _EOS_
#> 339   known [Lb Mail_5].txt  129  130                  let P or i know . _EOS_
#> 340   known [Lb Mail_5].txt  155  156                    go to N and V . _EOS_
#> 341   known [Lb Mail_5].txt  273  274                       N at P V D . _EOS_
#> 342   known [Lb Mail_5].txt  348  349                if you have any N . _EOS_
#> 343   known [Lb Mail_5].txt  417  418                 N N during all N . _EOS_
#> 344   known [Lb Mail_5].txt  465  466                        P ' s N D . _EOS_
#> 345   known [Lb Mail_5].txt  540  541                   N with P and P . _EOS_
#> 346   known [Lb Mail_5].txt  560  561                    after P D , D . _EOS_
#> 347   known [Lb Mail_5].txt  596  597                       on P , P N . _EOS_
#> 348   known [Lb Mail_5].txt  620  621                      N N for N N . _EOS_
#> 349   known [Lb Mail_5].txt  683  684             to seeing you next P . _EOS_
#> 350   known [Lb Mail_5].txt  778  779                  go B the next N . _EOS_
#> 351 unknown [La Mail_3].txt   14   15                   up on N in may . _EOS_
#> 352 unknown [La Mail_3].txt  163  164               even some N were J . _EOS_
#> 353 unknown [La Mail_3].txt  273  274                   per N - hour N . _EOS_
#> 354 unknown [La Mail_3].txt  350  351              be needed to V that . _EOS_
#> 355 unknown [La Mail_3].txt  447  448          that does anybody any N . _EOS_
#> 356 unknown [La Mail_3].txt  460  461              V similarly J and J . _EOS_
#> 357 unknown [La Mail_3].txt  515  516                     N in the J N . _EOS_
#> 358 unknown [La Mail_3].txt  634  635                   make the N N V . _EOS_
#> 359 unknown [La Mail_3].txt  693  694                     V of V the N . _EOS_
#> 360 unknown [La Mail_3].txt  836  837                  V one that is J . _EOS_
#> 361 unknown [La Mail_3].txt  897  898                     to V the J N . _EOS_
#> 362 unknown [La Mail_3].txt  939  940                   N will V the N . _EOS_
#> 363   known [La Mail_1].txt  356  357                       J N to V N . _EOS_
#> 364   known [La Mail_1].txt  412  413                        J N - J N . _EOS_
#> 365   known [La Mail_1].txt  546  547                   for N , P said . _EOS_
#> 366   known [La Mail_1].txt  695  696                       by P ' s N . _EOS_
#> 367   known [La Mail_1].txt  716  717                      get a J N N . _EOS_
#> 368   known [La Mail_2].txt  173  174                    , when N is J . _EOS_
#> 369   known [La Mail_2].txt  222  223                      J P , are V . _EOS_
#> 370   known [La Mail_2].txt  291  292                  N might V the N . _EOS_
#> 371   known [La Mail_2].txt  333  334                     N J of her N . _EOS_
#> 372   known [La Mail_2].txt  380  381                       N N of N N . _EOS_
#> 373   known [La Mail_2].txt  578  579                       in P , ' N . _EOS_
#> 374   known [La Mail_2].txt  636  637                      P P P and P . _EOS_
#> 375   known [La Mail_2].txt  667  668           are J n further behind . _EOS_
#> 376   known [La Mail_2].txt  770  771                     on the J N N . _EOS_
#> 377   known [La Mail_2].txt  860  861                     ' N N next N . _EOS_
#> 378   known [La Mail_4].txt   20   21                   the N of the N . _EOS_
#> 379   known [La Mail_4].txt  117  118                   be V , he said . _EOS_
#> 380   known [La Mail_4].txt  198  199                    , the J N say . _EOS_
#> 381   known [La Mail_4].txt  230  231                       , J N of N . _EOS_
#> 382   known [La Mail_4].txt  260  261                        P P ' s N . _EOS_
#> 383   known [La Mail_4].txt  293  294                      V up as a N . _EOS_
#> 384   known [La Mail_4].txt  334  335            those who V will save . _EOS_
#> 385   known [La Mail_4].txt  406  407                     as J and J N . _EOS_
#> 386   known [La Mail_4].txt  496  497                  a N with four N . _EOS_
#> 387   known [La Mail_4].txt  516  517                  for the N and N . _EOS_
#> 388   known [La Mail_4].txt  648  649               will also help V N . _EOS_
#> 389   known [La Mail_4].txt  659  660                     J N with J N . _EOS_
#> 390   known [La Mail_4].txt  679  680                  N N down or off . _EOS_
#> 391   known [La Mail_4].txt  732  733                      , N and V N . _EOS_
#> 392   known [La Mail_5].txt   54   55                    N N and the N . _EOS_
#> 393   known [La Mail_5].txt  154  155                     V the N on P . _EOS_
#> 394   known [La Mail_5].txt  195  196                 V little or no N . _EOS_
#> 395   known [La Mail_5].txt  241  242                   all , P P said . _EOS_
#> 396   known [La Mail_5].txt  256  257                   D N , she said . _EOS_
#> 397   known [La Mail_5].txt  363  364                  P and other P P . _EOS_
#> 398   known [La Mail_5].txt  510  511                 while J N were V . _EOS_
#> 399   known [La Mail_5].txt  590  591                   many N as it V . _EOS_
#> 400   known [La Mail_5].txt  625  626                  hour N to the N . _EOS_
#> 401   known [La Mail_5].txt  712  713                N outside the N N . _EOS_
#> 402   known [La Mail_5].txt  765  766                 d look into V it . _EOS_
#> 403   known [La Mail_5].txt  800  801                 N will V about D . _EOS_
#> 404   known [La Mail_5].txt  885  886            did not V N afterward . _EOS_
#> 405   known [La Mail_5].txt  911  912                     N ' s move J . _EOS_
#> 406 unknown [Mf Mail_1].txt   64   65                    , J N to make . _EOS_
#> 407 unknown [Mf Mail_1].txt   90   91                   we did it in P . _EOS_
#> 408 unknown [Mf Mail_1].txt  622  623                 well on your N N . _EOS_
#> 409 unknown [Mf Mail_1].txt  710  711            in me from the inside . _EOS_
#> 410 unknown [Mf Mail_1].txt 1065 1066                     the P P N vs . _EOS_
#> 411   known [Mf Mail_2].txt   55   56                some N V this out . _EOS_
#> 412   known [Mf Mail_2].txt   69   70                the N are as well . _EOS_
#> 413   known [Mf Mail_2].txt  186  187            whether this V or not . _EOS_
#> 414   known [Mf Mail_2].txt  587  588                     P at D for N . _EOS_
#> 415   known [Mf Mail_2].txt  691  692                    if the N is J . _EOS_
#> 416   known [Mf Mail_2].txt  716  717                   P to V on this . _EOS_
#> 417   known [Mf Mail_2].txt  873  874                    N N per our N . _EOS_
#> 418   known [Mf Mail_3].txt   30   31              because the N was J . _EOS_
#> 419   known [Mf Mail_3].txt  268  269                   in the P and P . _EOS_
#> 420   known [Mf Mail_3].txt  396  397                 N within a few N . _EOS_
#> 421   known [Mf Mail_3].txt  470  471                       N of P P N . _EOS_
#> 422   known [Mf Mail_3].txt  534  535                   P P is under D . _EOS_
#> 423   known [Mf Mail_3].txt  617  618                       N N , as J . _EOS_
#> 424   known [Mf Mail_3].txt  660  661           we have something in J . _EOS_
#> 425   known [Mf Mail_3].txt  685  686                   , i would V it . _EOS_
#> 426   known [Mf Mail_3].txt  741  742                   very J to my N . _EOS_
#> 427   known [Mf Mail_3].txt  808  809              J N later this week . _EOS_
#> 428   known [Mf Mail_3].txt  833  834                   it is over a N . _EOS_
#> 429   known [Mf Mail_4].txt   62   63                      N for a J N . _EOS_
#> 430   known [Mf Mail_4].txt   83   84                  N for their J N . _EOS_
#> 431   known [Mf Mail_4].txt  222  223                 me , please V me . _EOS_
#> 432   known [Mf Mail_4].txt  266  267                   and B V some N . _EOS_
#> 433   known [Mf Mail_4].txt  310  311                      or B B to P . _EOS_
#> 434   known [Mf Mail_4].txt  606  607                      P and P P N . _EOS_
#> 435   known [Mf Mail_4].txt  799  800                   N for J than D . _EOS_
#> 436   known [Mf Mail_4].txt  941  942                      V us to V N . _EOS_
#> 437   known [Mf Mail_5].txt  431  432                      the N V P N . _EOS_
#> 438   known [Mf Mail_5].txt  512  513                   be J to this N . _EOS_
#> 439   known [Mf Mail_5].txt  669  670                more J for this N . _EOS_
#> 440   known [Mf Mail_5].txt  803  804                    the N is J of . _EOS_
#> 441   known [Mf Mail_5].txt  816  817                      the P P P N . _EOS_
#> 442   known [Mf Mail_5].txt  848  849                  can B V their N . _EOS_
#> 443 unknown [Ml Mail_3].txt   29   30                    soon as i V N . _EOS_
#> 444 unknown [Ml Mail_3].txt   48   49                     this N , J N . _EOS_
#> 445 unknown [Ml Mail_3].txt   64   65               not V it from work . _EOS_
#> 446 unknown [Ml Mail_3].txt  105  106                    soon as i V N . _EOS_
#> 447 unknown [Ml Mail_3].txt  124  125                     this N , J N . _EOS_
#> 448 unknown [Ml Mail_3].txt  140  141               not V it from work . _EOS_
#> 449 unknown [Ml Mail_3].txt  617  618                       P P by N N . _EOS_
#> 450 unknown [Ml Mail_3].txt  703  704                   are not B J in . _EOS_
#> 451 unknown [Ml Mail_3].txt  939  940                    you the N N P . _EOS_
#> 452   known [Ml Mail_1].txt  174  175                     P V like P P . _EOS_
#> 453   known [Ml Mail_1].txt  363  364                    J N we set up . _EOS_
#> 454   known [Ml Mail_1].txt  490  491                   and N in the N . _EOS_
#> 455   known [Ml Mail_1].txt  583  584                      in N in P P . _EOS_
#> 456   known [Ml Mail_1].txt  658  659                    be B V from N . _EOS_
#> 457   known [Ml Mail_1].txt  674  675                    N N for the P . _EOS_
#> 458   known [Ml Mail_1].txt  801  802              P P currently has N . _EOS_
#> 459   known [Ml Mail_1].txt  866  867                      V for a J N . _EOS_
#> 460   known [Ml Mail_2].txt   11   12                 and V with any N . _EOS_
#> 461   known [Ml Mail_2].txt   46   47                    N for the P P . _EOS_
#> 462   known [Ml Mail_2].txt  117  118                 V from V these N . _EOS_
#> 463   known [Ml Mail_2].txt  503  504                      N , the P P . _EOS_
#> 464   known [Ml Mail_2].txt  557  558                    soon as i V N . _EOS_
#> 465   known [Ml Mail_2].txt  576  577                     this N , J N . _EOS_
#> 466   known [Ml Mail_2].txt  592  593               not V it from work . _EOS_
#> 467   known [Ml Mail_2].txt  633  634                    soon as i V N . _EOS_
#> 468   known [Ml Mail_2].txt  652  653                     this N , J N . _EOS_
#> 469   known [Ml Mail_2].txt  680  681                that i can V them . _EOS_
#> 470   known [Ml Mail_2].txt  721  722                    soon as i V N . _EOS_
#> 471   known [Ml Mail_2].txt  740  741                     this N , J N . _EOS_
#> 472   known [Ml Mail_2].txt  756  757               not V it from work . _EOS_
#> 473   known [Ml Mail_4].txt  107  108                 from the N for J . _EOS_
#> 474   known [Ml Mail_4].txt  181  182          about it has not worked . _EOS_
#> 475   known [Ml Mail_4].txt  298  299                    or D on D off . _EOS_
#> 476   known [Ml Mail_4].txt  599  600                  N N for their N . _EOS_
#> 477   known [Ml Mail_4].txt  613  614                  if you need J N . _EOS_
#> 478   known [Ml Mail_4].txt  656  657                  J you V those N . _EOS_
#> 479   known [Ml Mail_5].txt   31   32                       P B to P P . _EOS_
#> 480   known [Ml Mail_5].txt  293  294                      in N N at P . _EOS_
#> 481   known [Ml Mail_5].txt  326  327                  in the N with D . _EOS_
#> 482   known [Ml Mail_5].txt  402  403               taking up your N N . _EOS_
#> 483   known [Ml Mail_5].txt  489  490                    soon as i V N . _EOS_
#> 484   known [Ml Mail_5].txt  703  704                   N you V from P . _EOS_
#> 485   known [Ml Mail_5].txt  817  818                     P - take a N . _EOS_
#>                          post authorship
#> 1           _BOS_ P V us they          Q
#> 2           _BOS_ N is in the          Q
#> 3              _BOS_ P , V is          Q
#> 4         _BOS_ J N is always          Q
#> 5               _BOS_ P , P ,          Q
#> 6            _BOS_ N is not a          Q
#> 7             _BOS_ J N , but          Q
#> 8        _BOS_ P is what your          Q
#> 9             _BOS_ J N are B          Q
#> 10                                     Q
#> 11    _BOS_ P had already run          K
#> 12         _BOS_ V the N from          K
#> 13         _BOS_ P i am still          K
#> 14              _BOS_ P P P N          K
#> 15          _BOS_ P per our N          K
#> 16            _BOS_ P V to me          K
#> 17           _BOS_ N of the N          K
#> 18             _BOS_ P P , in          K
#> 19              _BOS_ P P V a          K
#> 20                                     K
#> 21           _BOS_ N , over J  Reference
#> 22             _BOS_ B to D i  Reference
#> 23        _BOS_ N and N under  Reference
#> 24         _BOS_ V , with her  Reference
#> 25        _BOS_ V N should be  Reference
#> 26    _BOS_ V from talking to  Reference
#> 27                             Reference
#> 28         _BOS_ V your N for  Reference
#> 29             _BOS_ P , V on  Reference
#> 30              _BOS_ N P P P  Reference
#> 31              _BOS_ N , P i  Reference
#> 32              _BOS_ P , s P  Reference
#> 33             _BOS_ P P P is  Reference
#> 34       _BOS_ V below is the  Reference
#> 35     _BOS_ N should last no  Reference
#> 36           _BOS_ J N will V  Reference
#> 37       _BOS_ V you for your  Reference
#> 38         _BOS_ N for your V  Reference
#> 39           _BOS_ N from a P  Reference
#> 40             _BOS_ V by a D  Reference
#> 41                             Reference
#> 42         _BOS_ P , please V  Reference
#> 43              _BOS_ N , P P  Reference
#> 44              _BOS_ N P P P  Reference
#> 45           _BOS_ P , i need  Reference
#> 46            _BOS_ P is an N  Reference
#> 47                             Reference
#> 48          _BOS_ N will be V  Reference
#> 49           _BOS_ J , i just  Reference
#> 50            _BOS_ P P and P  Reference
#> 51         _BOS_ N has also V  Reference
#> 52          _BOS_ P , here is  Reference
#> 53      _BOS_ P is possible ,  Reference
#> 54          _BOS_ V you for V  Reference
#> 55            _BOS_ P , may i  Reference
#> 56          _BOS_ P , here is  Reference
#> 57                             Reference
#> 58            _BOS_ P has V N  Reference
#> 59              _BOS_ P , i V  Reference
#> 60         _BOS_ P , i wanted  Reference
#> 61           _BOS_ P , i just  Reference
#> 62             _BOS_ P P is V  Reference
#> 63         _BOS_ J , i wanted  Reference
#> 64     _BOS_ P said that they  Reference
#> 65          _BOS_ P , here is  Reference
#> 66         _BOS_ P has them V  Reference
#> 67        _BOS_ N says it was  Reference
#> 68           _BOS_ J to say ,  Reference
#> 69                             Reference
#> 70          _BOS_ P , here is  Reference
#> 71       _BOS_ V you for your  Reference
#> 72         _BOS_ P and P will  Reference
#> 73             _BOS_ P , as a  Reference
#> 74      _BOS_ J about all the  Reference
#> 75          _BOS_ P will be V  Reference
#> 76            _BOS_ P and P ,  Reference
#> 77   _BOS_ P please talk with  Reference
#> 78            _BOS_ P , you '  Reference
#> 79           _BOS_ P , your N  Reference
#> 80                             Reference
#> 81            _BOS_ V in N on  Reference
#> 82         _BOS_ J and P have  Reference
#> 83          _BOS_ P , here is  Reference
#> 84          _BOS_ P just V to  Reference
#> 85         _BOS_ D with the P  Reference
#> 86        _BOS_ P will also V  Reference
#> 87         _BOS_ P , have you  Reference
#> 88       _BOS_ N wants this N  Reference
#> 89            _BOS_ P , P and  Reference
#> 90            _BOS_ P P , per  Reference
#> 91             _BOS_ V , my N  Reference
#> 92            _BOS_ P P has V  Reference
#> 93         _BOS_ P has been J  Reference
#> 94      _BOS_ V , please find  Reference
#> 95              _BOS_ P P P P  Reference
#> 96      _BOS_ P , please take  Reference
#> 97                             Reference
#> 98           _BOS_ P is the N  Reference
#> 99              _BOS_ P , P P  Reference
#> 100          _BOS_ P , i have  Reference
#> 101           _BOS_ P , N for  Reference
#> 102         _BOS_ P , i would  Reference
#> 103                            Reference
#> 104            _BOS_ N N D of  Reference
#> 105          _BOS_ J N were V  Reference
#> 106          _BOS_ N D of the  Reference
#> 107       _BOS_ J N will also  Reference
#> 108           _BOS_ V the P P  Reference
#> 109           _BOS_ V N was V  Reference
#> 110          _BOS_ D N N only  Reference
#> 111                            Reference
#> 112          _BOS_ V , that V  Reference
#> 113        _BOS_ N was V from  Reference
#> 114          _BOS_ N N N have  Reference
#> 115           _BOS_ P P , all  Reference
#> 116       _BOS_ V to keep the  Reference
#> 117           _BOS_ V , the N  Reference
#> 118            _BOS_ V in a J  Reference
#> 119          _BOS_ V to the N  Reference
#> 120          _BOS_ V to the N  Reference
#> 121          _BOS_ V to the N  Reference
#> 122            _BOS_ P , i ve  Reference
#> 123                            Reference
#> 124      _BOS_ P said he will  Reference
#> 125             _BOS_ P , i V  Reference
#> 126          _BOS_ D N of the  Reference
#> 127          _BOS_ N N were V  Reference
#> 128           _BOS_ P is an N  Reference
#> 129 _BOS_ J about not getting  Reference
#> 130           _BOS_ N are B J  Reference
#> 131            _BOS_ P is V P  Reference
#> 132                            Reference
#> 133           _BOS_ D and D N  Reference
#> 134            _BOS_ J N as P  Reference
#> 135          _BOS_ P had N of  Reference
#> 136     _BOS_ P said he would  Reference
#> 137           _BOS_ P P the N  Reference
#> 138             _BOS_ P , i V  Reference
#> 139                            Reference
#> 140          _BOS_ P , we had  Reference
#> 141          _BOS_ B to the N  Reference
#> 142        _BOS_ P was very J  Reference
#> 143       _BOS_ J N has shown  Reference
#> 144        _BOS_ P , per your  Reference
#> 145             _BOS_ P P P P  Reference
#> 146          _BOS_ P also , V  Reference
#> 147             _BOS_ P P , P  Reference
#> 148           _BOS_ P P and i  Reference
#> 149                            Reference
#> 150             _BOS_ N , P P  Reference
#> 151          _BOS_ V is the N  Reference
#> 152            _BOS_ B i ' ll  Reference
#> 153          _BOS_ N , P this  Reference
#> 154         _BOS_ P P P asked  Reference
#> 155       _BOS_ P , could you  Reference
#> 156        _BOS_ V that the N  Reference
#> 157   _BOS_ D since they have  Reference
#> 158            _BOS_ N of P '  Reference
#> 159         _BOS_ P , can you  Reference
#> 160      _BOS_ P said she had  Reference
#> 161             _BOS_ N P , i  Reference
#> 162             _BOS_ N , P i  Reference
#> 163             _BOS_ N , P i  Reference
#> 164            _BOS_ P , am i  Reference
#> 165    _BOS_ P just wanted to  Reference
#> 166       _BOS_ P here is the  Reference
#> 167           _BOS_ D on P in  Reference
#> 168             _BOS_ N , P i  Reference
#> 169                            Reference
#> 170       _BOS_ P P are going  Reference
#> 171     _BOS_ P , please find  Reference
#> 172          _BOS_ P , we are  Reference
#> 173            _BOS_ V is a N  Reference
#> 174            _BOS_ V is a V  Reference
#> 175         _BOS_ P is very J  Reference
#> 176                            Reference
#> 177          _BOS_ D is J for  Reference
#> 178         _BOS_ N , we have  Reference
#> 179        _BOS_ P and i will  Reference
#> 180      _BOS_ P asked me for  Reference
#> 181        _BOS_ P , for your  Reference
#> 182             _BOS_ J N N P  Reference
#> 183          _BOS_ P V on the  Reference
#> 184                            Reference
#> 185         _BOS_ N will V on  Reference
#> 186      _BOS_ N will V their  Reference
#> 187        _BOS_ N will now V  Reference
#> 188          _BOS_ P P will V  Reference
#> 189             _BOS_ P P , P  Reference
#> 190        _BOS_ P , please V  Reference
#> 191             _BOS_ P N P ,  Reference
#> 192           _BOS_ N and P '  Reference
#> 193     _BOS_ V you very much  Reference
#> 194             _BOS_ P P N i  Reference
#> 195           _BOS_ P is in P  Reference
#> 196        _BOS_ N N i called  Reference
#> 197            _BOS_ P is V P  Reference
#> 198       _BOS_ P V from over  Reference
#> 199             _BOS_ D N V V  Reference
#> 200           _BOS_ V the N V  Reference
#> 201             _BOS_ P P , P  Reference
#> 202           _BOS_ P hey P ,  Reference
#> 203           _BOS_ V J N get  Reference
#> 204     _BOS_ N , please call  Reference
#> 205             _BOS_ P S P ,  Reference
#> 206             _BOS_ P ' s N  Reference
#> 207          _BOS_ V to be in  Reference
#> 208           _BOS_ N S N and  Reference
#> 209                            Reference
#> 210   _BOS_ N for giving some  Reference
#> 211         _BOS_ V that P is  Reference
#> 212          _BOS_ P P we are  Reference
#> 213         _BOS_ B , P would  Reference
#> 214             _BOS_ V P P P  Reference
#> 215             _BOS_ P P , i  Reference
#> 216       _BOS_ V below are N  Reference
#> 217       _BOS_ P has V below  Reference
#> 218             _BOS_ P P ' s  Reference
#> 219                            Reference
#> 220        _BOS_ P will be in  Reference
#> 221       _BOS_ P there are a  Reference
#> 222           _BOS_ P has J P  Reference
#> 223     _BOS_ P would like to  Reference
#> 224    _BOS_ V below are some  Reference
#> 225       _BOS_ J N should be  Reference
#> 226      _BOS_ P will have to  Reference
#> 227             _BOS_ P ' s J  Reference
#> 228           _BOS_ N of N of  Reference
#> 229            _BOS_ N of P '  Reference
#> 230     _BOS_ N very much for  Reference
#> 231        _BOS_ P does not V  Reference
#> 232                            Reference
#> 233          _BOS_ P P will N  Reference
#> 234           _BOS_ N P P and  Reference
#> 235             _BOS_ P S P P  Reference
#> 236             _BOS_ P P P P  Reference
#> 237           _BOS_ P P and P  Reference
#> 238             _BOS_ P S P P  Reference
#> 239             _BOS_ P P P P  Reference
#> 240           _BOS_ P P and P  Reference
#> 241           _BOS_ P P and P  Reference
#> 242            _BOS_ P P at P  Reference
#> 243       _BOS_ P P will have  Reference
#> 244                            Reference
#> 245             _BOS_ P B P P  Reference
#> 246             _BOS_ P P - P  Reference
#> 247             _BOS_ J N - N  Reference
#> 248           _BOS_ P P was V  Reference
#> 249        _BOS_ P has some N  Reference
#> 250          _BOS_ N due P we  Reference
#> 251       _BOS_ P P is taking  Reference
#> 252             _BOS_ N - i V  Reference
#> 253             _BOS_ P P P P  Reference
#> 254           _BOS_ P P has V  Reference
#> 255        _BOS_ P - please V  Reference
#> 256          _BOS_ P P P will  Reference
#> 257                            Reference
#> 258       _BOS_ P and i would  Reference
#> 259           _BOS_ P so if i  Reference
#> 260       _BOS_ D plus i have  Reference
#> 261     _BOS_ P - please work  Reference
#> 262        _BOS_ P to say our  Reference
#> 263       _BOS_ P P they know  Reference
#> 264         _BOS_ P V you for  Reference
#> 265          _BOS_ N may be V  Reference
#> 266           _BOS_ N N N are  Reference
#> 267           _BOS_ N N V one  Reference
#> 268                            Reference
#> 269           _BOS_ N N to be  Reference
#> 270           _BOS_ N the J N  Reference
#> 271         _BOS_ P P will be  Reference
#> 272     _BOS_ N you each have  Reference
#> 273           _BOS_ V the N N  Reference
#> 274     _BOS_ P is working up  Reference
#> 275           _BOS_ P V to be  Reference
#> 276        _BOS_ J N for some  Reference
#> 277                            Reference
#> 278        _BOS_ N N you have  Reference
#> 279        _BOS_ P P needs to  Reference
#> 280      _BOS_ P needs to get  Reference
#> 281        _BOS_ N N may also  Reference
#> 282         _BOS_ P , which V  Reference
#> 283       _BOS_ P and other N  Reference
#> 284             _BOS_ P , N N  Reference
#> 285                            Reference
#> 286             _BOS_ P , i V  Reference
#> 287             _BOS_ P , i V  Reference
#> 288         _BOS_ P , i would  Reference
#> 289           _BOS_ P and P ,  Reference
#> 290           _BOS_ P and P ,  Reference
#> 291             _BOS_ P P P P  Reference
#> 292          _BOS_ P will V V  Reference
#> 293            _BOS_ V P B to  Reference
#> 294        _BOS_ P P keep the  Reference
#> 295                            Reference
#> 296             _BOS_ P , P P  Reference
#> 297           _BOS_ N P N and  Reference
#> 298           _BOS_ P , P and  Reference
#> 299   _BOS_ N for not working  Reference
#> 300             _BOS_ P , P ,  Reference
#> 301           _BOS_ P , i had  Reference
#> 302                            Reference
#> 303           _BOS_ P P and i  Reference
#> 304           _BOS_ P , i had  Reference
#> 305          _BOS_ P i had to  Reference
#> 306           _BOS_ P , i had  Reference
#> 307           _BOS_ P , i had  Reference
#> 308           _BOS_ P , i had  Reference
#> 309           _BOS_ P , i had  Reference
#> 310           _BOS_ P , i had  Reference
#> 311           _BOS_ P , i had  Reference
#> 312            _BOS_ P , V is  Reference
#> 313       _BOS_ P gave me his  Reference
#> 314             _BOS_ N - D -  Reference
#> 315            _BOS_ V N of P  Reference
#> 316       _BOS_ P P needs the  Reference
#> 317     _BOS_ V for N working  Reference
#> 318            _BOS_ P , V is  Reference
#> 319           _BOS_ P and P V  Reference
#> 320           _BOS_ P and P V  Reference
#> 321                            Reference
#> 322           _BOS_ P and P ,  Reference
#> 323            _BOS_ P , i am  Reference
#> 324     _BOS_ P , just wanted  Reference
#> 325            _BOS_ N of P N  Reference
#> 326             _BOS_ P J N N  Reference
#> 327     _BOS_ P P are putting  Reference
#> 328     _BOS_ P and i working  Reference
#> 329             _BOS_ N P P -  Reference
#> 330          _BOS_ N with P P  Reference
#> 331           _BOS_ V P and P  Reference
#> 332        _BOS_ P and P will  Reference
#> 333             _BOS_ P ' s N  Reference
#> 334        _BOS_ P , here are  Reference
#> 335        _BOS_ P , here are  Reference
#> 336           _BOS_ P , V you  Reference
#> 337         _BOS_ P , i would  Reference
#> 338          _BOS_ P , it was  Reference
#> 339           _BOS_ P , the P  Reference
#> 340   _BOS_ P , following are  Reference
#> 341            _BOS_ P , i am  Reference
#> 342           _BOS_ P , P and  Reference
#> 343         _BOS_ P may set a  Reference
#> 344       _BOS_ P can still V  Reference
#> 345       _BOS_ P , would you  Reference
#> 346       _BOS_ P , would you  Reference
#> 347         _BOS_ P and P are  Reference
#> 348         _BOS_ P and P can  Reference
#> 349             _BOS_ P ' s N  Reference
#> 350                            Reference
#> 351           _BOS_ P P , who  Reference
#> 352          _BOS_ P ' most J  Reference
#> 353            _BOS_ N V to a  Reference
#> 354           _BOS_ P P , who  Reference
#> 355            _BOS_ N of N P  Reference
#> 356            _BOS_ P P , an  Reference
#> 357             _BOS_ N P P P  Reference
#> 358      _BOS_ N later V them  Reference
#> 359            _BOS_ N in P '  Reference
#> 360           _BOS_ V P and P  Reference
#> 361           _BOS_ N V the N  Reference
#> 362                            Reference
#> 363             _BOS_ N - P ,  Reference
#> 364             _BOS_ P P P P  Reference
#> 365             _BOS_ P N N P  Reference
#> 366       _BOS_ N that do not  Reference
#> 367                            Reference
#> 368         _BOS_ P and his N  Reference
#> 369             _BOS_ P P P P  Reference
#> 370             _BOS_ P , a J  Reference
#> 371      _BOS_ P could have V  Reference
#> 372      _BOS_ P has said the  Reference
#> 373         _BOS_ D to say he  Reference
#> 374          _BOS_ " N over a  Reference
#> 375          _BOS_ P has V to  Reference
#> 376         _BOS_ P V aside N  Reference
#> 377                            Reference
#> 378           _BOS_ P , who V  Reference
#> 379       _BOS_ N V about the  Reference
#> 380       _BOS_ P will V from  Reference
#> 381         _BOS_ P was V two  Reference
#> 382        _BOS_ V and save a  Reference
#> 383          _BOS_ N of the N  Reference
#> 384      _BOS_ N who use less  Reference
#> 385          _BOS_ P is the N  Reference
#> 386            _BOS_ N V V on  Reference
#> 387         _BOS_ N who use J  Reference
#> 388          _BOS_ V your N J  Reference
#> 389        _BOS_ V those N at  Reference
#> 390          _BOS_ V the N of  Reference
#> 391                            Reference
#> 392             _BOS_ P P ' s  Reference
#> 393       _BOS_ P P said that  Reference
#> 394      _BOS_ N will see the  Reference
#> 395          _BOS_ J N will V  Reference
#> 396        _BOS_ V with the J  Reference
#> 397       _BOS_ J N N already  Reference
#> 398             _BOS_ J J N N  Reference
#> 399           _BOS_ N N , who  Reference
#> 400       _BOS_ N for each of  Reference
#> 401          _BOS_ P P also V  Reference
#> 402             _BOS_ P P , a  Reference
#> 403           _BOS_ D D for P  Reference
#> 404          _BOS_ N N were J  Reference
#> 405                            Reference
#> 406           _BOS_ B , the P  Reference
#> 407        _BOS_ B , that was  Reference
#> 408           _BOS_ B i can V  Reference
#> 409       _BOS_ J , however ,  Reference
#> 410                            Reference
#> 411         _BOS_ N is out of  Reference
#> 412             _BOS_ N N S P  Reference
#> 413          _BOS_ D N and we  Reference
#> 414            _BOS_ P N is V  Reference
#> 415            _BOS_ V at P -  Reference
#> 416          _BOS_ V , i will  Reference
#> 417                            Reference
#> 418      _BOS_ P called N and  Reference
#> 419            _BOS_ P P is B  Reference
#> 420        _BOS_ P is said to  Reference
#> 421          _BOS_ V to V the  Reference
#> 422           _BOS_ V the N N  Reference
#> 423          _BOS_ B , i have  Reference
#> 424         _BOS_ N for the N  Reference
#> 425       _BOS_ N again and i  Reference
#> 426        _BOS_ N for your N  Reference
#> 427    _BOS_ N please see the  Reference
#> 428                            Reference
#> 429           _BOS_ P , the P  Reference
#> 430      _BOS_ P gave me this  Reference
#> 431        _BOS_ N for N with  Reference
#> 432         _BOS_ N again , P  Reference
#> 433          _BOS_ N for V my  Reference
#> 434            _BOS_ P V to V  Reference
#> 435    _BOS_ P also said that  Reference
#> 436                            Reference
#> 437       _BOS_ V that we are  Reference
#> 438           _BOS_ N D N the  Reference
#> 439            _BOS_ P P P to  Reference
#> 440             _BOS_ D N N V  Reference
#> 441            _BOS_ P P is V  Reference
#> 442                            Reference
#> 443     _BOS_ N again and use  Reference
#> 444           _BOS_ N is my N  Reference
#> 445    _BOS_ N again and look  Reference
#> 446     _BOS_ N again and use  Reference
#> 447           _BOS_ N is my N  Reference
#> 448    _BOS_ N again and look  Reference
#> 449        _BOS_ N we B begin  Reference
#> 450          _BOS_ V some N N  Reference
#> 451                            Reference
#> 452      _BOS_ N for you help  Reference
#> 453     _BOS_ N for your help  Reference
#> 454           _BOS_ V you P P  Reference
#> 455         _BOS_ P P will be  Reference
#> 456       _BOS_ N should be V  Reference
#> 457          _BOS_ P P and it  Reference
#> 458     _BOS_ N for your help  Reference
#> 459                            Reference
#> 460        _BOS_ P is now the  Reference
#> 461      _BOS_ N and please V  Reference
#> 462        _BOS_ P P is going  Reference
#> 463         _BOS_ N is for my  Reference
#> 464     _BOS_ N again and use  Reference
#> 465           _BOS_ N is my N  Reference
#> 466    _BOS_ N again and look  Reference
#> 467     _BOS_ N again and use  Reference
#> 468           _BOS_ N is my N  Reference
#> 469    _BOS_ N again and look  Reference
#> 470     _BOS_ N again and use  Reference
#> 471           _BOS_ N is my N  Reference
#> 472                            Reference
#> 473             _BOS_ B a N N  Reference
#> 474     _BOS_ N for your help  Reference
#> 475            _BOS_ J V B to  Reference
#> 476     _BOS_ N for your help  Reference
#> 477         _BOS_ D with N in  Reference
#> 478                            Reference
#> 479   _BOS_ P should not need  Reference
#> 480        _BOS_ P had V that  Reference
#> 481         _BOS_ B to N with  Reference
#> 482           _BOS_ N and i V  Reference
#> 483          _BOS_ N N will V  Reference
#> 484             _BOS_ N , N ,  Reference
#> 485                            Reference
```
