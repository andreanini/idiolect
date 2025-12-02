# Enron sample

A small sample of the *Enron* corpus comprising ten authors with
approximately the same amount of data. Each author has one text labelled
as 'unknown' and the other texts labelled as 'known'. The data was
pre-processed using the *POSnoise* algorithm to mask content (see
[`contentmask()`](https://andreanini.github.io/idiolect/dev/reference/contentmask.md)).

## Usage

``` r
enron.sample
```

## Format

A `quanteda` corpus object.

## Source

Halvani, Oren. 2021. Practice-Oriented Authorship Verification.
Technical University of Darmstadt PhD Thesis.
https://tuprints.ulb.tu-darmstadt.de/19861/
