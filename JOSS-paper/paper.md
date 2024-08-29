---
title: 'idiolect: An R package for forensic authorship analysis'
tags:
  - R
  - linguistics
  - forensic linguistics
  - authorship analysis
  - authorship attribution
  - forensic science
  - stylometry
  - digital humanities
authors:
  - name: Andrea Nini
    orcid: 0000-0003-4218-5130
    corresponding: true
    affiliation: 1
affiliations:
 - name: University of Manchester, UK
   index: 1
date: 29 August 2024
bibliography: paper.bib
---

# Summary

Authorship Analysis is defined as the task of determining the likelihood that a certain person is the author of a certain set of questioned texts. This determination is done by analysing the language of the questioned texts and the language of samples produced by the candidate author or authors. This kind of analysis is often applied in the context of literary problems (e.g. Robert Galbraith as J.K. Rowling's alias [@juola2015], the identity of Elena Ferrante [@tuzzi2018]), historical problems (e.g. Lincoln's Bixby letter [@grieve2019], the Jack the Ripper letters [@nini2018], the writings of Julius Caesar [@kestemont2016]) or forensic contexts (e.g. the *devil strip* ransom letter [@leonard2005], the Amanda Birks murder [@grant2013] or the Ayia Napa rape statements [@donlan2022]).

Especially when dealing with a forensic context, then best practice is to carry out authorship analysis within the Bayesian Likelihood Ratio Framework for expressing evidence in forensic science, which is logically aligned with the role of the expert witness in a court of law. Rather than expressing a final binary judgement (same author vs. different author, or author A vs. author B), the framework instead leads the analyst to express the strength of the linguistic evidence in favour or against a set of two competing hypotheses, for example:

| $H_p$: The candidate author and the author of the questioned text are the same individual.
| $H_d$: The candidate author and the author of the questioned text are two different individuals.

In this way, the analyst can assist the decision maker, the judge/jury or perhaps an historian, to reach a verdict that often needs to take into account evidence and information that is not just linguistic.

# Statement of need

Within this context, `idiolect` is an R package that contains functions to pre-process datasets, run state-of-the-art authorship analysis algorithms, calibrate the results using the Likelihood Ratio Framework, and then explore the results. `idiolect` is fundamentally based on `quanteda` [@benoit2018] for the Natural Language Processing functions and this allows its objects and outputs to be handled efficiently using `quanteda`'s own functions if needed. By being based on `quanteda`, the functions in `idiolect` can efficiently handle very large matrices and can therefore process data quickly or handle very large datasets. This factor is a significant advantage compared to other R packages for authorship analysis such as `stylo` [@eder2016]. In addition to this advantage, `idiolect` also offers recent authorship analysis algorithms that are currently not widely available, especially in R, such as the *Ranking-Based* variant of the *Impostors Method* [@potha2017; @potha2020], *N-gram Tracing* and several of its variants [@grieve2019; @nini2023], and *LambdaG* [@nini].

Most significantly, what sets `idiolect` apart is its use of the Likelihood Ratio Framework. Through a suite of functions, `idiolect` facilitates the calibration of likelihood ratios from the results of any of the authorship analysis functions and then the assessment of the performance of this likelihood ratio using standard performance metrics, such as the $C_{llr}$ [@ramos2013].

Another novelty in `idiolect` is that the package also offers functions that aid the *post-hoc* interpretation of the results. Computational authorship analysis techniques are offer hard to interpret by the analyst. Although this is true, for example, for algorithms such as the *Impostors Method* that are based on the frequency of short sequences of characters, `idiolect` facilitates interpretation by returning the most important features and allowing the user to see these features in context. For *LambdaG*, a purpose-built function can return a colour-coded heat map of a text highlighting the words or constructions that influenced the results.

Although `idiolect` has been designed for research in authorship analysis, stylometry, digital humanities, and forensic linguistics, it can also be used effectively to run analyses for real-life forensic linguistics casework. The code being open source is particularly important in a forensic context to allow opposing experts to replicate the analysis and scrutinize the procedure in full.

# Acknowledgements

I would like to thank Shunichi Ishihara and Marie Bojsen-Møller for helpful comments on the documentation of this package.

# References
