% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ngram_tracing.R
\name{ngram_tracing}
\alias{ngram_tracing}
\title{N-gram tracing}
\usage{
ngram_tracing(
  q.data,
  k.data,
  tokens = "character",
  remove_punct = FALSE,
  remove_symbols = TRUE,
  remove_numbers = TRUE,
  lowercase = TRUE,
  n = 9,
  coefficient = "simpson",
  features = FALSE,
  cores = NULL
)
}
\arguments{
\item{q.data}{The questioned or disputed data, either as a corpus (the output of \code{\link[=create_corpus]{create_corpus()}}) or as a \code{quanteda} dfm (the output of \code{\link[=vectorize]{vectorize()}}).}

\item{k.data}{The known or undisputed data, either as a corpus (the output of \code{\link[=create_corpus]{create_corpus()}}) or as a \code{quanteda} dfm (the output of \code{\link[=vectorize]{vectorize()}}). More than one sample for a candidate author is accepted but the function will combine them so to make a profile.}

\item{tokens}{The type of tokens to extract, either "word" or "character" (default).}

\item{remove_punct}{A logical value. FALSE (default) keeps punctuation marks.}

\item{remove_symbols}{A logical value. TRUE (default) removes symbols.}

\item{remove_numbers}{A logical value. TRUE (default) removes numbers.}

\item{lowercase}{A logical value. TRUE (default) transforms all tokens to lower case.}

\item{n}{The order or size of the n-grams being extracted. Default is 9.}

\item{coefficient}{The coefficient to use to compare texts, one of: "simpson" (default), "phi", "jaccard", "kulczynski", or "cole".}

\item{features}{Logical with default FALSE. If TRUE then the result table will contain the features in the overlap that are unique for that overlap in the corpus. If only two texts are present then this will return the n-grams in common.}

\item{cores}{The number of cores to use for parallel processing (the default is one).}
}
\value{
The function will test all possible combinations of Q texts and candidate authors and return a
data frame containing the value of the similarity coefficient selected called 'score' and an optional column with the overlapping features that only occur in the Q and candidate considered and in no other Qs (ordered by length if the n-gram is of variable length). The data frame contains a column called 'target' with a logical value which is TRUE if the author of the Q text is the candidate and FALSE otherwise.
}
\description{
This function runs the authorship analysis method called \emph{n-gram tracing}, which can be used for both attribution and verification.
}
\details{
N-gram tracing was originally proposed by Grieve et al (2019). Nini (2023) then proposed a mathematical reinterpretation that is compatible with Cognitive Linguistic theories of language processing. He then tested several variants of the method and found that the original version, which uses the Simpson's coefficient, tends to be outperformed by versions using the Phi coefficient, the Kulczynski's coefficient, and the Cole coefficient. This function can run the n-gram tracing method using any of these coefficients plus the Jaccard coefficient for reference, as this coefficient has been applied in several forensic linguistic studies.
}
\examples{
Q <- enron.sample[c(5:6)]
K <- enron.sample[-c(5:6)]
ngram_tracing(Q, K, coefficient = 'phi')

}
\references{
Grieve, Jack, Emily Chiang, Isobelle Clarke, Hannah Gideon, Aninna Heini, Andrea Nini & Emily Waibel. 2019. Attributing the Bixby Letter using n-gram tracing. Digital Scholarship in the Humanities 34(3). 493–512.
Nini, Andrea. 2023. A Theory of Linguistic Individuality for Authorship Analysis (Elements in Forensic Linguistics). Cambridge, UK: Cambridge University Press.
}
