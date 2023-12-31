% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/delta.R
\name{delta}
\alias{delta}
\title{Delta}
\usage{
delta(
  q.data,
  k.data,
  tokens = "word",
  remove_punct = F,
  remove_symbols = T,
  remove_numbers = T,
  lowercase = T,
  n = 1,
  trim = T,
  threshold = 150,
  features = F,
  cores = NULL
)
}
\arguments{
\item{q.data}{The questioned or disputed data, either as a corpus (the output of \code{\link[=create_corpus]{create_corpus()}}) or as a \code{quanteda} dfm (the output of \code{\link[=vectorize]{vectorize()}}).}

\item{k.data}{The known or undisputed data, either as a corpus (the output of \code{\link[=create_corpus]{create_corpus()}}) or as a \code{quanteda} dfm (the output of \code{\link[=vectorize]{vectorize()}}).}

\item{tokens}{The type of tokens to extract, either "word" (default) or "character".}

\item{remove_punct}{A logical value. FALSE (default) keeps punctuation marks.}

\item{remove_symbols}{A logical value. TRUE (default) removes symbols.}

\item{remove_numbers}{A logical value. TRUE (default) removes numbers}

\item{lowercase}{A logical value. TRUE (default) transforms all tokens to lower case.}

\item{n}{The order or size of the n-grams being extracted. Default is 1.}

\item{trim}{A logical value. If TRUE (default) then only the most frequent tokens are kept.}

\item{threshold}{A numeric value indicating how many most frequent tokens to keep if trim = T. The default is 150.}

\item{features}{Logical with default FALSE. If TRUE, then the output will contain the features used.}

\item{cores}{The number of cores to use for parallel processing (the default is one).}
}
\value{
If features is set to FALSE then the output is a data frame containing the results of all comparisons between the Q texts and the K texts. If features is set to TRUE then the output is a list containing the results data frame and the vector of features used for the analysis.
}
\description{
This function runs a classic Delta analysis, more precisely its Cosine variant.
}
\examples{
qs <- refcor.sample[c(1, 4, 7)]
ks <- refcor.sample[-c(1, 4, 7)]
delta(qs, ks, features = TRUE)
}
