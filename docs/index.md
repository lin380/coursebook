--- 
title: "Text as Data"
subtitle: "An introduction to quantitative text analysis and reproducible research with R"
author: "Jerid Francom"
date: "May 11, 2022 (latest version)"
site: bookdown::bookdown_site
bibliography: [coursebook.bib, packages.bib]
biblio-style: apalike
csl: /Users/francojc/Documents/Styles/apa-no-doi-no-issue.csl
link-citations: yes
links-as-notes: true
url: https://lin380.github.io/coursebook/
github-repo: lin380/coursebook
twitter-handle: jeridfrancom
description: "Textbook"
cover-image: assets/images/logo.png
---

# Welcome {-}





<p style="font-weight:bold; color:red;">INCOMPLETE DRAFT</p>

<!-- <img src="assets/images/logo.png" width="250" alt="Cover image" align="right" style="margin: 0 1em 0 1em; border-color: white;" />  -->

This textbook is an introduction to the fundamental concepts and practical programming skills from Data Science that are increasingly employed in a variety of language-centered fields and sub-fields applied to the task of quantitative text analysis. It is geared towards advanced undergraduates, graduate students, and researchers looking to expand their methodological toolbox.

The content is currently under development. Feedback is welcome and can be provided through the [hypothes.is](https://web.hypothes.is/) service. A toolbar interface to this service is located on the right sidebar. To register for a free account and join the "text_as_data" annotation group [follow this link](https://hypothes.is/groups/WkoaXnBX/text-as-data). Suggestions and changes that are incorporated will be [acknowledged](#acknowledgements). 

**Author**

Dr. Jerid Francom is Associate Professor of Spanish and Linguistics at Wake Forest University. His research focuses on the use of large-scale language archives (corpora) from a variety of sources (news, social media, and other internet sources) to better understand the linguistic and cultural similarities and differences between language varieties for both scholarly and pedagogical projects. He has published on topics including the development, annotation, and evaluation of linguistic corpora and analyzed corpora through corpus, psycholinguistic, and computational methodologies. He also has experience working with and teaching statistical programming with R. 

## License {-}

<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/us/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/3.0/us/88x31.png" /></a><br />This work by [Jerid C. Francom](https://francojc.github.io/) is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/us/">Creative Commons Attribution-NonCommercial-ShareAlike 3.0 United States License</a>.

## Credits {-}

<div>Icons made from <a href="http://www.onlinewebfonts.com/icon">Icon Fonts</a> are licensed by CC BY 3.0</div>

## Acknowledgements {- #acknowledgements}

TAD has been reviewed by and suggestions and changes incorporated based on the feedback through [the TAD Hypothes.is group](https://hypothes.is/groups/Q3o92MJg/tad) by the following people: Andrea Bowling, Caroline Brady, Declan Golsen, Asya Little, ...

## Build information {-}

<!-- This may be a unique textbook compared to others you have seen. It has been created using R itself --specifically using an R package called `bookdown` [@R-bookdown]. This R package makes it possible to write, execute ('run'), and display code and results within the text. The website for this textbook is hosted with [GitHub Pages](https://pages.github.com/) and the complete source is available on [GitHub](https://github.com/lin380). -->

<!-- and automatically updated after every commit by [Travis-CI](https://travis-ci.org).  -->

This version of the textbook was built with R version 4.1.2 (2021-11-01) on macOS Big Sur 10.16 with the following packages: 


|package     |version |source         |
|:-----------|:-------|:--------------|
|assertthat  |0.2.1   |CRAN (R 4.1.0) |
|backports   |1.4.1   |CRAN (R 4.1.2) |
|bookdown    |0.26    |CRAN (R 4.1.2) |
|broom       |0.8.0   |CRAN (R 4.1.2) |
|bslib       |0.3.1   |CRAN (R 4.1.0) |
|cachem      |1.0.6   |CRAN (R 4.1.0) |
|cellranger  |1.1.0   |CRAN (R 4.1.0) |
|cli         |3.3.0   |CRAN (R 4.1.2) |
|colorspace  |2.0.3   |CRAN (R 4.1.2) |
|crayon      |1.5.1   |CRAN (R 4.1.2) |
|DBI         |1.1.2   |CRAN (R 4.1.0) |
|dbplyr      |2.1.1   |CRAN (R 4.1.0) |
|digest      |0.6.29  |CRAN (R 4.1.0) |
|downlit     |0.4.0   |CRAN (R 4.1.0) |
|dplyr       |1.0.9   |CRAN (R 4.1.2) |
|DT          |0.22    |CRAN (R 4.1.2) |
|ellipsis    |0.3.2   |CRAN (R 4.1.0) |
|evaluate    |0.15    |CRAN (R 4.1.2) |
|fansi       |1.0.3   |CRAN (R 4.1.2) |
|fastmap     |1.1.0   |CRAN (R 4.1.0) |
|forcats     |0.5.1   |CRAN (R 4.1.0) |
|fs          |1.5.2   |CRAN (R 4.1.0) |
|generics    |0.1.2   |CRAN (R 4.1.2) |
|ggplot2     |3.3.5   |CRAN (R 4.1.0) |
|glue        |1.6.2   |CRAN (R 4.1.2) |
|gtable      |0.3.0   |CRAN (R 4.1.0) |
|haven       |2.5.0   |CRAN (R 4.1.2) |
|here        |1.0.1   |CRAN (R 4.1.0) |
|hms         |1.1.1   |CRAN (R 4.1.0) |
|htmltools   |0.5.2   |CRAN (R 4.1.0) |
|htmlwidgets |1.5.4   |CRAN (R 4.1.0) |
|httr        |1.4.2   |CRAN (R 4.1.0) |
|janeaustenr |0.1.5   |CRAN (R 4.0.2) |
|jquerylib   |0.1.4   |CRAN (R 4.1.0) |
|jsonlite    |1.8.0   |CRAN (R 4.1.2) |
|knitr       |1.39    |CRAN (R 4.1.2) |
|lattice     |0.20.45 |CRAN (R 4.1.2) |
|lifecycle   |1.0.1   |CRAN (R 4.1.0) |
|lubridate   |1.8.0   |CRAN (R 4.1.0) |
|magrittr    |2.0.3   |CRAN (R 4.1.2) |
|Matrix      |1.4.1   |CRAN (R 4.1.2) |
|memoise     |2.0.1   |CRAN (R 4.1.0) |
|modelr      |0.1.8   |CRAN (R 4.1.0) |
|munsell     |0.5.0   |CRAN (R 4.1.0) |
|pacman      |0.5.1   |CRAN (R 4.1.0) |
|pillar      |1.7.0   |CRAN (R 4.1.2) |
|pkgconfig   |2.0.3   |CRAN (R 4.1.0) |
|purrr       |0.3.4   |CRAN (R 4.1.0) |
|R6          |2.5.1   |CRAN (R 4.1.0) |
|Rcpp        |1.0.8.3 |CRAN (R 4.1.2) |
|readr       |2.1.2   |CRAN (R 4.1.2) |
|readxl      |1.4.0   |CRAN (R 4.1.2) |
|reprex      |2.0.1   |CRAN (R 4.1.0) |
|rlang       |1.0.2   |CRAN (R 4.1.2) |
|rmarkdown   |2.14    |CRAN (R 4.1.2) |
|rprojroot   |2.0.3   |CRAN (R 4.1.2) |
|rstudioapi  |0.13    |CRAN (R 4.1.0) |
|rvest       |1.0.2   |CRAN (R 4.1.0) |
|sass        |0.4.1   |CRAN (R 4.1.2) |
|scales      |1.2.0   |CRAN (R 4.1.2) |
|sessioninfo |1.2.2   |CRAN (R 4.1.0) |
|SnowballC   |0.7.0   |CRAN (R 4.1.0) |
|stringi     |1.7.6   |CRAN (R 4.1.0) |
|stringr     |1.4.0   |CRAN (R 4.1.0) |
|tibble      |3.1.6   |CRAN (R 4.1.0) |
|tidyr       |1.2.0   |CRAN (R 4.1.2) |
|tidyselect  |1.1.2   |CRAN (R 4.1.2) |
|tidytext    |0.3.2   |CRAN (R 4.1.0) |
|tidyverse   |1.3.1   |CRAN (R 4.1.0) |
|tokenizers  |0.2.1   |CRAN (R 4.1.0) |
|tzdb        |0.3.0   |CRAN (R 4.1.2) |
|utf8        |1.2.2   |CRAN (R 4.1.0) |
|vctrs       |0.4.1   |CRAN (R 4.1.2) |
|webshot     |0.5.3   |CRAN (R 4.1.2) |
|withr       |2.5.0   |CRAN (R 4.1.2) |
|xfun        |0.30    |CRAN (R 4.1.2) |
|xml2        |1.3.3   |CRAN (R 4.1.0) |
|yaml        |2.3.5   |CRAN (R 4.1.2) |



