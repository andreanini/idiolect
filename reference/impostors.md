# Impostors Method

This function runs the *Impostors Method* for authorship verification.
The Impostors Method is based on calculating a similarity score and
then, using a corpus of impostor texts, perform a bootstrapping analysis
sampling random subsets of features and impostors in order to test the
robustness of this similarity.

## Usage

``` r
impostors(
  q.data,
  k.data,
  cand.imps,
  algorithm = "RBI",
  coefficient = "minmax",
  k = 300,
  m = 100,
  n = 25,
  features = FALSE,
  cores = NULL
)
```

## Arguments

- q.data:

  The questioned or disputed data, either as a corpus (the output of
  [`create_corpus()`](https://andreanini.github.io/idiolect/reference/create_corpus.md))
  or as a `quanteda` dfm (the output of
  [`vectorize()`](https://andreanini.github.io/idiolect/reference/vectorize.md)).

- k.data:

  The known or undisputed data, either as a corpus (the output of
  [`create_corpus()`](https://andreanini.github.io/idiolect/reference/create_corpus.md))
  or as a `quanteda` dfm (the output of
  [`vectorize()`](https://andreanini.github.io/idiolect/reference/vectorize.md)).
  More than one sample for a candidate author is accepted for all
  algorithms except IM.

- cand.imps:

  The impostors data for the candidate authors, either as a corpus (the
  output of
  [`create_corpus()`](https://andreanini.github.io/idiolect/reference/create_corpus.md))
  or as a `quanteda` dfm (the output of
  [`vectorize()`](https://andreanini.github.io/idiolect/reference/vectorize.md)).
  This can be the same object as `k.data` (e.g. to recycle impostors).

- algorithm:

  A string specifying which impostors algorithm to use, either "RBI"
  (deafult), "KGI", or "IM".

- coefficient:

  A string indicating the coefficient to use, either "minmax" (default)
  or "cosine". This does not apply to the algorithm KGI, where the
  distance is "minmax".

- k:

  The *k* parameters for the RBI algorithm. Not used by other
  algorithms. The default is 300.

- m:

  The *m* parameter for the IM algorithm. Not used by other algorithms.
  The default is 100.

- n:

  The *n* parameter for the IM algorithm. Not used by other algorithms.
  The default is 25.

- features:

  A logical value indicating whether the important features should be
  retrieved or not. The default is FALSE. This only applies to the RBI
  algorithm.

- cores:

  The number of cores to use for parallel processing (the default is
  one).

## Value

The function will test all possible combinations of Q texts and
candidate authors and return a data frame containing a score ranging
from 0 to 1, with a higher score indicating a higher likelihood that the
same author produced the two sets of texts. The data frame contains a
column called "target" with a logical value which is TRUE if the author
of the Q text is the candidate and FALSE otherwise.

If the RBI algorithm is selected and the features parameter is TRUE then
the data frame will also contain a column with the features that are
likely to have had an impact on the score. These are all those features
that are consistently found to be shared by the candidate author's data
and the questioned data and that also tend to be rare in the dataset of
impostors.

## Details

There are several variants of the Impostors Method and this function can
run three of them:

1.  IM: this is the original Impostors Method as proposed by Koppel and
    Winter (2014).

2.  KGI: Kestemont's et al. (2016) version, which is a very popular
    implementation of the Impostors Method in stylometry. It is inspired
    by IM and by its generalized version, the General Impostors Method
    proposed by Seidman (2013).

3.  RBI: the Rank-Based Impostors Method (Potha and Stamatatos 2017,
    2020), which is the default option as it is the most recent and as
    it tends to outperform the original. The two data sets `q.data`,
    `k.data`, must be disjunct in terms of the texts that they contain
    otherwise an error is returned. However, `cand.imps` and `k.data`
    can be the same object, for example, to use the other candidates'
    texts as impostors. The function will always exclude impostor texts
    with the same author as the Q and K texts considered.

## References

Kestemont, Mike, Justin Stover, Moshe Koppel, Folgert Karsdorp & Walter
Daelemans. 2016. Authenticating the writings of Julius Caesar. Expert
Systems With Applications 63. 86–96.
https://doi.org/10.1016/j.eswa.2016.06.029.

Koppel, Moshe & Yaron Winter. 2014. Determining if two documents are
written by the same author. Journal of the Association for Information
Science and Technology 65(1). 178–187.

Potha, Nektaria & Efstathios Stamatatos. 2017. An Improved Impostors
Method for Authorship Verification. In Gareth J.FALSE. Jones, Séamus
Lawless, Julio Gonzalo, Liadh Kelly, Lorraine Goeuriot, Thomas Mandl,
Linda Cappellato & Nicola Ferro (eds.), Experimental IR Meets
Multilinguality, Multimodality, and Interaction (Lecture Notes in
Computer Science), vol. 10456, 138–144. Springer, Cham.
https://doi.org/10.1007/978-3-319-65813-1_14. (5 September, 2017).

Potha, Nektaria & Efstathios Stamatatos. 2020. Improved algorithms for
extrinsic author verification. Knowledge and Information Systems 62(5).
1903–1921. https://doi.org/10.1007/s10115-019-01408-4.

Seidman, Shachar. 2013. Authorship Verification Using the Impostors
Method. In Pamela Forner, Roberto Navigli, Dan Tufis & Nicola Ferro
(eds.), Proceedings of CLEF 2013 Evaluation Labs and Workshop – Working
Notes Papers, 23–26. Valencia, Spain. https://ceur-ws.org/Vol-1179/.

## Examples

``` r
Q <- enron.sample[1]
K <- enron.sample[2:3]
imps <- enron.sample[4:9]
impostors(Q, K, imps, algorithm = "KGI")
#>         K              Q target score
#> 1 Kevin_h Kevin_h_Mail_1   TRUE  0.36
```
