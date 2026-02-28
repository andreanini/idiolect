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
  [`create_corpus()`](https://andreanini.github.io/idiolect/reference/create_corpus.md),
  or a tokens object with tokens being sentences, such as the output of
  [`tokenize_sents()`](https://andreanini.github.io/idiolect/reference/tokenize_sents.md).

- k.data:

  A `quanteda` corpus object, such as the output of
  [`create_corpus()`](https://andreanini.github.io/idiolect/reference/create_corpus.md),
  or a tokens object with tokens being sentences, such as the output of
  [`tokenize_sents()`](https://andreanini.github.io/idiolect/reference/tokenize_sents.md).

- reference.data:

  A `quanteda` corpus object, such as the output of
  [`create_corpus()`](https://andreanini.github.io/idiolect/reference/create_corpus.md),
  or a tokens object with tokens being sentences, such as the output of
  [`tokenize_sents()`](https://andreanini.github.io/idiolect/reference/tokenize_sents.md).
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
#>          docname     pre     node           post authorship
#> 1 Kevin_h_Mail_1 N N N N wants to be N when he V          Q

# using wildcards
concordance(enron.sample[1], enron.sample[2], enron.sample[3], "wants * be", token.type = "word")
#>          docname     pre        node           post authorship
#> 1 Kevin_h_Mail_1 N N N N wants to be N when he V up          Q

# searching character sequences with wildcards
concordance(enron.sample[1], enron.sample[2], enron.sample[3], "help*", token.type = "character")
#>          docname   pre  node  post authorship
#> 1 Kevin_h_Mail_1 need  help  V it           Q
#> 2 Kevin_h_Mail_1 want  help  V it           Q
#> 3 Kevin_h_Mail_3  N ,  helpe d the          K
#> 4 Kevin_h_Mail_4  P P  helpe d the  Reference

# using sentences
enron.sents <- tokens(enron.sample, "sentence")
concordance(enron.sents[1], enron.sents[2], enron.sents[3], ". _EOS_", token.type = "word")
#>           docname                       pre    node                    post
#> 1  Kevin_h_Mail_1               N , but V D . _EOS_       _BOS_ P V us they
#> 2  Kevin_h_Mail_1            D N in first N . _EOS_       _BOS_ N is in the
#> 3  Kevin_h_Mail_1             N about a N N . _EOS_          _BOS_ P , V is
#> 4  Kevin_h_Mail_1             and we V to V . _EOS_     _BOS_ J N is always
#> 5  Kevin_h_Mail_1           ' re V with her . _EOS_           _BOS_ P , P ,
#> 6  Kevin_h_Mail_1            the N of the N . _EOS_        _BOS_ N is not a
#> 7  Kevin_h_Mail_1  V in you getting neither . _EOS_         _BOS_ J N , but
#> 8  Kevin_h_Mail_1       just the N it works . _EOS_    _BOS_ P is what your
#> 9  Kevin_h_Mail_1                N is a J N . _EOS_         _BOS_ J N are B
#> 10 Kevin_h_Mail_1      have to say during N . _EOS_                        
#> 11 Kevin_h_Mail_3                J as a J N . _EOS_ _BOS_ P had already run
#> 12 Kevin_h_Mail_3       get V into the call . _EOS_      _BOS_ V the N from
#> 13 Kevin_h_Mail_3      , please let me know . _EOS_      _BOS_ P i am still
#> 14 Kevin_h_Mail_3            you who V of N . _EOS_           _BOS_ P P P N
#> 15 Kevin_h_Mail_3               B for a N N . _EOS_       _BOS_ P per our N
#> 16 Kevin_h_Mail_3     P went well last week . _EOS_         _BOS_ P V to me
#> 17 Kevin_h_Mail_3             of N in its N . _EOS_        _BOS_ N of the N
#> 18 Kevin_h_Mail_3             for the B J N . _EOS_          _BOS_ P P , in
#> 19 Kevin_h_Mail_3               N N and N N . _EOS_           _BOS_ P P V a
#> 20 Kevin_h_Mail_3                 N J J J N . _EOS_                        
#> 21 Kevin_h_Mail_4            , and V your N . _EOS_        _BOS_ N , over J
#> 22 Kevin_h_Mail_4            J N with the N . _EOS_          _BOS_ B to D i
#> 23 Kevin_h_Mail_4             V for a few N . _EOS_     _BOS_ N and N under
#> 24 Kevin_h_Mail_4 especially on the first N . _EOS_      _BOS_ V , with her
#> 25 Kevin_h_Mail_4             her to N on N . _EOS_     _BOS_ V N should be
#> 26 Kevin_h_Mail_4         after the N has V . _EOS_ _BOS_ V from talking to
#> 27 Kevin_h_Mail_4             to N on the N . _EOS_                        
#>    authorship
#> 1           Q
#> 2           Q
#> 3           Q
#> 4           Q
#> 5           Q
#> 6           Q
#> 7           Q
#> 8           Q
#> 9           Q
#> 10          Q
#> 11          K
#> 12          K
#> 13          K
#> 14          K
#> 15          K
#> 16          K
#> 17          K
#> 18          K
#> 19          K
#> 20          K
#> 21  Reference
#> 22  Reference
#> 23  Reference
#> 24  Reference
#> 25  Reference
#> 26  Reference
#> 27  Reference
```
