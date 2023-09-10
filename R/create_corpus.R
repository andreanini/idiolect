#' Create a corpus
#'
#' Function to read in data, turn it into a corpus, and potentially Part-of-Speech tag it.
#'
#' @param path A string containing the path to a folder of plain text files (ending in .txt) with their name structured as following: authorname_textname.txt (e.g. smith_text1.txt).
#' @param pos_tag A logical value (default is FALSE) determining whether the corpus should be Part of Speech tagged in preparation for using an algorithm for content masking.
#'
#' @return Either a `quanteda` corpus object with the authors' names as a docvar or a data frame containing the Part of Speech tagged corpus.
#' @export
#'
#' @examples
#' \dontrun{
#' path <- "path/to/data"
#' create_corpus(path)
#' create_corpus(path, pos_tag = T)
#' }
create_corpus <- function(path, pos_tag = F){

  if(pos_tag == T){

    corpus <- readtext::readtext(file = paste0(path, "/*.txt"),
                                docvarsfrom = "filenames", docvarnames = c("author", "textname"))

    spacyr::spacy_initialize()

    final.corpus <- spacyr::spacy_parse(corpus, lemma = F, entity = F)

    spacyr::spacy_finalize()

  }else{

    final.corpus <- readtext::readtext(file = paste0(path, "/*.txt"),
                                      docvarsfrom = "filenames", docvarnames = c("author", "textname"))

  }

  return(final.corpus)

}
