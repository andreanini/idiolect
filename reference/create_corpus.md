# Create a corpus

Function to read in text data and turn it into a `quanteda` corpus
object.

## Usage

``` r
create_corpus(path)
```

## Arguments

- path:

  A string containing the path to a folder of plain text files (ending
  in .txt) with their name structured as following:
  authorname_textname.txt (e.g. smith_text1.txt).

## Value

A `quanteda` corpus object with the authors' names as a docvar.

## Examples

``` r
if (FALSE) { # \dontrun{
path <- "path/to/data"
create_corpus(path)
} # }
```
