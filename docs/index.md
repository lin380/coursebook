--- 
title: "LIN 380 Coursebook"
subtitle: "Text as Data: An introduction to quantative text analysis and reproducible research with R"
author: "Jerid Francom"
date: "April 23, 2021 (latest version)"
site: bookdown::bookdown_site
bibliography: [coursebook.bib, packages.bib]
biblio-style: apalike
csl: /Users/francojc/Documents/Styles/apa-no-doi-no-issue.csl
link-citations: yes
links-as-notes: true
url: https://lin380.github.io/coursebook/
github-repo: lin380/coursebook
twitter-handle: jeridfrancom
description: "Coursebook to accompany Linguistics 380 'Language Use and Technology'"
cover-image: assets/images/logo.png
favicon: assets/images/favicon.ico
---

# About {-}





<img src="assets/images/logo.png" width="250" alt="Cover image" align="right" style="margin: 0 1em 0 1em" /> This is the coursebook to accompany Linguistics 380 "Language Use and Technology" at Wake Forest University. The working title for this coursebook is *Text as Data: An Introduction to Quantitative Text Analysis and Reproducible Research in R*. The content is currently under development. Feedback is welcome and can be provided through the [hypothes.is](https://web.hypothes.is/) service. A toolbar interface to this service is located on the right sidebar. Note: you will need to register for a free account to make comments and suggestions.


## Build and session information {-}

This coursebook was written in [bookdown](http://bookdown.org/) inside [RStudio](http://www.rstudio.com/ide/). The website is hosted with [GitHub Pages](https://pages.github.com/) and the complete source is available from [GitHub](https://github.com/lin380).

<!-- and automatically updated after every commit by [Travis-CI](https://travis-ci.org).  -->


This version of the coursebook was built with:


```
#> Finding R package dependencies ... Done!
#>  setting  value                       
#>  version  R version 4.0.2 (2020-06-22)
#>  os       macOS  10.16                
#>  system   x86_64, darwin17.0          
#>  ui       X11                         
#>  language (EN)                        
#>  collate  en_US.UTF-8                 
#>  ctype    en_US.UTF-8                 
#>  tz       America/New_York            
#>  date     2021-04-22
```

And depends on these packages:


```{=html}
<div id="htmlwidget-573650b49d7e5a3003aa" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-573650b49d7e5a3003aa">{"x":{"filter":"top","filterHTML":"<tr>\n  <td data-type=\"character\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"character\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"character\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"disabled\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n  <\/td>\n<\/tr>","data":[["base64enc","bookdown","digest","evaluate","glue","highr","htmltools","jsonlite","knitr","magrittr","markdown","mime","rlang","rmarkdown","stringi","stringr","tinytex","xfun","yaml"],[null,"0.22","0.6.27","0.14","1.4.2",null,"0.5.1.1","1.7.2","1.32","2.0.1",null,null,"0.4.10","2.7","1.5.3","1.4.0",null,"0.22","2.2.1"],["2015-07-28","2021-04-22","2020-10-24","2019-05-28","2020-08-27","2021-04-16","2021-01-22","2020-12-09","2021-04-14","2020-11-17","2019-08-07","2021-02-13","2020-12-30","2021-02-19","2020-09-09","2019-02-10","2021-03-30","2021-03-11","2020-02-01"],["CRAN (R 4.0.2)","CRAN (R 4.0.2)","CRAN (R 4.0.2)","CRAN (R 4.0.2)","CRAN (R 4.0.2)","CRAN (R 4.0.2)","CRAN (R 4.0.2)","CRAN (R 4.0.2)","CRAN (R 4.0.2)","CRAN (R 4.0.2)","CRAN (R 4.0.2)","CRAN (R 4.0.2)","CRAN (R 4.0.2)","CRAN (R 4.0.2)","CRAN (R 4.0.2)","CRAN (R 4.0.2)","CRAN (R 4.0.2)","CRAN (R 4.0.2)","CRAN (R 4.0.2)"]],"container":"<table class=\"cell-border stripe\">\n  <thead>\n    <tr>\n      <th>package<\/th>\n      <th>loadedversion<\/th>\n      <th>date<\/th>\n      <th>source<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":19,"autoWidth":true,"bInfo":false,"paging":false,"order":[],"orderClasses":false,"orderCellsTop":true,"lengthMenu":[10,19,25,50,100]}},"evals":[],"jsHooks":[]}</script>
```




