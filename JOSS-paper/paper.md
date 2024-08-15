---
title: 'Idiolect: An R package for forensic authorship analysis'
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
date: 
bibliography: paper.bib
---

# Summary

Authorship Analysis is defined as the task of determining the likelihood that a certain candidate is the author of a certain set of questioned or disputed texts.

The forces on stars, galaxies, and dark matter under external gravitational fields lead to the dynamical evolution of structures in the universe. The orbits of these bodies are therefore key to understanding the formation, history, and future state of galaxies. The field of "galactic dynamics," which aims to model the gravitating components of galaxies to study their structure and evolution, is now well-established, commonly taught, and frequently used in astronomy. Aside from toy problems and demonstrations, the majority of problems require efficient numerical tools, many of which require the same base code (e.g., for performing numerical orbit integration).

# Statement of need

We call *Forensic* Authorship Analysis a task of this kind applied in a real forensic case. In such settings, the disputed texts could be anonymous malicious documents, such as a threatening letter, but could also be text messages, emails, or any other document that, for various reasons, becomes evidence in a forensic case. In Forensic Linguistics, typically a set of disputed or *questioned* text is indicated as $Q$, while a set of texts of known origin, for example the texts written by the candidate author and collected as comparison material, is labelled using $K$. In addition to these two datasets, the analysis also necessitates of a comparison reference corpus that we call $R$. In a classic case involving a closed set of suspects, the texts written by the suspects minus the candidate form $R$. In *Authorship Verification* cases that only involve one candidate author, then the reference dataset might have to be compiled by the analyst for the specific case [@ishihara2024].

A crucial difference between Authorship Analysis and Forensic Authorship Analysis is that whereas the former can be treated as a classification task where the final answer is binary ('candidate is the author' vs. 'candidate is NOT the author'), the latter needs an expression of likelihood for the two competing propositions or hypotheses, the Prosecution Hypothesis $H_p$ vs. the Defence Hypothesis $H_d$, for example:

| $H_p$: The author of $K$ and the author of $Q$ are the same individual.
| $H_d$: The author of $K$ and the author of $Q$ are two different individuals.

The job of the forensic linguist in a forensic context is to analyse the linguistic evidence and determine which hypothesis it supports and with what degree of strength, thus aiding the trier-of-fact in reaching a conclusion. The role of the forensic linguist is therefore not to provide a YES/NO answer but rather to express the strength of the evidence in favour of each of these two hypotheses.

Given $K$, $Q$ and $R$, the workflow for this analysis involves four steps:

1.  **Preparation**: This step involves any pre-processing step that is necessary for the analysis with the chosen method;
2.  **Validation**: Carry out an analysis on the case data or on a separate dataset that has been designed to be similar to the case material in order to validate the method for this particular case;
3.  **Analysis**: Carry out the analysis on the real $K$, $Q$, and $R$;
4.  **Calibration**: Turn the output of (3) into a Likelihood Ratio that expresses the strength of the evidence given the two competing hypotheses.

`Gala` is an Astropy-affiliated Python package for galactic dynamics. Python enables wrapping low-level languages (e.g., C) for speed without losing flexibility or ease-of-use in the user-interface. The API for `Gala` was designed to provide a class-based and user-friendly interface to fast (C or Cython-optimized) implementations of common operations such as gravitational potential and force evaluation, orbit integration, dynamical transformations, and chaos indicators for nonlinear dynamics. `Gala` also relies heavily on and interfaces well with the implementations of physical units and astronomical coordinate systems in the `Astropy` package [@astropy] (`astropy.units` and `astropy.coordinates`).

`Gala` was designed to be used by both astronomical researchers and by students in courses on gravitational dynamics or astronomy. It has already been used in a number of scientific publications [@Pearson:2017] and has also been used in graduate courses on Galactic dynamics to, e.g., provide interactive visualizations of textbook material [@Binney:2008]. The combination of speed, design, and support for Astropy functionality in `Gala` will enable exciting scientific explorations of forthcoming data releases from the *Gaia* mission [@gaia] by students and experts alike.

# Mathematics

Single dollars (\$) are required for inline mathematics e.g. $f(x) = e^{\pi/x}$

Double dollars make self-standing equations:

$$\Theta(x) = \left\{\begin{array}{l}
0\textrm{ if } x < 0\cr
1\textrm{ else}
\end{array}\right.$$

You can also use plain \LaTeX for equations \begin{equation}\label{eq:fourier}
\hat f(\omega) = \int_{-\infty}^{\infty} f(x) e^{i\omega x} dx
\end{equation} and refer to \autoref{eq:fourier} from text.

# Citations

Citations to entries in paper.bib should be in [rMarkdown](http://rmarkdown.rstudio.com/authoring_bibliographies_and_citations.html) format.

If you want to cite a software repository URL (e.g. something on GitHub without a preferred citation) then you can do it with the example BibTeX entry below for @fidgit.

For a quick reference, the following citation commands can be used: - `@author:2001` -\> "Author et al. (2001)" - `[@author:2001]` -\> "(Author et al., 2001)" - `[@author1:2001; @author2:2001]` -\> "(Author1 et al., 2001; Author2 et al., 2002)"

# Figures

Figures can be included like this: ![Caption for example figure.](figure.png) and referenced from text using \autoref{fig:example}.

Figure sizes can be customized by adding an optional second parameter: ![Caption for example figure.](figure.png){width="20%"}

# Acknowledgements

I would like to thank Shunichi Ishihara and Marie Bojsen-Møller for helpful comments on the documentation of this package.

# References
