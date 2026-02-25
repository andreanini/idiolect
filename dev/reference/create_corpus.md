# Create a corpus

Function to read in text data and turn it into a `quanteda` corpus
object.

## Usage

``` r
create_corpus(path, encoding = "UTF-8")
```

## Arguments

- path:

  A string containing the path to a folder of plain text files (ending
  in .txt) with their name structured as following:
  authorname_textname.txt (e.g. smith_text1.txt).

- encoding:

  Either a single string indicating the encoding for all files or a
  vector of strings indicating the encodings for each file. The default
  is UTF-8.

## Value

A `quanteda` corpus object with the authors' names and the text names as
docvars.

## Examples

``` r
if (FALSE) { # \dontrun{
path <- "path/to/data"
create_corpus(path)
} # }
```
