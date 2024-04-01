
<!-- README.md is generated from README.Rmd. Please edit that file -->

# idiolect <img src="man/figures/logo.png" align="right" height="139"/>

<!-- badges: start -->
<!-- badges: end -->

## Overview

The `idiolect` R package is designed to provide a comprehensive suite of
tools for performing comparative authorship analysis within a forensic
context using the likelihood ratio framework (e.g. Ishihara 2021). The
package contains a set of authorship analysis functions that take a set
of texts as input and output scores that can then be calibrated into
likelihood ratios. The package is dependent on
[`quanteda`](https://quanteda.io) (Benoit et al. 2018) for all Natural
Language Processing functions.

## Installation

You can install the development version of `idiolect` using the
`install_github()` function of the `devtools` package:

``` r
devtools::install_github("https://github.com/andreanini/idiolect")
```

## Example

The main functions contained in the package reflect the typical workflow
for authorship analysis for forensic problems:

1.  Input data using `create_corpus()`;

2.  Optionally mask the content/topic of the texts using
    `contentmask()`;

3.  Launch an analysis (`delta()`, `ngram_tracing()`, or `impostors()`);

4.  Test the performance of the method on ground truth data using
    `performance()`;

5.  Finally, apply the method to the questioned text and generate a
    likelihood ratio with `calibrate_LLR()`.

## References

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-benoit2018" class="csl-entry">

Benoit, Kenneth, Kohei Watanabe, Haiyan Wang, Paul Nulty, Adam Obeng,
Stefan Müller, and Akitaka Matsuo. 2018. “Quanteda: An r Package for the
Quantitative Analysis of Textual Data.” *Journal of Open Source
Software* 3 (30). <https://doi.org/10.21105/joss.00774>.

</div>

<div id="ref-ishihara2021" class="csl-entry">

Ishihara, Shunichi. 2021. “Score-Based Likelihood Ratios for Linguistic
Text Evidence with a Bag-of-Words Model.” *Forensic Science
International* 327: 110980.
<https://doi.org/10.1016/j.forsciint.2021.110980>.

</div>

</div>
