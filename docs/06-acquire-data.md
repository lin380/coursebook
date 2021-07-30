# (PART) Preparation {-}

# Overview {-#preparation-overview}





Overview...


# Acquire data

<p style="font-weight:bold; color:red;">INCOMPLETE DRAFT</p>

> The scariest moment is always just before you start.
>
> ―--Stephen King

<div class="rmdkey">
<p>In this chapter you will learn:</p>
<ul>
<li>the goals of this textbook</li>
<li>the reasoning for using the R programming language</li>
<li>important text conventions employed in this textbook</li>
</ul>
</div>


<!-- COURSE STRUCTURE

TUTORIALS:

- Primers: 
  - Introduction to Iteration: https://rstudio.cloud/learn/primers/5.1
  - Write Functions: https://rstudio.cloud/learn/primers/6
    - Function basics
    - How to Write a Function
    - Arguments

SWIRL:

- ...

WORKED/ RECIPE:

- ...

PROJECT:

- ...

GOALS:

...

-->



Overview... (edit)

I will provide an overview of the first of three common strategies for acquiring corpus data in R: accessing corpus data from data repositories and individual sites. I will cover acquiring data from different sources and introduce you to the R code that will help speed the process, maintain consistency in our data, and set the stage for a reproducible workflow.

There are three main ways to acquire corpus data using R that I will introduce you to: **downloads**, **APIs**, and **web scraping**. In this chapter we will start by manual and programmatically downloading a corpus as it is the most straightforward process for the novice R programmer and typically incurs the least number of steps. Along the way I will introduce some key R coding concepts including control statements and custom functions. Using R packages to interface with APIs involves delving into more detail about R objects and custom functions. Finally acquiring data from the web is the most idiosyncratic and involves both knowledge of the web, more sophisticated R skills, and often some clever hacking skills. 


## Downloads

### Manual

