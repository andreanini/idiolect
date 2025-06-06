% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/lambdaG_visualize.R
\name{lambdaG_visualize}
\alias{lambdaG_visualize}
\title{Visualize the output of the LambdaG algorithm}
\usage{
lambdaG_visualize(
  q.data,
  k.data,
  ref.data,
  N = 10,
  r = 30,
  output = "html",
  print = "",
  scale = "absolute",
  negative = FALSE,
  order.by = "importance",
  cores = NULL
)
}
\arguments{
\item{q.data}{A single questioned or disputed text as a \code{quanteda} tokens object with the tokens being sentences (e.g. the output of \code{\link[=tokenize_sents]{tokenize_sents()}}).}

\item{k.data}{A known or undisputed corpus containing exclusively a single candidate author's texts as a \code{quanteda} tokens object with the tokens being sentences (e.g. the output of \code{\link[=tokenize_sents]{tokenize_sents()}}).}

\item{ref.data}{The reference dataset as a \code{quanteda} tokens object with the tokens being sentences (e.g. the output of \code{\link[=tokenize_sents]{tokenize_sents()}}).}

\item{N}{The order of the model. Default is 10.}

\item{r}{The number of iterations. Default is 30.}

\item{output}{A string detailing the file type of the colour-coded text output. Either "html" (default) or "latex".}

\item{print}{A string indicating the path and filename to save the colour-coded text file. If left empty (default), then nothing is printed.}

\item{scale}{A string indicating what scale to use to colour-code the text file. If "absolute" (default) then the raw \eqn{\lambda_G} is used; if "relative", then the z-score of \eqn{\lambda_G} over the Q data is used instead, thus showing relative importance.}

\item{negative}{Logical. If TRUE then negative values of \eqn{\lambda_G} are color-coded in blue, otherwise (default) only the positive values of \eqn{\lambda_G} are displayed in red. This only applies to HTML output.}

\item{order.by}{A string indicating the order of the output. If "importance" (default) then the output is ordered by sentence \eqn{\lambda_G} in descending order, otherwise the text is displayed and ordered as it appears.}

\item{cores}{The number of cores to use for parallel processing (the default is one).}
}
\value{
The function outputs a list of two objects: a data frame with each row being a token in the Q text and the values of \eqn{\lambda_G} for the token and sentences, in decreasing order of sentence \eqn{\lambda_G} and with the relative contribution of each token and each sentence to the final \eqn{\lambda_G} in percentage; the raw code in html or LaTeX that generates the colour-coded file. If a path is provided for the print argument then the function will also save the colour-coded text as an html or plain text file.
}
\description{
This function outputs a colour-coded list of sentences belonging to the input Q text ordered from highest to lowest \eqn{\lambda_G}, as shown in Nini et al. (under review).
}
\examples{
q.data <- corpus_trim(enron.sample[1], "sentences", max_ntoken = 10) |> quanteda::tokens("sentence")
k.data <- enron.sample[2:5]|> quanteda::tokens("sentence")
ref.data <- enron.sample[6:ndoc(enron.sample)] |> quanteda::tokens("sentence")
outputs <- lambdaG_visualize(q.data, k.data, ref.data, r = 2)
outputs$table

}
\references{
Nini, A., Halvani, O., Graner, L., Gherardi, V., Ishihara, S. Authorship Verification based on the Likelihood Ratio of Grammar Models. https://arxiv.org/abs/2403.08462v1
}
