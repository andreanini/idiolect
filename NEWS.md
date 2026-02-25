# idiolect (development version)

* `create_corpus()` tests for the correct syntax of the file names and returns an error if not correct (plus showing which file names are incorrect).

* `create_corpus()` includes an argument to specify the encoding of the texts.

# idiolect 1.1.1

* minor bug fixes

* `concordance()` now can take sentences as input and will also show sentence boundaries

* `lambdaG_visualize()` can now the text heatmap either with sentences ordered by lambdaG values (default) or by the original order of the sentences in the text

* `lambdaG_visualize()` can now visualize negative lambdaG values in an html file

* `ngram_tracing()` contained a major bug when performing tests with multiple known authors which would lead to anomalously high and incorrect performance statistics. This has been fixed.

* `performance()` progress bar now can be optional

* `performance()` can run leave-one-out by author rather than just by text

# idiolect 1.0.1

* Fixed issues after CRAN review.

# idiolect 1.0.0

* Initial CRAN submission.