The first acquisition method I will cover here is inherently non-reproducible from the standpoint that the programming implementation cannot acquire the data based solely on running the project code itself. In other words, it requires manual intervention. Manual downloads are typical for data resources which are not openly accessible on the public facing web. These can be resources that require institutional or private licensing ([Language Data Consortium](https://www.ldc.upenn.edu/), [International Corpus of English](http://ice-corpora.net/ice/), [BYU Corpora](https://www.corpusdata.org/), etc.), require authorization/ registration ([The Language Archive](https://archive.mpi.nl/tla/), [COW Corpora](https://www.webcorpora.org/), etc.), and/ or are only accessible via resource search interfaces ([Corpus of Spanish in Southern Arizona](https://cesa.arizona.edu/), [Corpus Escrito del Español como L2 (CEDEL2)](http://cedel2.learnercorpora.com/), etc.). 

Let's work with the CEDEL2 corpus [@Lozano2009] which provides a search interface and open access to the data through the search interface. The homepage can be seen in Figure \@ref(fig:ad-show-page-cedel2-1). 

<div class="figure" style="text-align: center">
<img src="images/06-acquire-data/ad-cedel2-site.png" alt="CEDEL2 Corpus homepage" width="90%" />
<p class="caption">(\#fig:ad-show-page-cedel2-1)CEDEL2 Corpus homepage</p>
</div>

Following the search/ download link you can find a search interface that allows the user to select the sub-corpus of interest. I've selected the subcorpus "Learners of L2 Spanish" and specified the L1 as English. 

<div class="figure" style="text-align: center">
<img src="images/06-acquire-data/ad-cedel2-search-download.png" alt="Search and download interface for the CEDEL2 Corpus" width="90%" />
<p class="caption">(\#fig:ad-show-page-cedel2-2)Search and download interface for the CEDEL2 Corpus</p>
</div>

The 'Download' link now appears for this search criteria. Following this link will provide the user a form to fill out. This particular resource allows for access to different formats to download (Texts only, Texts with metadata, CSV (Excel), CSV (Others)). I will select the 'CSV (Others)' option so that the data is structured for easier processing downstream when we work to curate the data in our next processing step. Then I will choose to save the CSV in the `data/original/` directory of my project and create a sub-directory called `cedel2/`. 

```bash
data/
├── derived
└── original
    └── cedel2
       └── texts.csv
```

Other resources will inevitably include unique processes to obtaining the data, but in the end the data should be archived in the research structure in the `data/original/` directory and be treated as 'read-only'. 

### Programmatic

There are many resources that provide corpus data is directly accessible for which programmatic approaches can be applied. Let's take a look at how this works starting with the a sample from the Switchboard Corpus, a corpus of 2,400 telephone conversations by 543 speakers. First we navigate to the site with a browser and download the file that we are looking for. In this case I found the Switchboard Corpus on the [NLTK data repository site](http://www.nltk.org/nltk_data/). More often than not this file will be some type of compressed archive file with an extension such  as `.zip` or `.tz`, which is the case here. Archive files make downloading large single files or multiple files easy by grouping files and directories into one file. In R we can used the `download.file()` function from the base R library^[Remember base R packages are installed by default with R and are loaded and accessible by default in each R session.]. There are a number of **arguments** that a function may require or provide optionally. The `download.file()` function minimally requires two: `url` and `destfile`. That is the file to download and the location where it is to be saved to disk.


```r
# Download .zip file and write to disk
download.file(url = "https://raw.githubusercontent.com/nltk/nltk_data/gh-pages/packages/corpora/switchboard.zip",
    destfile = "../data/original/switchboard.zip")
```

As we can see looking at the directory structure for `data/` the `switchboard.zip` file has been downloaded. 

```bash
data
├── derived
└── original
    └── switchboard.zip
```

Once an archive file is downloaded, however, the file needs to be 'decompressed' to reveal the file structure. To decompress this file we use the `unzip()` function with the arguments `zipfile` pointing to the `.zip` file and `exdir` specifying the directory where we want the files to be extracted to. 


```r
# Decompress .zip file and extract to our target directory
unzip(zipfile = "../data/original/switchboard.zip", exdir = "../data/original/")
```

The directory structure of `data/` now should look like this:

```bash
data
├── derived
└── original
    ├── switchboard
    │   ├── README
    │   ├── discourse
    │   ├── disfluency
    │   ├── tagged
    │   ├── timed-transcript
    │   └── transcript
    └── switchboard.zip
```

At this point we have acquired the data programmatically and with this code as part of our workflow anyone could run this code and reproduce the same results. The code as it is, however, is not ideally efficient. Firstly the `switchboard.zip` file is not strictly needed after we decompress it and it occupies disk space if we keep it. And second, each time we run this code the file will be downloaded from the remote serve leading to unnecessary data transfer and server traffic. Let's tackle each of these issues in turn.

To avoid writing the `switchboard.zip` file to disk (long-term) we can use the `tempfile()` function to open a temporary holding space for the file. This space can then be used to store the file, unzip it, and then the temporary file will be destroyed. We assign the temporary space to an R object we will name `temp` with the `tempfile()` function. This object can now be used as the value of the argument `destfile` in the `download.file()` function. Let's also assign the web address to another object `url` which we will use as the value of the `url` argument. 


```r
# Create a temporary file space for our .zip file
temp <- tempfile()
# Assign our web address to `url`
url <- "https://raw.githubusercontent.com/nltk/nltk_data/gh-pages/packages/corpora/switchboard.zip"
# Download .zip file and write to disk
download.file(url, temp)
```

<div class="rmdtip">
<p>In the previous code I’ve used the values stored in the objects <code>url</code> and <code>temp</code> in the <code>download.file()</code> function without specifying the argument names –only providing the names of the objects. R will assume that values of a function map to the ordering of the arguments. If your values do not map to ordering of the arguments you are required to specify the argument name and the value. To view the ordering of objects hit <code>TAB</code> after entering the function name or consult the function documentation by prefixing the function name with <code>?</code> and hitting <code>ENTER</code>.</p>
</div>

At this point our downloaded file is stored temporarily on disk and can be accessed and decompressed to our target directory using `temp` as the value for the argument `zipfile` from the `unzip()` function. I've assigned our target directory path to `target_dir` and used it as the value for the argument `exdir` to prepare us for the next tweak on our approach.


```r
# Assign our target directory to `target_dir`
target_dir <- "../data/original/"
# Decompress .zip file and extract to our target directory
unzip(zipfile = temp, exdir = target_dir)
```

Our directory structure now looks like this:

```bash
data
├── derived
└── original
    └── switchboard
        ├── README
        ├── discourse
        ├── disfluency
        ├── tagged
        ├── timed-transcript
        └── transcript
```

The second issue I raised concerns the fact that running this code as part of our project will repeat the download each time. Since we would like to be good citizens and avoid unnecessary traffic on the web it would be nice if our code checked to see if we already have the data on disk and if it exists, then skip the download, if not then download it. 

To achieve this we need to introduce two new functions `if()` and `dir.exists()`. `dir.exists()` takes a path to a directory as an argument and returns the logical value, `TRUE`, if that directory exists, and `FALSE` if it does not. `if()` evaluates logical statements and processes subsequent code based on the logical value it is passed as an argument. Let's look at a toy example.


```r
num <- 1
if (num == 1) {
    cat(num, "is 1")
} else {
    cat(num, "is not 1")
}
#> 1 is 1
```

I assigned `num` to the value `1` and created a logical evaluation `num == ` whose result is passed as the argument to `if()`. If the statement returns `TRUE` then the code withing the first set of curly braces `{...}` is run. If `num == 1` is false, like in the code below, the code withing the braces following the `else` will be run.


```r
num <- 2
if (num == 1) {
    cat(num, "is 1")
} else {
    cat(num, "is not 1")
}
#> 2 is not 1
```

The function `if()` is one of various functions that are called **control statements**. Theses functions provide a lot of power to make dynamic choices as code is run. 

Before we get back to our key objective to avoid downloading resources that we already have on disk, let me introduce another strategy to making code more powerful and ultimately more efficient and as well as more legible --the **custom function**. Custom functions are functions that the user writes to create a set of procedures that can be run in similar contexts. I've created a custom function named `eval_num()` below.


```r
eval_num <- function(num) {
    if (num == 1) {
        cat(num, "is 1")
    } else {
        cat(num, "is not 1")
    }
}
```

Let's take a closer look at what's going on here. The function `function()` creates a function in which the user decides what arguments are necessary for the code to perform its task. In this case the only necessary argument is the object to store a numeric value to be evaluated. I've called it `num` because it reflects the name of the object in our toy example, but there is nothing special about this name. It's only important that the object names be consistently used. I've included our previous code (except for the hard-coded assignment of `num`) inside the curly braces and assigned the entire code chunk to `eval_num`. 

We can now use the function `eval_num()` to perform the task of evaluating whether a value of `num` is or is not equal to `1`.


```r
eval_num(num = 1)
#> 1 is 1
eval_num(num = 2)
#> 2 is not 1
eval_num(num = 3)
#> 3 is not 1
```

I've put these coding strategies together with our previous code in a custom function I named `get_zip_data()`. There is a lot going on here. Take a look first and see if you can follow the logic involved given what you now know.



```r
get_zip_data <- function(url, target_dir) {
    # Function: to download and decompress a .zip file to a target directory

    # Check to see if the data already exists if data does not exist, download/
    # decompress
    if (!dir.exists(target_dir)) {
        cat("Creating target data directory \n")  # print status message
        dir.create(path = target_dir, recursive = TRUE, showWarnings = FALSE)  # create target data directory
        cat("Downloading data... \n")  # print status message
        temp <- tempfile()  # create a temporary space for the file to be written to
        download.file(url = url, destfile = temp)  # download the data to the temp file
        unzip(zipfile = temp, exdir = target_dir, junkpaths = TRUE)  # decompress the temp file in the target directory
        cat("Data downloaded! \n")  # print status message
    } else {
        # if data exists, don't download it again
        cat("Data already exists \n")  # print status message
    }
}
```

OK. You should have recognized the general steps in this function: the argument `url` and `target_dir` specify where to get the data and where to write the decompressed files, the `if()` statement evaluates whether the data already exists, if not (`!dir.exists(target_dir)`) then the data is downloaded and decompressed, if it does exist (`else`) then it is not downloaded. 
<div class="rmdtip">
<p>The prefixed <code>!</code> in the logical expression <code>dir.exists(target_dir)</code> returns the opposite logical value. This is needed in this case so when the target directory exists, the expression will return <code>FALSE</code>, not <code>TRUE</code>, and therefore not proceed in downloading the resource.</p>
</div>

There are a couple key tweaks I've added that provide some additional functionality. For one I've included the function `dir.create()` to create the target directory where the data will be written. I've also added an additional argument to the `unzip()` function, `junkpaths = TRUE`. Together these additions allow the user to create an arbitrary directory path where the files, and only the files, will be extracted to on our disk. This will discard the containing directory of the `.zip` file which can be helpful when we want to add multiple `.zip` files to the same target directory. 

A practical scenario where this applies is when we want to download data from a corpus that is contained in multiple `.zip` files but still maintain these files in a single primary data directory. Take for example the [Santa Barbara Corpus](http://www.linguistics.ucsb.edu/research/santa-barbara-corpus). This corpus resource includes a series of interviews in which there is one `.zip` file, `SBCorpus.zip` which contains the [transcribed interviews](http://www.linguistics.ucsb.edu/sites/secure.lsit.ucsb.edu.ling.d7/files/sitefiles/research/SBC/SBCorpus.zip) and another `.zip` file, `metadata.zip` which organizes the [meta-data](http://www.linguistics.ucsb.edu/sites/secure.lsit.ucsb.edu.ling.d7/files/sitefiles/research/SBC/metadata.zip) associated with each speaker. Applying our initial strategy to download and decompress the data will lead to the following directory structure:

```bash
data
├── derived
└── original
    ├── SBCorpus
    │   ├── TRN
    │   └── __MACOSX
    │       └── TRN
    └── metadata
        └── __MACOSX
```

By applying our new custom function `get_zip_data()` to the transcriptions and then the meta-data we can better organize the data.


```r
# Download corpus transcriptions
get_zip_data(url = "http://www.linguistics.ucsb.edu/sites/secure.lsit.ucsb.edu.ling.d7/files/sitefiles/research/SBC/SBCorpus.zip",
    target_dir = "../data/original/sbc/transcriptions/")

# Download corpus meta-data
get_zip_data(url = "http://www.linguistics.ucsb.edu/sites/secure.lsit.ucsb.edu.ling.d7/files/sitefiles/research/SBC/metadata.zip",
    target_dir = "../data/original/sbc/meta-data/")
```


```bash
data
├── derived
└── original
    └── sbc
        ├── meta-data
        └── transcriptions
```

If we add data from other sources we can keep them logical separate and allow our data collection to scale without creating unnecessary complexity. Let's add the Switchboard Corpus sample using our `get_zip_data()` function to see this in action.



```r
# Download corpus
get_zip_data(url = "https://raw.githubusercontent.com/nltk/nltk_data/gh-pages/packages/corpora/switchboard.zip",
    target_dir = "../data/original/scs/")
```


```bash
data
├── derived
└── original
    ├── sbc
    │   ├── meta-data
    │   └── transcriptions
    └── scs
        ├── README
        ├── discourse
        ├── disfluency
        ├── tagged
        ├── timed-transcript
        └── transcript
```

At this point we have what we need to continue to the next step in our data analysis project. But before we go, we should do some housekeeping to document and organize this process to make our work reproducible. We will take advantage of the `project-template` directory structure, seen below.

```bash
├── README.md
├── _pipeline.R
├── analysis
│   ├── 1_acquire_data.Rmd
│   ├── 2_curate_dataset.Rmd
│   ├── 3_transform_dataset.Rmd
│   ├── 4_analyze_dataset.Rmd
│   ├── 5_generate_article.Rmd
│   ├── _session-info.Rmd
│   ├── _site.yml
│   ├── index.Rmd
│   └── references.bib
├── data
│   ├── derived
│   └── original
│       ├── sbc
│       └── scs
├── functions
└── output
    ├── figures
    └── results
```

First it is good practice to separate custom functions from our processing scripts. We can create a file in our `functions/` directory named `acquire_functions.R` and add our custom function `get_zip_data()` there. 

<div class="rmdtip">
<p>Note that that the <code>acquire_functions.R</code> file is an R script, not an Rmarkdown document. Therefore code chunks that are used in <code>.Rmd</code> files are not used, only the R code itself.</p>
</div>

We then use the `source()` function to read that function into our current script to make it available to use as needed. It is good practice to source your functions in the SETUP section of your script.


```r
# Load custom functions for this project
source(file = "../functions/acquire_functions.R")
```

In this section, to sum up, we've covered how to access, download, and organize data contained in .zip files; the most common format for language data found on repositories and individual sites. This included an introduction to a few key R programming concepts and strategies including using functions, writing custom functions, and controlling program flow with control statements. Our approach was to gather data while also keeping in mind the reproducibility of the code. To this end I introduced programming strategies for avoiding unnecessary web traffic (downloads), scalable directory creation, and data documentation. 

<div class="rmdnote">
<p>The custom function <code>get_zip_data()</code> works with <code>.zip</code> files. There are many other compressed file formats (e.g. <code>.gz</code>, <code>.tar</code>, <code>.tgz</code>), however. In the R package <code>tadr</code> that accompanies this coursebook, a modified version of the <code>get_zip_data()</code> function, <code>get_compressed_data()</code>, extends the same logic to deal with a wider range of compressed file formats, including <code>.zip</code> files.</p>
<p>Explore this function’s documentation (<code>?tadr::get_compressed_data()</code>) and/ or view the code (<code>tadr::get_compressed_data</code>) to better understand this function.</p>
</div>

## APIs

A convenient alternative method for acquiring data in R is through package interfaces to web services. These interfaces are built using R code to make connections with resources on the web through **Automatic Programming Interfaces** (APIs). Websites such as Project Gutenberg, Twitter, Facebook, and many others provide APIs to allow access to their data under certain conditions, some more limiting for data collection than others. Programmers (like you!) in the R community take up the task of wrapping calls to an API with R code to make accessing that data from R possible. For example, [gutenbergr](https://CRAN.R-project.org/package=gutenbergr) provides access to Project Gutenberg, [rtweet](https://CRAN.R-project.org/package=rtweet) to Twitter, and [Rfacebook](https://CRAN.R-project.org/package=Rfacebook) to Facebook. 

### Open access

Using R package interfaces, however, often requires some more knowledge about R objects and functions. Let's take a look at how to access data from Project Gutenberg through the `gutenbergr` package. Along the way we will touch upon various functions and concepts that are key to working with the R data types vectors and data frames including filtering and writing tabular data to disk in plain-text format. 

To get started let's install and/ or load the `gutenbergr` package. If a package is not part of the R base library, we cannot assume that the user will have the package in their library. The standard approach for installing and then loading a package is by using the `install.packages()` function and then calling `library()`. 


```r
install.packages("gutenbergr")  # install `gutenbergr` package
library(gutenbergr)  # load the `gutenbergr` package
```

This approach works just fine, but luck has it that there is an R package for installing and loading packages! The [pacman](https://CRAN.R-project.org/package=pacman) package includes a set of functions for managing packages. A very useful one is `p_load()` which will look for a package on a system, load it if it is found, and install and then load it if it is not found. This helps potentially avoid using unnecessary bandwidth to install packages that may already exist on a user's system. But, to use `pacman` we need to include the code to install and load it with the functions `install.packages()` and `library()`. I've included some code that will mimic the behavior of `p_load()` for installing `pacman` itself, but as you can see it is not elegant, luckily it's only used once as we add it to the SETUP section of our master file, `_pipeline.R`.


```r
# Load `pacman`. If not installed, install then load.
if (!require("pacman", character.only = TRUE)) {
    install.packages("pacman")
    library("pacman", character.only = TRUE)
}
```


Now that we have `pacman` installed and loaded into our R session, let's use the `p_load()` function to make sure to install/ load the two packages we will need for the upcoming tasks. If you are following along with the `project_template`, add this code within the SETUP section of the `1_acquire_data.Rmd` file. 


```r
# Script-specific options or packages
pacman::p_load(tidyverse, gutenbergr)
```

<div class="rmdwarning">
<p>Note that the arguments <code>tidyverse</code> and <code>gutenbergr</code> are comma-separated but not quoted when using <code>p_load()</code>. When using <code>install.packages()</code> to install, package names need to be quoted (character strings). <code>library()</code> can take quotes or no quotes, but only one package at a time.</p>
</div>

Project Gutenberg provides access to thousands of texts in the public domain. The `gutenbergr` package contains a set of tables, or **data frames** in R speak, that index the meta-data for these texts broken down by text (`gutenberg_metadata`), author (`gutenberg_authors`), and subject (`gutenberg_subjects`). I'll use the `glimpse()` function loaded in the [tidyverse](https://CRAN.R-project.org/package=tidyverse) package ^[`tidyverse` is not a typical package. It is a set of packages: `ggplot2`, `dplyr`, `tidyr`, `readr`, `purrr`, and `tibble`. These packages are all installed/ loaded with `tidyverse` and form the backbone for the type of work you will typically do in most analyses.] to summarize the structure of these data frames.


```r
glimpse(gutenberg_metadata)  # summarize text meta-data
#> Rows: 51,997
#> Columns: 8
#> $ gutenberg_id        <int> 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, …
#> $ title               <chr> NA, "The Declaration of Independence of the United…
#> $ author              <chr> NA, "Jefferson, Thomas", "United States", "Kennedy…
#> $ gutenberg_author_id <int> NA, 1638, 1, 1666, 3, 1, 4, NA, 3, 3, NA, 7, 7, 7,…
#> $ language            <chr> "en", "en", "en", "en", "en", "en", "en", "en", "e…
#> $ gutenberg_bookshelf <chr> NA, "United States Law/American Revolutionary War/…
#> $ rights              <chr> "Public domain in the USA.", "Public domain in the…
#> $ has_text            <lgl> TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TR…
glimpse(gutenberg_authors)  # summarize authors meta-data
#> Rows: 16,236
#> Columns: 7
#> $ gutenberg_author_id <int> 1, 3, 4, 5, 7, 8, 9, 10, 12, 14, 16, 17, 18, 20, 2…
#> $ author              <chr> "United States", "Lincoln, Abraham", "Henry, Patri…
#> $ alias               <chr> NA, NA, NA, NA, "Dodgson, Charles Lutwidge", NA, "…
#> $ birthdate           <int> NA, 1809, 1736, NA, 1832, NA, 1819, 1860, 1805, 17…
#> $ deathdate           <int> NA, 1865, 1799, NA, 1898, NA, 1891, 1937, 1844, 18…
#> $ wikipedia           <chr> NA, "http://en.wikipedia.org/wiki/Abraham_Lincoln"…
#> $ aliases             <chr> NA, "United States President (1861-1865)/Lincoln, …
glimpse(gutenberg_subjects)  # summarize subjects meta-data
#> Rows: 140,173
#> Columns: 3
#> $ gutenberg_id <int> 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, …
#> $ subject_type <chr> "lcc", "lcsh", "lcsh", "lcc", "lcc", "lcsh", "lcsh", "lcc…
#> $ subject      <chr> "E201", "United States. Declaration of Independence", "Un…
```


\BeginKnitrBlock{rmdtip}<div class="rmdtip">The `gutenberg_metadata`, `gutenberg_authors`, and `gutenberg_subjects` are periodically updated. To check to see when each data frame was last updated run:
  
`attr(gutenberg_metadata, "date_updated")`
</div>\EndKnitrBlock{rmdtip}

To download the text itself we use the `gutenberg_download()` function which takes one required argument, `gutenberg_id`. The `gutenberg_download()` function is what is known as 'vectorized', that is, it can take a single value or multiple values for the argument `gutenberg_id`. Vectorization refers to the process of applying a function to each of the elements stored in a **vector** --a primary object type in R. A vector is a grouping of values of one of various types including character (`chr`), integer (`int`), double (`dbl`), and logical (`lgl`) and a data frame is a grouping of vectors. The `gutenberg_download()` function takes an integer vector which can be manually added or selected from the `gutenberg_metadata` or `gutenberg_subjects` data frames using the `$` operator (e.g. `gutenberg_metadata$gutenberg_id`). 

Let's first add them manually here as a toy example by generating a vector of integers from 1 to 5 assigned to the variable name `ids`. 


```r
ids <- 1:5  # integer vector of values 1 to 5
ids
#> [1] 1 2 3 4 5
```

To download the works from Project Gutenberg corresponding to the `gutenberg_id`s 1 to 5, we pass the `ids` object to the `gutenberg_download()` function.


```r
works_sample <- gutenberg_download(gutenberg_id = ids)  # download works with `gutenberg_id` 1-5
glimpse(works_sample)  # summarize `works` dataset
#> Rows: 2,959
#> Columns: 2
#> $ gutenberg_id <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, …
#> $ text         <chr> "December, 1971  [Etext #1]", "", "", "The Project Gutenb…
```


Two attributes are returned: `gutenberg_id` and `text`. The `text` column contains values for each line of text (delimited by a carriage return) for each of the 5 works we downloaded. There are many more attributes available from the Project Gutenberg API that can be accessed by passing a character vector of the attribute names to the argument `meta_fields`. The column names of the `gutenberg_metadata` data frame contains the available attributes. 


```r
names(gutenberg_metadata)  # print the column names of the `gutenberg_metadata` data frame
#> [1] "gutenberg_id"        "title"               "author"             
#> [4] "gutenberg_author_id" "language"            "gutenberg_bookshelf"
#> [7] "rights"              "has_text"
```

Let's augment our previous download with the title and author of each of the works. To create a character vector we use the `c()` function, then, quote and delimit the individual elements of the vector with a comma.


```r
# download works with `gutenberg_id` 1-5 including `title` and `author` as
# attributes
works_sample <- gutenberg_download(gutenberg_id = ids, meta_fields = c("title", "author"))
glimpse(works_sample)  # summarize dataset
#> Rows: 2,959
#> Columns: 4
#> $ gutenberg_id <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, …
#> $ text         <chr> "December, 1971  [Etext #1]", "", "", "The Project Gutenb…
#> $ title        <chr> "The Declaration of Independence of the United States of …
#> $ author       <chr> "Jefferson, Thomas", "Jefferson, Thomas", "Jefferson, Tho…
```

Now, in a more practical scenario we would like to select the values of `gutenberg_id` by some principled query such as works from a specific author, language, or subject. To do this we first query either the `gutenberg_metadata` data frame or the `gutenberg_subjects` data frame. Let's say we want to download a random sample of 10 works from English Literature (Library of Congress Classification, "PR"). Using the `dplyr::filter()` function (`dplyr` is part of the `tidyverse` package set) we first extract all the Gutenberg ids from `gutenberg_subjects` where `subject_type == "lcc"` and `subject == "PR"` assigning the result to `ids`.^[See [Library of Congress Classification](https://www.loc.gov/catdir/cpso/lcco/) documentation for a complete list of subject codes.]


```r
# filter for only English literature
ids <- filter(gutenberg_subjects, subject_type == "lcc", subject == "PR")
glimpse(ids)
#> Rows: 7,100
#> Columns: 3
#> $ gutenberg_id <int> 11, 12, 13, 16, 20, 26, 27, 35, 36, 42, 43, 46, 58, 60, 8…
#> $ subject_type <chr> "lcc", "lcc", "lcc", "lcc", "lcc", "lcc", "lcc", "lcc", "…
#> $ subject      <chr> "PR", "PR", "PR", "PR", "PR", "PR", "PR", "PR", "PR", "PR…
```

<div class="rmdwarning">
<p>The operators <code>=</code> and <code>==</code> are not equivalents. <code>==</code> is used for logical evaluation and <code>=</code> is an alternate notation for variable assignment (<code>&lt;-</code>).</p>
</div>

The `gutenberg_subjects` data frame does not contain information as to whether a `gutenberg_id` is associated with a plain-text version. To limit our query to only those English Literature works with text, we filter the `gutenberg_metadata` data frame by the ids we have selected in `ids` and the attribute `has_text` in the `gutenberg_metadata` data frame. 


```r
# Filter for only those works that have text
ids_has_text <- 
  filter(gutenberg_metadata, 
         gutenberg_id %in% ids$gutenberg_id, 
         has_text == TRUE)
glimpse(ids_has_text)
#> Rows: 6,724
#> Columns: 8
#> $ gutenberg_id        <int> 11, 12, 13, 16, 20, 26, 27, 35, 36, 42, 43, 46, 58…
#> $ title               <chr> "Alice's Adventures in Wonderland", "Through the L…
#> $ author              <chr> "Carroll, Lewis", "Carroll, Lewis", "Carroll, Lewi…
#> $ gutenberg_author_id <int> 7, 7, 7, 10, 17, 17, 23, 30, 30, 35, 35, 37, 17, 4…
#> $ language            <chr> "en", "en", "en", "en", "en", "en", "en", "en", "e…
#> $ gutenberg_bookshelf <chr> "Children's Literature", "Children's Literature/Be…
#> $ rights              <chr> "Public domain in the USA.", "Public domain in the…
#> $ has_text            <lgl> TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TR…
```

\BeginKnitrBlock{rmdtip}<div class="rmdtip">A couple R programming notes on the code phrase `gutenberg_id %in% ids$gutenberg_id`. First, the `$` symbol in `ids$gutenberg_id` is the programmatic way to target a particular column in an R data frame. In this example we select the `ids` data frame and the column `gutenberg_id`, which is a integer vector. The `gutenberg_id` variable that precedes the `%in%` operator does not need an explicit reference to a data frame because the primary argument of the `filter()` function is this data frame (`gutenberg_metadata`). Second, the `%in%` operator logically evaluates whether the vector elements in `gutenberg_metadata$gutenberg_ids` are also found in the vector `ids$gutenberg_id` returning `TRUE` and `FALSE` accordingly. This effectively filters those ids which are not in both vectors.</div>\EndKnitrBlock{rmdtip}

As we can see the number of works with text is fewer than the number of works listed, 7100 versus 6724. Now we can safely do our random selection of 10 works, with the function `slice_sample()` and be confident that the ids we select will contain text when we take the next step by downloading the data. 


```r
set.seed(123)  # make the sampling reproducible
ids_sample <- slice_sample(ids_has_text, n = 10)  # sample 10 works
glimpse(ids_sample)  # summarize the dataset
#> Rows: 10
#> Columns: 8
#> $ gutenberg_id        <int> 10564, 10784, 9316, 1540, 24450, 13821, 7595, 3818…
#> $ title               <chr> "Fairy Gold\nShip's Company, Part 4.", "Sentence D…
#> $ author              <chr> "Jacobs, W. W. (William Wymark)", "Jacobs, W. W. (…
#> $ gutenberg_author_id <int> 1865, 1865, 2364, 65, 999, 2685, 761, 1317, 3564, …
#> $ language            <chr> "en", "en", "en", "en", "en", "en", "en", "en", "e…
#> $ gutenberg_bookshelf <chr> NA, NA, NA, NA, "Adventure", "Fantasy", NA, NA, NA…
#> $ rights              <chr> "Public domain in the USA.", "Public domain in the…
#> $ has_text            <lgl> TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TR…
```


```r
works_pr <- gutenberg_download(gutenberg_id = ids_sample$gutenberg_id, meta_fields = c("author",
    "title"))
glimpse(works_pr)  # summarize the dataset
#> Rows: 47,515
#> Columns: 4
#> $ gutenberg_id <int> 1540, 1540, 1540, 1540, 1540, 1540, 1540, 1540, 1540, 154…
#> $ text         <chr> "cover ", "", "", "", "THE TEMPEST", "", "", "", "by Will…
#> $ author       <chr> "Shakespeare, William", "Shakespeare, William", "Shakespe…
#> $ title        <chr> "The Tempest", "The Tempest", "The Tempest", "The Tempest…
```

At this point we have data and could move on to processing this dataset in preparation for analysis. However, we are aiming for a reproducible workflow and this code does not conform to our principle of modularity: each subsequent step in our analysis will depend on running this code first. Furthermore, running this code as it is creates issues with bandwidth, as in our previous examples from direct downloads. To address modularity we will write the dataset to disk in **plain-text format**. In this way each subsequent step in our analysis can access the dataset locally. To address bandwidth concerns, we will devise a method for checking to see if the dataset is already downloaded and skip the download, if possible, to avoid accessing the Project Gutenberg server unnecessarily.

To write our data frame to disk we will export it into a standard plain-text format for two-dimensional datasets: a CSV file (comma-separated value). The CSV structure for this dataset will look like this:


```r
works_pr %>%
    head() %>%
    format_csv() %>%
    cat()
#> gutenberg_id,text,author,title
#> 1540,cover ,"Shakespeare, William",The Tempest
#> 1540,,"Shakespeare, William",The Tempest
#> 1540,,"Shakespeare, William",The Tempest
#> 1540,,"Shakespeare, William",The Tempest
#> 1540,THE TEMPEST,"Shakespeare, William",The Tempest
#> 1540,,"Shakespeare, William",The Tempest
```

The first line contains the names of the columns and subsequent lines the observations. Data points that contain commas themselves (e.g. "Shaw, Bernard") are quoted to avoid misinterpreting these commas a deliminators in our data. To write this dataset to disk we will use the `reader::write_csv()` function. 


```r
write_csv(works_pr, file = "../data/original/gutenberg_works_pr.csv")
```

To avoid downloading dataset that already resides on disk, let's implement a similar strategy to the one used for direct downloads (`get_zip_data()`). I've incorporated the code for sampling and downloading data for a particular subject from Project Gutenberg with a control statement to check if the dataset file already exists into a function I named `get_gutenberg_subject()`. Take a look at this function below. 


```r
get_gutenberg_subject <- function(subject, target_file, sample_size = 10) {
  # Function: to download texts from Project Gutenberg with 
  # a specific LCC subject and write the data to disk.
  
  pacman::p_load(tidyverse, gutenbergr) # install/load necessary packages
  
  # Check to see if the data already exists
  if(!file.exists(target_file)) { # if data does not exist, download and write
    target_dir <- dirname(target_file) # generate target directory for the .csv file
    dir.create(path = target_dir, recursive = TRUE, showWarnings = FALSE) # create target data directory
    cat("Downloading data... \n") # print status message
    # Select all records with a particular LCC subject
    ids <- 
      filter(gutenberg_subjects, 
             subject_type == "lcc", subject == subject) # select subject
    # Select only those records with plain text available
    set.seed(123) # make the sampling reproducible
    ids_sample <- 
      filter(gutenberg_metadata, 
             gutenberg_id %in% ids$gutenberg_id, # select ids in both data frames 
             has_text == TRUE) %>% # select those ids that have text
      slice_sample(n = sample_size) # sample N works 
    # Download sample with associated `author` and `title` metadata
    works_sample <- 
      gutenberg_download(gutenberg_id = ids_sample$gutenberg_id, 
                         meta_fields = c("author", "title"))
    # Write the dataset to disk in .csv format
    write_csv(works_sample, file = target_file)
    cat("Data downloaded! \n") # print status message
  } else { # if data exists, don't download it again
    cat("Data already exists \n") # print status message
  }
}
```

Adding this function to our function script `functions/acquire_functions.R`, we can now source this function in our `analysis/1_acquire_data.Rmd` script to download multiple subjects and store them in on disk in their own file. 

Let's download American Literature now (LCC code "PQ"). 


```r
# Download Project Gutenberg text for subject 'PQ' (American Literature) and
# then write this dataset to disk in .csv format
get_gutenberg_subject(subject = "PQ", target_file = "../data/original/gutenberg/works_pq.csv")
```

Applying this function to both the English and American Literature datasets, our data directory structure now looks like this:

```bash
data
├── derived
└── original
    ├── gutenberg
    │   ├── works_pq.csv
    │   └── works_pr.csv
    ├── sbc
    │   ├── meta-data
    │   └── transcriptions
    └── scs
        ├── README
        ├── discourse
        ├── disfluency
        ├── documentation
        ├── tagged
        ├── timed-transcript
        └── transcript
```



### Authentication


[rtweet](https://CRAN.R-project.org/package=rtweet) [@rtweet-package]


<!-- Consider:

- rtweet package for getting tweet data (Corona virus?)

-->

In sum, this subsection provided an overview to acquiring data from web service APIs through R packages. We took at closer look at the `gutenbergr` package which provides programmatic access to works available on Project Gutenberg and the `rtweet` package which provides authenticated access to Twitter. Working with package interfaces requires more knowledge of R including loading/ installing packages, working with vectors and data frames, and exporting data from an R session. We touched on these programming concepts and also outlined a method to create a reproducible workflow. 

## Web scraping

There are many resources available through manula and direct downloads from repositories and individual sites and R package interfaces to web resources with APIs, but these resources are relatively limited to the amount of public-facing textual data recorded on the web. In the case that you want to acquire data from webpages, R can be used to access the web programmatically through a process known as web scraping. The complexity of web scrapes can vary but in general it requires more advanced knowledge of R as well as the structure of the language of the web: HTML (Hypertext Markup Language).

### A toy example

HTML is a cousin of XML (eXtensible Markup Language) and as such organizes web documents in a hierarchical format that is read by your browser as you navigate the web. Take for example the toy webpage I created as a demonstration in Figure \@ref(fig:ad-example-webpage).

<div class="figure" style="text-align: center">
<img src="images/06-acquire-data/example-webpage.png" alt="Example web page." width="90%" />
<p class="caption">(\#fig:ad-example-webpage)Example web page.</p>
</div>

The file accessed by my browser to render this webpage is `test.html` and in plain-text format looks like this:



```

<html>
  <head>
    <title>My website</title>
  </head>
  <body>
    <div class="intro">
      <p>Welcome!</p>
      <p>This is my first website. </p>
    </div>
    <table>
      <tr>
        <td>Contact me:</td>
        <td>
          <a href="mailto:francojc@wfu.edu">francojc@wfu.edu</a>
        </td>
      </tr>
    </table>
    <div class="conc">
      <p>Good-bye!</p>
    </div>
  </body>
</html>
```


Each element in this file is delineated by an opening and closing tag, `<head></head>`. Tags are nested within other tags to create the structural hierarchy. Tags can take class and id labels to distinguish them from other tags and often contain other attributes that dictate how the tag is to behave when rendered visually by a browser. For example, there are two `<div>` tags in our toy example: one has the label `class = "intro"` and the other `class = "conc"`. `<div>` tags are often used to separate sections of a webpage that may require special visual formatting. The `<a>` tag, on the other hand, creates a web link. As part of this tag's function, it requires the attribute `href=` and a web protocol --in this case it is a link to an email address `mailto:francojc@wfu.edu`. More often than not, however, the `href=` contains a URL (Uniform Resource Locator). A working example might look like this: `<a href="https://francojc.github.io/">My homepage</a>`.

The aim of a web scrape is to download the HTML file, parse the document structure, and extract the elements containing the relevant information we wish to capture. Let's attempt to extract some information from our toy example. To do this we will need the [rvest](https://CRAN.R-project.org/package=rvest)[@R-rvest] package. First, install/load the package, then, read and parse the HTML from the character vector named `web_file` assigning the result to `html`.


```r
pacman::p_load(rvest)  # install/ load `rvest`

html <- read_html(web_file)  # read raw html and parse to xml
html
#> {html_document}
#> <html>
#> [1] <head>\n<meta http-equiv="Content-Type" content="text/html; charset=UTF-8 ...
#> [2] <body>\n    <div class="intro">\n      <p>Welcome!</p>\n      <p>This is  ...
```

`read_html()` parses the raw HTML into an object of class `xml_document`. The summary output above shows that tags the HTML structure have been parsed into 'elements'. The tag elements can be accessed by using the `html_elements()` function by specifying the tag to isolate.


```r
html %>%
    html_elements("div")
#> {xml_nodeset (2)}
#> [1] <div class="intro">\n      <p>Welcome!</p>\n      <p>This is my first web ...
#> [2] <div class="conc">\n      <p>Good-bye!</p>\n    </div>
```

Notice that `html_elements("div")` has returned both `div` tags. To isolate one of tags by its class, we add the class name to the tag separating it with a `.`. 


```r
html %>%
    html_elements("div.intro")
#> {xml_nodeset (1)}
#> [1] <div class="intro">\n      <p>Welcome!</p>\n      <p>This is my first web ...
```

Great. Now say we want to drill down and isolate the subordinate `<p>` nodes. We can add `p` to our node filter.


```r
html %>%
    html_elements("div.intro p")
#> {xml_nodeset (2)}
#> [1] <p>Welcome!</p>
#> [2] <p>This is my first website. </p>
```

To extract the text contained within a node we use the `html_text()` function.


```r
html %>%
    html_elements("div.intro p") %>%
    html_text()
#> [1] "Welcome!"                   "This is my first website. "
```

The result is a character vector with two elements corresponding to the text contained in each `<p>` tag. If you were paying close attention you might have noticed that the second element in our vector includes extra whitespace after the period. To trim leading and trailing whitespace from text we can add the `trim = TRUE` argument to `html_text()`.


```r
html %>%
    html_elements("div.intro p") %>%
    html_text(trim = TRUE)
#> [1] "Welcome!"                  "This is my first website."
```

From here we would then work to organize the text into a format we want to store it in and write the results to disk. Let's leave writing data to disk for later in the chapter. For now keep our focus on working with `rvest` to acquire data from html documents working with a more practical example.

### A practical example

<!-- update: change website to scrape -->
<!-- remember to remove `eval = FALSE` from code chunks to run -->

With some basic understanding of HTML and how to use the `rvest` package, let's turn to a realistic example. Say we want to acquire lyrics from the online music website and database [last.fm](https://www.last.fm/). The first step in any web scrape is to investigate the site and page(s) we want to scrape to ascertain if there any licensing restrictions. Many, but not all websites, will include a plain text file [`robots.txt`](https://www.cloudflare.com/learning/bots/what-is-robots.txt/) at the root of the main URL. This file is declares which webpages a 'robot' (including web scraping scripts) can and cannot access. We can use the `robotstxt` package to find out which URLs are accessible ^[It is important to check the paths of sub-domains as some website allow access in some areas and not in others].

<!-- change domain -->


```r
pacman::p_load(robotstxt)  # load/ install `robotstxt`

paths_allowed(paths = "https://www.last.fm/")  # check permissions
#> [1] TRUE
```

<!-- screenshot of page to scrape -->

The next step includes identifying the URL we want to target and exploring the structure of the HTML document. Take the following webpage I have identified, seen in Figure \@ref(fig:ad-example-lyrics-page-lastfm). 

<div class="figure" style="text-align: center">
<img src="images/06-acquire-data/ad-lastfm-webpage-lyrics.png" alt="Lyrics page from last.fm" width="90%" />
<p class="caption">(\#fig:ad-example-lyrics-page-lastfm)Lyrics page from last.fm</p>
</div>

As in our toy example, first we want to feed the HTML web address to the `read_html()` function to parse the tags into elements. We will then assign the result to `html`.

<!-- rvest::read_html() -->



<!-- show code, but don't evaluate -->


```r
# read and parse html as an xml object
lyrics_url <- "https://www.last.fm/music/Radiohead/_/Karma+Police/+lyrics"
html <- read_html(lyrics_url)  # read raw html and parse to xml
html
```

<!-- show html object -->


```
#> {html_document}
#> <html lang="en" class="
#>         no-js
#>         playbar-masthead-release-shim
#>         youtube-provider-not-ready
#>     ">
#> [1] <head>\n<meta http-equiv="Content-Type" content="text/html; charset=UTF-8 ...
#> [2] <body>\n<div id="initial-tealium-data" data-require="tracking/tealium-uta ...
```


At this point we have captured and parsed the raw HTML assigning it to the object named `html`. The next step is to identify the html elements that contain the information we want to extract from the page. To do this it is helpful to use a browser to inspect specific elements of the webpage. Your browser will be equipped with a command that you can enable by hovering your mouse over the element of the page you want to target and using a right click to select "Inspect" (Chrome) or "Inspect Element" (Safari, Brave). This will split your browser window vertical or horizontally showing you the raw HTML underlying the webpage.

<div class="figure" style="text-align: center">
<img src="images/06-acquire-data/ad-lastfm-artist-inspect.png" alt="Using the &quot;Inspect Element&quot; command to explore raw html." width="90%" />
<p class="caption">(\#fig:ad-inspect-element-artist-lastfm)Using the "Inspect Element" command to explore raw html.</p>
</div>

<!-- change class/ tag/ attribute appropriately -->

From Figure \@ref(fig:ad-inspect-element-lyrics-lastfm) we see that the element we want to target is contained within an `<a></a>` tag. Now this tag is common and we don't want to extract every `a` so we use the class `header-new-crumb` to specify we only want the artist name. Using the convention described in our toy example, we can isolate the artist of the lyrics page.

<!-- change class/ tag/ attribute appropriately -->


```r
html %>%
    html_element("a.header-new-crumb")
#> {html_node}
#> <a class="header-new-crumb" itemprop="url" href="/music/Radiohead">
#> [1] <span itemprop="name">Radiohead</span>
```

We can then extract the text with `html_text()`.


```r
artist <- html %>%
    html_element("a.header-new-crumb") %>%
    html_text()
artist
#> [1] "Radiohead"
```

Let's extract the song title in the same way. 

<!-- change class/ tag/ attribute appropriately -->


```r
song <- html %>%
    html_element("h1.header-new-title") %>%
    html_text()
song
#> [1] "Karma Police"
```

Now if we inspect the HTML of the lyrics page, we will notice that the lyrics are contained in `<p></p>` tags with the class `lyrics-paragraph`. 

<div class="figure" style="text-align: center">
<img src="images/06-acquire-data/ad-lastfm-lyrics-inspect.png" alt="Using the &quot;Inspect Element&quot; command to explore raw html." width="90%" />
<p class="caption">(\#fig:ad-inspect-element-lyrics-lastfm)Using the "Inspect Element" command to explore raw html.</p>
</div>


Since there are multiple elements that we want to extract, we will need to use the `html_elements()` function instead of the `html_element()` which only targets one element.


```r
lyrics <- html %>%
    html_elements("p.lyrics-paragraph") %>%
    html_text()
lyrics
#> [1] "Karma policeArrest this manHe talks in mathsHe buzzes like a fridgeHe's like a detuned radio"      
#> [2] "Karma policeArrest this girlHer Hitler hairdoIs making me feel illAnd we have crashed her party"   
#> [3] "This is what you'll getThis is what you'll getThis is what you'll getWhen you mess with us"        
#> [4] "Karma policeI've given all I canIt's not enoughI've given all I canBut we're still on the payroll" 
#> [5] "This is what you'll getThis is what you'll getThis is what you'll getWhen you mess with us"        
#> [6] "For a minute thereI lost myself, I lost myselfPhew, for a minute thereI lost myself, I lost myself"
#> [7] "For a minute thereI lost myself, I lost myselfPhew, for a minute thereI lost myself, I lost myself"
```


At this point, we have isolated and extracted the artist, song, and lyrics from the webpage. Each of these elements are stored in character vectors in our R session. To complete our task we need to write this data to disk as plain text. With an eye towards a tidy dataset, an ideal format to store the data is in a CSV file where each column corresponds to one of the elements from our scrape and each row an observation. A CSV file is a tabular format and so before we can write the data to disk let's coerce the data that we have into tabular format. We will use the `tibble()` function here to streamline our data frame creation. ^[`tibble` objects are `data.frame` objects with some added extra bells and whistles that we won't get into here.] Feeding each of the vectors `artist`, `song`, and `lyrics` as arguments to `tibble()` creates the tabular format we are looking for.


```r
tibble(artist, song, lyrics) %>%
    glimpse()
#> Rows: 7
#> Columns: 3
#> $ artist <chr> "Radiohead", "Radiohead", "Radiohead", "Radiohead", "Radiohead"…
#> $ song   <chr> "Karma Police", "Karma Police", "Karma Police", "Karma Police",…
#> $ lyrics <chr> "Karma policeArrest this manHe talks in mathsHe buzzes like a f…
```

Notice that there are seven rows in this data frame, one corresponding to each paragraph in `lyrics`. R has a bias towards working with vectors of the same length. As such each of the other vectors (`artist`, and `song`) are replicated, or recycled, until they are the same length as the longest vector `lyrics`, which a length of seven. 

For good documentation let's add our object `lyrics_url` to the data frame, which contains the actual web link to this page, and assign the result to `song_lyrics`.


```r
song_lyrics <- tibble(artist, song, lyrics, lyrics_url)
```

The final step is to write this data to disk. To do this we will use the `write_csv()` function. 

<!-- adjust target file -->


```r
write_csv(x = song_lyrics, path = "../data/original/lyrics.csv")
```

### Scaling up

At this point you may be think, 'Great, I can download data from a single page, but what about downloading multiple pages?' Good question. That's really where the strength of a programming approach takes hold. Extracting information from multiple pages is not fundamentally different than working with a single page. However, it does require more sophisticated understanding of the web and R coding strategies, in particular __iteration__.  

Before we get to iteration, let's first create a couple functions to make it possible to efficiently reuse the code we have developed so far: 

1. the `get_lyrics` function wraps the code for scraping a single lyrics webpage from last.fm. 


```r
get_lyrics <- function(lyrics_url) {
    # Function: Scrape last.fm lyrics page for: artist, song, and lyrics from a
    # provided content link.  Return as a tibble/data.frame

    cat("Scraping song lyrics from:", lyrics_url, "\n")

    pacman::p_load(tidyverse, rvest)  # install/ load package(s)

    url <- url(lyrics_url, "rb")  # open url connection 
    html <- read_html(url)  # read and parse html as an xml object
    close(url)  # close url connection

    artist <- html %>%
        html_element("a.header-new-crumb") %>%
        html_text()

    song <- html %>%
        html_element("h1.header-new-title") %>%
        html_text()

    lyrics <- html %>%
        html_elements("p.lyrics-paragraph") %>%
        html_text()

    cat("...one moment ")

    Sys.sleep(1)  # sleep for 1 second to reduce server load

    song_lyrics <- tibble(artist, song, lyrics, lyrics_url)

    cat("... done! \n")

    return(song_lyrics)
}
```

\BeginKnitrBlock{rmdtip}<div class="rmdtip">The `get_lyrics` function includes all of the code developed previously, but also includes: (1) output messages (`cat()`), (2) a processing pause (`Sys.sleep()`), and (3) code to manage opening and closing web connections (`url()` and `close()`). 

Points (1) and (2) will be useful when we iterate over this function to provide status messages and to reduce server load when processing multiple webpages from a web domain. (3) will be necessary to manage webpages that are non-existent. As we will see, we will generate url link to multiple song lyrics some of which will not be valid. To avoid errors that will stop the processing these steps have been incorporated here.</div>\EndKnitrBlock{rmdtip}

2. the `write_content` writes the webscraped data to our local machine, including functionality to create the necessary directory structure of the target file path we choose.


```r
write_content <- function(content, target_file) {
    # Function: Write the tibble content to disk. Create the directory if it
    # does not already exist.

    pacman::p_load(tidyverse)  # install/ load packages

    target_dir <- dirname(target_file)  # identify target file directory structure
    dir.create(path = target_dir, recursive = TRUE, showWarnings = FALSE)  # create directory
    write_csv(content, target_file)  # write csv file to target location

    cat("Content written to disk!\n")
}
```

With just these two functions, we can take a lyrics URL from last.fm and scrape and write the data to disk like this. 


```r
lyrics_url <- "https://www.last.fm/music/Pixies/_/Where+Is+My+Mind%3F/+lyrics"

lyrics_url %>%
    get_lyrics() %>%
    write_content(target_file = "../data/original/lastfm/lyrics.csv")
```

```bash
data/original/lastfm/
└── lyrics.csv
```

Now we could manually search and copy URLs and run this function pipeline. This would be fine if we had just a few particular URLs that we wanted to scrape. But if we want to, say, scrape a set of lyrics grouped by genre. We would probably want a more programmatic approach. The good news is we can leverage our understanding of webscraping to scrape last.fm to harvest the information needed to create and store links to songs by genre. We can then pass these links to a pipeline, similar to the previous one, to scrape lyrics for many songs and store the results in files grouped by genre.

Last.fm provides a genres page where some of the top genres are listed and can be further explored.  

<div class="figure" style="text-align: center">
<img src="images/06-acquire-data/ad-lastfm-genres.png" alt="Genre page on last.fm" width="90%" />
<p class="caption">(\#fig:ad-genre-page-lastfm)Genre page on last.fm</p>
</div>

Diving into a a particular genre, 'rock' for example, you will get a listing of the top tracks in that genre. 

<div class="figure" style="text-align: center">
<img src="images/06-acquire-data/ad-lastfm-genre-tracks-list.png" alt="Tracks by genre list page on last.fm" width="90%" />
<p class="caption">(\#fig:ad-genre-tracks-list-lastfm)Tracks by genre list page on last.fm</p>
</div>

If we inspect the HTML elements for the track names in Figure \@ref(fig:ad-genre-tracks-list-lastfm), we can see that a relative URL is found for the track. In this case, I have 'Smells Like Teen Spirit' by Nirvana highlighted in the inspector. If we follow this link to the track page and then to the lyrics for the track, you will notice that the relative URL on the track listings page has all the unique information. Only the web domain `https://www.last.fm` and the post-pended `/+lyrics` is missing. 

So with this we can put together a function which gets the track listing for a last.fm genre, scrapes the relative URLs for each of the tracks, and creates a full absolute URL to the lyrics page. 


```r
get_genre_lyrics_urls <- function(last_fm_genre) {
  # Function: Scrapes a given last.fm genre title for top tracks in
  # that genre and then creates links to the lyrics pages for these tracks
  
  cat("Scraping top songs from:", last_fm_genre, "genre: \n")
  
  pacman::p_load(tidyverse, rvest) # install/ load packages
  
  # create web url for the genre listing page
  genre_listing_url <- 
    paste0("https://www.last.fm/tag/", last_fm_genre, "/tracks") 
  
  genre_lyrics_urls <- 
    read_html(genre_listing_url) %>% # read raw html and parse to xml
    html_elements("td.chartlist-name a") %>% # isolate the track elements
    html_attr("href") %>% # extract the href attribute
    paste0("https://www.last.fm", ., "/+lyrics") # join the domain, relative artist path, and the post-pended /+lyrics to create an absolute URL
  
  return(genre_lyrics_urls)
}
```

With this function, all we need is to identify the verbatim way last.fm lists the genres. For Rock, it is `rock` but for Hip Hop, it is `hip+hop`. 




```r
get_genre_lyrics_urls("hip+hop") %>%  # get urls for top hip hop tracks
  head(n = 10) # only display 10 tracks
```


```
#> Scraping top songs from: hip+hop genre:
#>  [1] "https://www.last.fm/music/Juzhin/_/Charlie+Conscience+(feat.+MMAIO)/+lyrics"
#>  [2] "https://www.last.fm/music/Juzhin/_/Railways/+lyrics"                        
#>  [3] "https://www.last.fm/music/Juzhin/_/Coming+Down/+lyrics"                     
#>  [4] "https://www.last.fm/music/Juzhin/_/Tupona/+lyrics"                          
#>  [5] "https://www.last.fm/music/Juzhin/_/Sakhalin/+lyrics"                        
#>  [6] "https://www.last.fm/music/Juzhin/_/3+Simple+Minutes/+lyrics"                
#>  [7] "https://www.last.fm/music/Juzhin/_/Lost+Sense/+lyrics"                      
#>  [8] "https://www.last.fm/music/Juzhin/_/Wonderful/+lyrics"                       
#>  [9] "https://www.last.fm/music/Gina+Moryson/_/Vanilla+Smoothy+(Live)/+lyrics"    
#> [10] "https://www.last.fm/music/Juzhin/_/Flunk-Down+(Juzhin+Remix)/+lyrics"
```

So now we have a method to scrape URLs by genre and list them in a vector. Our approach, then, could be to pass these lyrics URLs to our existing pipeline which downloads the lyrics (`get_lyrics()`) and then writes them to disk (`write_content()`). 


```r
# Note: will not run
get_genre_lyrics_urls("hip+hop") %>% # get lyrics urls for specific genre
  get_lyrics() %>% # scrape lyrics url
  write_content(target_file = "../data/original/lastfm/hip_hop.csv") # write to disk
```

This approach, however, has a couple problems. (1) our `get_lyrics()` function only takes one URL at a time, but the result of `get_genre_lyrics_urls()` will produce many URLs. We will be able to solve this with iteration using the [purrr]() package, specifically the `map()` function which will iteratively map each URL output from `get_genre_lyrics_urls()` to `get_lyrics()` in turn. (2) the output from our iterative application of `get_lyrics()` will produce a tibble for each URL, which then sets up a problem with writing the tibbles to disk with the `write_content()` function. To avoid this we will want to combine the tibbles into one single tibble and then send it to be written to disk. The `bind_rows()` function will do just this. 


```r
# Note: will run, but with occasional errors
get_genre_lyrics_urls("hip+hop") %>% # get lyrics urls for specific genre
  map(get_lyrics) %>%  # scrape lyrics url
  bind_rows() %>% # combine tibbles into one
  write_content(target_file = "../data/original/lastfm/hip_hop.csv") # write to disk
```

This preceding pipeline conceptually will work. However, on my testing, it turns out that some of the URLs that are generated in the `get_genre_lyrics_urls()` do not exist on the site. That is, the song is listed but no lyrics have been added to the song site. This will mean that when the URL is sent to the `get_lyrics()` function, there will be an error when attempting to download and parse the page with `read_html()` which will halt the entire process. To avoid this error, we can wrap the `get_lyrics()` function in a function designed to attempt to download and parse the URL (`tryCatch()`), but if there is an error, it will skip it and move on to the next URL without stopping the processing. This approach is reflected in the `get_lyrics_catch()` function below. 


```r
# Wrap the `get_lyrics()` function with `tryCatch()` to skip URLs that have no
# lyrics

get_lyrics_catch <- function(lyrics_url) {
    tryCatch(get_lyrics(lyrics_url), error = function(e) return(NULL))  # no, URL, return(NULL)/ skip
}
```

Updating the pipeline with the `get_lyrics_catch()` function would look like this:


```r
# Note: will run, but we can do better
get_genre_lyrics_urls("hip+hop") %>% # get lyrics urls for specific genre
  map(get_lyrics_catch) %>%  # scrape lyrics url
  bind_rows() %>% # combine tibbles into one
  write_content(target_file = "../data/original/lastfm/hip_hop.csv") # write to disk
```

This will work, but as we have discussed before one of this goals we have we acquiring data for a reproducible research project is to make sure that we are developing efficient code that will not burden site's server we are scraping from. In this case, we would like to check to see if the data is already downloaded. If not, then the script should run. If so, then the script does not run. Of course this is a perfect use of a conditional statement. To make this a single function we can call, I've wrapped the functions we created for getting lyric URLs from last.fm, scraping the URLs, and writing the results to disk in the `download_lastfm_lyrics()` function below. I also added a line to add a `last_fm_genre` column to the combined tibble to store the name of the genre we scraped (i.e. `mutate(genre = last_fm_genre)`.


```r
download_lastfm_lyrics <- function(last_fm_genre, target_file) {
    # Function: get last.fm lyric urls by genre and write them to disk

    if (!file.exists(target_file)) {

        cat("Downloading data.\n")

        get_genre_lyrics_urls(last_fm_genre) %>%
            map(get_lyrics_catch) %>%
            bind_rows() %>%
            mutate(genre = last_fm_genre) %>%
            write_content(target_file)

    } else {
        cat("Data already downloaded!\n")
    }
}
```

Now we can call this function on any genre on the last.fm site and download the top 50 song lyrics for that genre (provided they all have lyrics pages).


```r
# Scrape lyrics for 'pop'
download_lastfm_lyrics(last_fm_genre = "pop", target_file = "../data/original/lastfm/pop.csv")

# Scrape lyrics for 'rock'
download_lastfm_lyrics(last_fm_genre = "rock", target_file = "../data/original/lastfm/rock.csv")

# Scrape lyrics for 'hip hop'
download_lastfm_lyrics(last_fm_genre = "hip+hop", target_file = "../data/original/lastfm/hip_hop.csv")

# Scrape lyrics for 'metal'
download_lastfm_lyrics(last_fm_genre = "metal", target_file = "../data/original/lastfm/metal.csv")
```

Now we can see that our web scrape data is organized in a similar fashion to the other data we acquired in this chapter.

```bash
data/
├── derived
└── original
    ├── gutenberg
    │   ├── works_pq.csv
    │   └── works_pr.csv
    ├── lastfm
    │   ├── hip_hop.csv
    │   ├── metal.csv
    │   ├── pop.csv
    │   └── rock.csv
    ├── sbc
    │   ├── meta-data
    │   └── transcriptions
    └── scs
        ├── README
        ├── discourse
        ├── disfluency
        ├── tagged
        ├── timed-transcript
        └── transcript
```

Again, it is important to add these custom functions to our `acquire_functions.R` script in the `functions/` directory so we can access them in our scripts more efficiently and make our analysis steps more succinct and legible. 


In this section we covered scraping language data from the web. The rvest package provides a host of functions for downloading and parsing HTML. We first looked at a toy example to get a basic understanding of how HTML works and then moved to applying this knowledge to a practical example. To maintain a reproducible workflow, the code developed in this example was grouped into task-oriented functions which were in turn joined and wrapped into a function that provided convenient access to our workflow and avoided unnecessary downloads (in the case the data already exists on disk).

Here we have built on previously introduced R coding concepts and demonstrated various others. Web scraping often requires more knowledge of and familiarity with R as well as other web technologies. Rest assured, however, practice will increase confidence in your abilities. I encourage you to practice on your own with other websites. You will encounter problems. Consult the R documentation in RStudio or online and lean on the R community on the web at sites such as [Stack Overflow](https://stackoverflow.com/) inter alia.

## Documentation

Components that are standard to include:

- Short description
- Source
- Date
- Structure
  - column number of variables, description
  - row number of observations, description

- There may also be conditions and/ or licensing restrictions that one should heed when using and potentially sharing the data.

Repository and corpus resources:

- download documentation for corpora (web portal?), 

- API and web scraping, create
  - README.Rmd
    - Short description
    - Source
    - Date
    - Structure
      - column number of variables, description
      - row number of observations, description



## Summary {-}


.... 

At this point you have both a bird’s eye view of the data available on the web and strategies on how to access a great majority of it. It is now time to turn to the next step in our data analysis project: data curation. In the next posts I will cover how to wrangle your raw data into a tidy dataset. This will include working with and incorporating meta-data as well as augmenting a dataset with linguistic annotations.

- add data documentation into the summary. 
- modular design, input/ output control
- data/ dataset organization
- ...





