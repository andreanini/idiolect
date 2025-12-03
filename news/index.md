# Changelog

## idiolect 1.1.1

## idiolect 1.1.0

- minor bug fixes

- [`concordance()`](https://andreanini.github.io/idiolect/reference/concordance.md)
  now can take sentences as input and will also show sentence boundaries

- [`lambdaG_visualize()`](https://andreanini.github.io/idiolect/reference/lambdaG_visualize.md)
  can now the text heatmap either with sentences ordered by lambdaG
  values (default) or by the original order of the sentences in the text

- [`lambdaG_visualize()`](https://andreanini.github.io/idiolect/reference/lambdaG_visualize.md)
  can now visualize negative lambdaG values in an html file

- [`ngram_tracing()`](https://andreanini.github.io/idiolect/reference/ngram_tracing.md)
  contained a major bug when performing tests with multiple known
  authors which would lead to anomalously high and incorrect performance
  statistics. This has been fixed.

- [`performance()`](https://andreanini.github.io/idiolect/reference/performance.md)
  progress bar now can be optional

- [`performance()`](https://andreanini.github.io/idiolect/reference/performance.md)
  can run leave-one-out by author rather than just by text

## idiolect 1.0.1

CRAN release: 2024-08-28

- Fixed issues after CRAN review.

## idiolect 1.0.0

- Initial CRAN submission.
