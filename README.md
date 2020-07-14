
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `unirankings`: Comparing University Rankings of Different Countries

<!-- badges: start -->

<!-- badges: end -->

Comparing the cumulative distribution functions of university rankings
among 4 countries: Switzerland, Germany, France, and the
    US.

## Introduction

## Data

  - [qsrankings14.csv](https://github.com/zambujo/unirankings/blob/master/qsrankings14.csv)  
    Source: [QS World University
    Rankings 2014/15](http://www.topuniversities.com/university-rankings/world-university-rankings/2014)

  - [cwur.csv](https://github.com/zambujo/unirankings/blob/master/cwur.csv)  
    Source: [Center for World University
    Rankings](http://cwur.org/2014/)

  - [cwts.csv](https://github.com/zambujo/unirankings/blob/master/cwts.csv)  
    Source: [CWTS Leiden
    rankings](http://www.leidenranking.com/ranking/2014)

## Usage

To run the R scripts in the R folder, you need the following libraries:

``` r
library(tidyverse)
#> ── Attaching packages ────────────────────────────────────────────────────────────────────────────── tidyverse 1.3.0 ──
#> ✓ ggplot2 3.3.2     ✓ purrr   0.3.4
#> ✓ tibble  3.0.1     ✓ dplyr   1.0.0
#> ✓ tidyr   1.1.0     ✓ stringr 1.4.0
#> ✓ readr   1.3.1     ✓ forcats 0.5.0
#> ── Conflicts ───────────────────────────────────────────────────────────────────────────────── tidyverse_conflicts() ──
#> x dplyr::filter() masks stats::filter()
#> x dplyr::lag()    masks stats::lag()
library(here)
#> here() starts at /home/zambujo/Github/unirankings
```

## Result

[QS rankings QQ plot](qs-qqplot.svg)

## License

`unirankings` is released under the [MIT License](./LICENCE.md).
