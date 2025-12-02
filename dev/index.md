# idiolect

The `idiolect` R package is designed to provide a comprehensive suite of
tools for performing comparative authorship analysis within a forensic
context using the Likelihood Ratio Framework (e.g. Ishihara 2021; Nini
2023). The package contains a set of authorship analysis functions that
take a set of texts as input and output scores that can then be
calibrated into likelihood ratios. The package is dependent on
[`quanteda`](https://quanteda.io) (Benoit et al. 2018) for all Natural
Language Processing functions.

## Installation

You can install `idiolect` from CRAN:

``` r
install.packages("idiolect")
```

## Workflow

The main functions contained in the package reflect the typical workflow
for authorship analysis for forensic problems:

1.  Input data using
    [`create_corpus()`](https://andreanini.github.io/idiolect/dev/reference/create_corpus.md);

2.  Optionally mask the content/topic of the texts using
    [`contentmask()`](https://andreanini.github.io/idiolect/dev/reference/contentmask.md);

3.  Launch an analysis
    (e.g. [`delta()`](https://andreanini.github.io/idiolect/dev/reference/delta.md),
    [`ngram_tracing()`](https://andreanini.github.io/idiolect/dev/reference/ngram_tracing.md),
    [`impostors()`](https://andreanini.github.io/idiolect/dev/reference/impostors.md));

4.  Test the performance of the method on ground truth data using
    [`performance()`](https://andreanini.github.io/idiolect/dev/reference/performance.md);

5.  Finally, apply the method to the questioned text and generate a
    likelihood ratio with
    [`calibrate_LLR()`](https://andreanini.github.io/idiolect/dev/reference/calibrate_LLR.md).

Check the website and the vignette for examples.

## References

Benoit, Kenneth, Kohei Watanabe, Haiyan Wang, Paul Nulty, Adam Obeng,
Stefan Müller, and Akitaka Matsuo. 2018. “Quanteda: An r Package for the
Quantitative Analysis of Textual Data.” *Journal of Open Source
Software* 3 (30). <https://doi.org/10.21105/joss.00774>.

Ishihara, Shunichi. 2021. “Score-Based Likelihood Ratios for Linguistic
Text Evidence with a Bag-of-Words Model.” *Forensic Science
International* 327: 110980.
<https://doi.org/10.1016/j.forsciint.2021.110980>.

Nini, Andrea. 2023. *A Theory of Linguistic Individuality for Authorship
Analysis*. Elements in Forensic Linguistics. Cambridge, UK: Cambridge
University Press.
