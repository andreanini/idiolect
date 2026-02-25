#' Create a corpus
#'
#' Function to read in text data and turn it into a `quanteda` corpus object.
#'
#' @param path A string containing the path to a folder of plain text files (ending in .txt) with their name structured as following: authorname_textname.txt (e.g. smith_text1.txt).
#' @param encoding Either a single string indicating the encoding for all files or a vector of strings indicating the encodings for each file. The default is UTF-8.
#'
#' @return A `quanteda` corpus object with the authors' names and the text names as docvars.
#'
#' @examples
#' \dontrun{
#' path <- "path/to/data"
#' create_corpus(path)
#' }
#'
#' @export
create_corpus <- function(path, encoding = "UTF-8") {
  #### test syntax of file names ####
  filenames <- list.files(path)

  tests <- filenames |>
    sapply(\(x){
      stringr::str_detect(x, "(.+)_(.+)\\.txt")
    })

  if (any(!tests)) {
    wrong.files <- names(tests[tests == FALSE]) |> paste(collapse = ", ")
    stop("Some files do not follow the required syntax: ", wrong.files)
  }

  #### main function ####
  corpus <- readtext::readtext(
    file = paste0(path, "/*.txt"),
    docvarsfrom = "filenames", docvarnames = c("author", "textname"),
    encoding = encoding
  ) |>
    quanteda::corpus()

  return(corpus)
}
