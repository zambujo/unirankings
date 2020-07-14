
<!-- README.md is generated from README.Rmd. Please edit that file -->

# unirankings: Comparing University Rankings of Different Countries

<!-- badges: start -->

<!-- badges: end -->

Comparing the cumulative distribution functions of university rankings
among 4 countries: Switzerland, Germany, France, and the US.

## Introduction

## Data

  - [QS
    rankings](https://github.com/zambujo/unirankings/blob/master/data/qs.csv)
    from [QS World University
    Rankings 2020/21](http://www.topuniversities.com/university-rankings/world-university-rankings)

## Usage

To run the R scripts in the R folder, you need the following libraries:

``` r
shhh <- suppressPackageStartupMessages
shhh(library(tidyverse))
shhh(library(jsonlite))
shhh(library(janitor))
shhh(library(here))
shhh(library(conflicted))
```

``` r
# sort out most likely conflicts
conflict_prefer('flatten', 'purrr')
conflict_prefer('filter', 'dplyr')
conflict_prefer('lag', 'dplyr')
```

## Result

[QS rankings QQ plot](qs-qqplot.svg)

## License

`unirankings` is released under the [MIT License](./LICENCE.md).
