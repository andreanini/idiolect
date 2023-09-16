#' Create a corpus
#'
#' Function to read in data and turn it into a corpus.
#'
#' @param path A string containing the path to a folder of plain text files (ending in .txt) with their name structured as following: authorname_textname.txt (e.g. smith_text1.txt).
#'
#' @return A `quanteda` corpus object with the authors' names as a docvar.
#' @export
#'
#' @examples
#' \dontrun{
#' path <- "path/to/data"
#' create_corpus(path)
#' }
create_corpus <- function(path){


  corpus <- readtext::readtext(file = paste0(path, "/*.txt"),
                               docvarsfrom = "filenames", docvarnames = c("author", "textname")) |>
    quanteda::corpus()

  return(corpus)

}
