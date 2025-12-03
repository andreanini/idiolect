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
concordance(enron.sample[1], enron.sample[2], enron.sample[3], "wants to", token.type = "word")
#>                 docname from to     pre     node           post authorship
#> 1 known [Kh Mail_1].txt    5  6 N N N N wants to be N when he V          Q

#using wildcards
concordance(enron.sample[1], enron.sample[2], enron.sample[3], "wants * be", token.type = "word")
#>                 docname from to     pre        node           post authorship
#> 1 known [Kh Mail_1].txt    5  7 N N N N wants to be N when he V up          Q

#searching character sequences with wildcards
concordance(enron.sample[1], enron.sample[2], enron.sample[3], "help*", token.type = "character")
#>                 docname from   to   pre  node  post authorship
#> 1 known [Kh Mail_1].txt  703  707 need  help  V it           Q
#> 2 known [Kh Mail_1].txt 2014 2018 want  help  V it           Q
#> 3 known [Kh Mail_3].txt 1797 1801  N ,  helpe d the          K
#> 4 known [Kh Mail_4].txt   52   56  P P  helpe d the  Reference

#using sentences
enron.sents <- tokens(enron.sample, "sentence")
concordance(enron.sents[1], enron.sents[2], enron.sents[3], ". _EOS_", token.type = "word")
#>                  docname from  to                       pre    node
#> 1  known [Kh Mail_1].txt  114 115               N , but V D . _EOS_
#> 2  known [Kh Mail_1].txt  160 161            D N in first N . _EOS_
#> 3  known [Kh Mail_1].txt  189 190             N about a N N . _EOS_
#> 4  known [Kh Mail_1].txt  369 370             and we V to V . _EOS_
#> 5  known [Kh Mail_1].txt  409 410           ' re V with her . _EOS_
#> 6  known [Kh Mail_1].txt  545 546            the N of the N . _EOS_
#> 7  known [Kh Mail_1].txt  698 699  V in you getting neither . _EOS_
#> 8  known [Kh Mail_1].txt  713 714       just the N it works . _EOS_
#> 9  known [Kh Mail_1].txt  735 736                N is a J N . _EOS_
#> 10 known [Kh Mail_1].txt  873 874      have to say during N . _EOS_
#> 11 known [Kh Mail_3].txt  173 174                J as a J N . _EOS_
#> 12 known [Kh Mail_3].txt  235 236       get V into the call . _EOS_
#> 13 known [Kh Mail_3].txt  285 286      , please let me know . _EOS_
#> 14 known [Kh Mail_3].txt  341 342            you who V of N . _EOS_
#> 15 known [Kh Mail_3].txt  366 367               B for a N N . _EOS_
#> 16 known [Kh Mail_3].txt  410 411     P went well last week . _EOS_
#> 17 known [Kh Mail_3].txt  560 561             of N in its N . _EOS_
#> 18 known [Kh Mail_3].txt  599 600             for the B J N . _EOS_
#> 19 known [Kh Mail_3].txt  625 626               N N and N N . _EOS_
#> 20 known [Kh Mail_3].txt  715 716                 N J J J N . _EOS_
#> 21 known [Kh Mail_4].txt  222 223            , and V your N . _EOS_
#> 22 known [Kh Mail_4].txt  302 303            J N with the N . _EOS_
#> 23 known [Kh Mail_4].txt  666 667             V for a few N . _EOS_
#> 24 known [Kh Mail_4].txt  716 717 especially on the first N . _EOS_
#> 25 known [Kh Mail_4].txt  754 755             her to N on N . _EOS_
#> 26 known [Kh Mail_4].txt  774 775         after the N has V . _EOS_
#> 27 known [Kh Mail_4].txt  785 786             to N on the N . _EOS_
#>                       post authorship
#> 1        _BOS_ P V us they          Q
#> 2        _BOS_ N is in the          Q
#> 3           _BOS_ P , V is          Q
#> 4      _BOS_ J N is always          Q
#> 5            _BOS_ P , P ,          Q
#> 6         _BOS_ N is not a          Q
#> 7          _BOS_ J N , but          Q
#> 8     _BOS_ P is what your          Q
#> 9          _BOS_ J N are B          Q
#> 10                                  Q
#> 11 _BOS_ P had already run          K
#> 12      _BOS_ V the N from          K
#> 13      _BOS_ P i am still          K
#> 14           _BOS_ P P P N          K
#> 15       _BOS_ P per our N          K
#> 16         _BOS_ P V to me          K
#> 17        _BOS_ N of the N          K
#> 18          _BOS_ P P , in          K
#> 19           _BOS_ P P V a          K
#> 20                                  K
#> 21        _BOS_ N , over J  Reference
#> 22          _BOS_ B to D i  Reference
#> 23     _BOS_ N and N under  Reference
#> 24      _BOS_ V , with her  Reference
#> 25     _BOS_ V N should be  Reference
#> 26 _BOS_ V from talking to  Reference
#> 27                          Reference
```
