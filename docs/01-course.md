# Course {-}





<p style="font-weight:bold; color:red;">INCOMPLETE DRAFT</p>

> The journey of a thousand miles begins with one step.
>
> --- [Lao Tzu](https://en.wikipedia.org/wiki/Laozi)

<div class="rmdkey">
<p>The essential questions for this chapter are:</p>
<ul>
<li>…</li>
</ul>
</div>

<!-- TUTORIALS:

- Setting up R and RStudio: https://lin380.github.io/tadr/tutorials/00-setup.html

-->

<!-- SWIRL:

- Intro to swirl

-->

<!-- WORKED/ RECIPE:

- None

-->


<!-- PROJECT:

- None

-->



This chapter aims to provide a brief summary of current research trends that form the context for the rationale for this textbook. It also provides instructors and students an overview of the purpose and approach of the textbook. It will also include a description of the main components of each section and chapter and provide a guide to conventions used in the book and resources available. 

## Rationale

In recent years there has been a growing buzz around the term 'Data Science' and related terms; data analytics, data mining, *etc*. In a nutshell data science is the process by which an investigator leverages statistical methods and computational power to uncover insight from large datasets. Driven in large part by the increase in computing power available to the average individual and the increasing amount of electronic data that is now available through the internet, interest in data science has expanded to virtually all fields in academia and areas in the public sector. Data scientists are in high demand and this trend is expected to continue into the foreseeable future.

This coursebook is an introduction to the fundamental concepts and practical programming skills from Data Science that are increasingly employed in a variety of language-centered fields and sub-fields. It is geared towards advanced undergraduates and graduate students of linguistics and related fields. As quantitative research skills are quickly becoming a core aspect of many language programs, this coursebook aims to provide a fundamental understanding of theoretical concepts, programming skills, and statistical methods for doing quantitative text analysis. 

## Learning goals

This course you will:

__Data Literacy (DL):__ learn to interpret, assess, and contextualize findings based on data.

1. ability to understand and apply data analysis to derive insight from data
2. ability to understand and apply data knowledge and skills across linguistic and language-related disciplines

__Research Skills (RS):__  learn to conduct original research (design, implementation, interpretation, and communication). 

1. identify an applicable area of investigation in a linguistic or language-related field
2. develop a viable research question or hypothesis
3. assess, acquire, and document data
4. curate and transform data for analysis
5. select and apply relevant analysis method
6. interpret and communicate findings

__Programming Skills (PS):__ learn to produce your own research and work collaboratively with others.

1. demonstrate proficiency to implement research with R (RD points 3-5)
2. demonstrate ability to produce collaborative and reproducible research using R, RStudio, and GitHub

In each chapter of this coursebook specific learning objectives will be specified that target these learning outcomes so it is clear what we are doing and why were are doing it. 

## Approach

Many textbooks on doing 'Data Science', even those that have a domain-centric approach, such as text analysis, tend to focus on the basic 'tidy' approach, seen in Figure \@ref(fig:tidy-workflow-img) from @Wickham2017.  However these resources tend to underrepresent the importance of  leading with a research question. A big part, or perhaps the biggest part of doing quantitative research, and research in general is what is the question to be addressed. Then comes how to orient the research approach to best address this question (or questions). Then we move on to matching data sources, organizing data, modeling data, and finally reporting findings.

<div class="figure" style="text-align: center">
<img src="images/01-course/standard-tidy-approach.png" alt="Workflow diagram from R for Data Science." width="90%" />
<p class="caption">(\#fig:tidy-workflow-img)Workflow diagram from R for Data Science.</p>
</div>


I think a central advantage to this coursebook for language researchers is to thread the project goals from a conceptual point of view without technical implementation in mind first.

Then, after a general idea about what the data should look like, how it should be analyzed, and how the analysis will contribute to knowledge in the field, we can move towards implementing these preliminary formulations in R code. In essence this approach reflects [the classic separation between content and format](https://en.wikipedia.org/wiki/Separation_of_content_and_presentation) –the content of our research should precede the format it should or will take.

This coursebook is divided into four parts:

1. In "Foundations", an environmental survey of quantitative research across disciplines and orient language-based research is provided. (Provide historical and research context for quantitative text analysis)
2. "Orientation" aims to build your knowledge about what data is, how text is organized into datasets, what role statistics play in quantitative research and the types of statistical approaches that are commonly found in text analysis research, and finally how to develop a research question and a research blueprint for conducting a quantitative text analysis research project. (Develop an understanding of what quantitative research is and how it is approached)
3. "Preparation" covers a variety of implementation approaches for each stage for deriving a dataset ready for statistical analysis which includes acquiring, curating, and transforming data. (Dive into coding practices produce data ready for statistical analysis)
4. "Modeling" elaborates various statistical approaches for data analysis and contextualizes their application in for types of research questions. (Conducting statistical text analysis)

## Prerequisites {#prerequisites}

**TODOS:**

Change this subsection:

- Move the R, RStudio, Packages, Git, GitHub to the `tadr` package vignettes/ articles
- Make reference here to the `tadr` package (Coursebook support package)
- 


Before we continue, make sure you have all the software you need for this book:

- **R**: ...

- **RStudio**: RStudio is a free and open source integrated development environment (IDE) for R. ...

- **R packages**: This coursebook uses a bunch of R packages.
    You can install them all at once by running:

    

    
    ```r
    install.packages(c("bookdown"))
    ```

- Coursebook support package
  [`tadr`](https://lin380.github.io/tadr/) is a support R package and resource site for this coursebook. The package includes data, functions, and interactive R programming tutorials which make use of the `swirl` package. The website includes programming demonstrations called 'Worked' examples and reference to documentation and other resources for doing quantitative research with R.


```r
install.packages("devtools")
devtools::install_github("lin380/tadr")
```

## Programming

Reasons to program:

- *Flexibility* Graphical User Interface (GUI) based software is inherently limited. What you see is what you get. If you have another need, you need to find a tool. If another tool does not implement what you think you need, you are out of luck.
- *Transparency* By taking a programming approach to research analysis you make your decisions explicit and leave a breadcrumb trail to everything you do.
- *Reproducibility* What you do will be clearer to you but also allow you to share the process with others (including your future self!). Insight grows much faster when exposed to light. Sharing your research with collaborators or on sites such as GitHub or BitBucket brings makes your work visible and accessible to the world. Reproducibility is gaining momentum and is fueled by programmatic approaches to research.

Reasons to use R:

- *One stop shopping* Once known specifically as a statistical programming language, R can now be a round trip tool to acquire, curate, transform, visualize, *and* statistically analyze data. It also allows for robust communication in reports and data and analysis sharing (reproducibility).
- *You are not alone* There is a sizable R programming community, especially in academics. This has two tangible benefits; first, you will likely be able to find user contributed R packages that will satisfy many of the more sophisticated programming goals you will have and second, you will be able to get answers to any of your programming questions on popular sites like StackOverflow.
- *RStudio* RStudio is the envy of many other programmers. It is a very capable interface to R and provides convenient access powerful tools to allow you to be a more efficient and productive R programmer.

<!-- NOTES: 

https://francojc.github.io/2017/08/14/getting-started-with-r-and-rstudio/

-->


## Conventions

This coursebook is about the concepts for understanding and the techniques for doing quantitative text analysis with R. Therefore there will be an intermingling of prose and code presented. As such, an attempt to establish consistent conventions throughout the text has been made to signal reader's attention as appropriate. As we explore concepts, R code itself will be incorporated into the text. This may be a unique textbook compared to others you have seen. It has been created using R itself --specifically using an R language package called `bookdown` [@R-bookdown]. This R package makes it possible to write, execute ('run'), and display code and results within the text. 

For example, the following text block shows actual R code and the results that are generated when running this code. Note that the hashtag `#` signals a **code comment**. The code follows within the same text block and a subsequent text block displays the output of the code.


```r
# Add 1 plus 1
1 + 1
#> [1] 2
```

Inline code will be used when code blocks are short and the results are not needed for display. For example, the same code as above will sometimes appear as `1 + 1`. 

When necessary meta-description of code will appear. This is particularly relevant for R Markdown documents. 

````clike
```{r test-code}
1 + 1
```
````

In terms of prose, key concepts will be signaled using **_bold italics_**. Terms that appear in this typeface will also appear in the [glossary] at the end of the text. Furthermore, there are four pose text blocks that will be used to signal the reader's attention: *key points*, *notes*, *tips*, *questions*, and *warnings*.  

Key points summarize the main points to be covered in a chapter or a subsection of the text.

<div class="rmdkey">
<p>In this chapter you will learn:</p>
<ul>
<li>the goals of this textbook</li>
<li>the reasoning for using the R programming language</li>
<li>important text conventions employed in this textbook</li>
</ul>
</div>

Notes provide a bit more information on the topic or where to find more information.

<div class="rmdnote">
<p>R is more than a powerful statistical programming language, it also can be used to perform all the necessary steps in a data science project; including reporting. A relatively new addition to the reporting capabilities of R is the <code>bookdown</code> package (this textbook was created using this very package). You can find out more <a href="https://bookdown.org/">here</a>.</p>
</div>

Tips are used to signal helpful hints that might otherwise be overlooked.

<div class="rmdtip">
<p>During a the course of an exploratory work session, many R objects are often created to test ideas. At some point inspecting the workspace becomes difficult due to the number of objects displayed using <code>ls()</code>.</p>
<p>To remove all objects from the workspace, use <code>rm(list = ls())</code>.</p>
</div>

From time to time there will be points for you to consider and questions to explore. 

<div class="rmdquestion">
<p>Consider the objectives in this course: what ways can the knowledge and skills you will learn benefit you in your academic studies and/ or professional and personal life?</p>
</div>

Errors will be an inevitable part of learning, but some errors can be avoided. The text will used the warning text block to highlight typical pitfalls and errors.

<div class="rmdwarning">
<p>Hello world!<br />
This is a warning.</p>
</div>

Although this is not intended to be a in-depth introduction to statistical techniques, mathematical formulas will be included in the text. These formulas will appear either inline $1 + 1 = 2$ or as block equations.

\begin{equation}
  \hat{c} = \underset{c \in C} {\mathrm{argmax}} ~\hat{P}(c) \prod_i \hat{P}(w_i|c)
  (\#eq:example-formula)
\end{equation}

Data analysis leans heavily on graphical representations. Figures will appear numbered, as in Figure \@ref(fig:test-fig). 


```r
library(ggplot2) # load graphics package
ggplot(mtcars, aes(x = hp, y = mpg)) + # map 'hp' and 'mpg' to coordinate space
  geom_point() + # add points
  geom_smooth(method = "lm") + # draw linear trend line
  labs(x = "Horsepower", # label x axis
       y = "Miles per gallon", # label y axis
       title = "Test plot", # add title
       subtitle = "From mtcars dataset") # add subtitle
```

<div class="figure" style="text-align: center">
<img src="01-course_files/figure-html/test-fig-1.png" alt="Test plot from mtcars dataset" width="90%" />
<p class="caption">(\#fig:test-fig)Test plot from mtcars dataset</p>
</div>

Tables, such as Table \@ref(tab:test-tab) will be numbered separately from figures. 


```r
knitr::kable(head(iris, 20), caption = "Here is a nice table!", booktabs = TRUE)
```



Table: (\#tab:test-tab)Here is a nice table!

| Sepal.Length| Sepal.Width| Petal.Length| Petal.Width|Species |
|------------:|-----------:|------------:|-----------:|:-------|
|          5.1|         3.5|          1.4|         0.2|setosa  |
|          4.9|         3.0|          1.4|         0.2|setosa  |
|          4.7|         3.2|          1.3|         0.2|setosa  |
|          4.6|         3.1|          1.5|         0.2|setosa  |
|          5.0|         3.6|          1.4|         0.2|setosa  |
|          5.4|         3.9|          1.7|         0.4|setosa  |
|          4.6|         3.4|          1.4|         0.3|setosa  |
|          5.0|         3.4|          1.5|         0.2|setosa  |
|          4.4|         2.9|          1.4|         0.2|setosa  |
|          4.9|         3.1|          1.5|         0.1|setosa  |
|          5.4|         3.7|          1.5|         0.2|setosa  |
|          4.8|         3.4|          1.6|         0.2|setosa  |
|          4.8|         3.0|          1.4|         0.1|setosa  |
|          4.3|         3.0|          1.1|         0.1|setosa  |
|          5.8|         4.0|          1.2|         0.2|setosa  |
|          5.7|         4.4|          1.5|         0.4|setosa  |
|          5.4|         3.9|          1.3|         0.4|setosa  |
|          5.1|         3.5|          1.4|         0.3|setosa  |
|          5.7|         3.8|          1.7|         0.3|setosa  |
|          5.1|         3.8|          1.5|         0.3|setosa  |

## Build information

This coursebook was written in [bookdown](http://bookdown.org/) inside [RStudio](http://www.rstudio.com/ide/). The website is hosted with [GitHub Pages](https://pages.github.com/) and the complete source is available from [GitHub](https://github.com/lin380).

<!-- and automatically updated after every commit by [Travis-CI](https://travis-ci.org).  -->


This version of the coursebook was built with R version 4.0.2 (2020-06-22) and the following packages:


|package  |version |source         |
|:--------|:-------|:--------------|
|bookdown |0.22    |CRAN (R 4.0.2) |



