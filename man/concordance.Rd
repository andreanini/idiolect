% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/concordance.R
\name{concordance}
\alias{concordance}
\title{Qualitative examination of evidence}
\usage{
concordance(
  q.data,
  k.data,
  reference.data,
  search,
  token.type = "word",
  window = 5,
  case_insensitive = TRUE
)
}
\arguments{
\item{q.data}{A \code{quanteda} corpus object, such as the output of \code{\link[=create_corpus]{create_corpus()}}, or a tokens object with tokens being sentences, such as the output of \code{\link[=tokenize_sents]{tokenize_sents()}}.}

\item{k.data}{A \code{quanteda} corpus object, such as the output of \code{\link[=create_corpus]{create_corpus()}}, or a tokens object with tokens being sentences, such as the output of \code{\link[=tokenize_sents]{tokenize_sents()}}.}

\item{reference.data}{A \code{quanteda} corpus object, such as the output of \code{\link[=create_corpus]{create_corpus()}}, or a tokens object with tokens being sentences, such as the output of \code{\link[=tokenize_sents]{tokenize_sents()}}. This is optional.}

\item{search}{A string. It can be any sequence of characters and it also accepts the use of * as a wildcard. The special tokens for sentence boundaries are '\emph{BOS}' for beginning of sentence and '\emph{EOS}' for end of sentence.}

\item{token.type}{Choice between "word" (default), which searches for word or punctuation mark tokens, or "character", which instead uses a single character search.}

\item{window}{The number of context items to be displayed around the keyword (a \code{\link[quanteda:kwic]{quanteda::kwic()}} parameter).}

\item{case_insensitive}{Logical; if TRUE, ignore case (a \code{\link[quanteda:kwic]{quanteda::kwic()}} parameter).}
}
\value{
The function returns a data frame containing the concordances for the search pattern.
}
\description{
This function uses \code{\link[quanteda:kwic]{quanteda::kwic()}} to return a concordance for a search pattern. The function takes as input three datasets and a pattern and returns a data frame with the hits labelled for authorship.
}
\examples{
concordance(enron.sample[1], enron.sample[2], enron.sample[3:49], "wants to", token.type = "word")

#using wildcards
concordance(enron.sample[1], enron.sample[2], enron.sample[3:49], "want * to", token.type = "word")

#searching character sequences with wildcards
concordance(enron.sample[1], enron.sample[2], enron.sample[3:49], "help*", token.type = "character")

#using sentences
enron.sents <- tokens(enron.sample, "sentence")
concordance(enron.sents[1], enron.sents[2], enron.sents[3:49], ". _EOS_", token.type = "word")

}
