# Changelog

## idiolect (development version)

- minor bug fixes

- [`contentmask()`](https://andreanini.github.io/idiolect/dev/reference/contentmask.md)
  no longer has the option to replace ASCII; removed dependency on
  `textclean` package.

- [`contentmask()`](https://andreanini.github.io/idiolect/dev/reference/contentmask.md)
  used with the “frames” algorithm now adopts the Universal POS-tags,
  making it more compatible with other languages.

- [`create_corpus()`](https://andreanini.github.io/idiolect/dev/reference/create_corpus.md)
  tests for the correct syntax of the file names and returns an error if
  not correct (plus showing which file names are incorrect).

- [`create_corpus()`](https://andreanini.github.io/idiolect/dev/reference/create_corpus.md)
  includes an argument to specify the encoding of the texts.

## idiolect 1.1.1

CRAN release: 2025-12-03

- minor bug fixes

- [`concordance()`](https://andreanini.github.io/idiolect/dev/reference/concordance.md)
  now can take sentences as input and will also show sentence boundaries

- [`lambdaG_visualize()`](https://andreanini.github.io/idiolect/dev/reference/lambdaG_visualize.md)
  can now the text heatmap either with sentences ordered by lambdaG
  values (default) or by the original order of the sentences in the text

- [`lambdaG_visualize()`](https://andreanini.github.io/idiolect/dev/reference/lambdaG_visualize.md)
  can now visualize negative lambdaG values in an html file

- [`ngram_tracing()`](https://andreanini.github.io/idiolect/dev/reference/ngram_tracing.md)
  contained a major bug when performing tests with multiple known
  authors which would lead to anomalously high and incorrect performance
  statistics. This has been fixed.

- [`performance()`](https://andreanini.github.io/idiolect/dev/reference/performance.md)
  progress bar now can be optional

- [`performance()`](https://andreanini.github.io/idiolect/dev/reference/performance.md)
  can run leave-one-out by author rather than just by text

## idiolect 1.0.1

CRAN release: 2024-08-28

- Fixed issues after CRAN review.

## idiolect 1.0.0

- Initial CRAN submission.
