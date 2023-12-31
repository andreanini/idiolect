
<!-- README.md is generated from README.Rmd. Please edit that file -->

# *idiolect*: An R package for forensic authorship verification

<!-- badges: start -->
<!-- badges: end -->

---------- !!! WARNING: CURRENTLY IN DEVELOPMENT !!! ----------

The `idiolect` R package is designed to provide a framework for
performing comparative authorship analysis within a forensic context and
using the likelihood ratio framework. The package contains a set of
authorship verification functions that take a set of texts as input and
output scores that can then be calibrated into likelihood ratios. The
package is dependent on [`quanteda`](https://quanteda.io) (Benoit et al.
2018) for the Natural Language Processing functions.

## Installation

You can install the development version of `idiolect` using the
`install_github()` function of the `devtools` package:

``` r
devtools::install_github("https://github.com/andreanini/idiolect")
```

## Example

The main functions contained in the package reflect the typical workflow
for the use of authorship verification methods for forensic problems:

1.  Input data using `create_corpus()`;

2.  Optionally mask the content/topic of the texts using
    `contentmask()`;

3.  Turn the texts into feature vectors with `vectorize()`;

4.  Run a verification function. At the moment the only implemented one
    is the *Impostors Method* in `impostors()`;

5.  Test the performance of the method on known data using
    `performance()`;

6.  Finally, apply the method to the questioned text and generate a
    likelihood ratio with `calibrate_LLR()`.

## References

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-benoit2018" class="csl-entry">

Benoit, Kenneth, Kohei Watanabe, Haiyan Wang, Paul Nulty, Adam Obeng,
Stefan Müller, and Akitaka Matsuo. 2018. “Quanteda: An r Package for the
Quantitative Analysis of Textual Data.” *Journal of Open Source
Software* 3 (30). <https://doi.org/10.21105/joss.00774>.

</div>

</div>
