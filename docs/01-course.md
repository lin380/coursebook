# (PART) Welcome {-}

# Overview {-#course-overview}





**WELCOME**

... overview text

**Learning outcomes**

- PS (2) demonstrate ability to produce collaborative and reproducible research using R, RStudio, and GitHub

**Learning goals**

- ...

# About this coursebook {-}

In recent years there has been a growing buzz around the term 'Data Science' and related terms; data analytics, data mining, *etc*. In a nutshell data science is the process by which an investigator leverages statistical methods and computational power to uncover insight from large datasets. Driven in large part by the increase in computing power available to the average individual and the increasing amount of electronic data that is now available through the internet, interest in data science has expanded to virtually all fields in academia and areas in the public sector. Data scientists are in high demand and this trend is expected to continue into the foreseeable future, which means that undergraduate and post-graduate students will be increasingly seeking out resources and training in the area.

This coursebook is an introduction to the fundamental concepts and practical programming skills from Data Science that are increasingly employed in a variety of language-centered fields and sub-fields. It is geared towards advanced undergraduates and graduate students of linguistics and related fields. As quantitative research skills are quickly becoming a core aspect of many language programs, this coursebook aims to provide a fundamental understanding of theoretical concepts, programming skills, and statistical methods for doing quantitative text analysis. Through these skills we will explore topics and replicate previous research in a variety of areas in language research (psycholinguistics, sociolinguistics, translation studies, *etc.*) using common methods and authentic data sources. 
  
No programming knowledge is assumed, either with R or otherwise. 

## Approach {-}

Many textbooks on doing 'Data Science', even those that have a domain-centric approach, such as text analysis, tend to focus on the basic 'tidy' approach, seen in Figure \@ref(fig:tidy-workflow-img).  to analysis and do not tend to encourage readers to lead with research questions. A big part, or perhaps the biggest part of doing quantitative research, and research in general is what is the question to be addressed. Then comes how to orient the research approach to best address this question (or questions). Then we move on to matching data sources, organizing data, modeling data, and finally reporting findings

<div class="figure" style="text-align: center">
<img src="images/preface-tidy-approach.png" alt="Wickham diagram..." width="70%" />
<p class="caption">(\#fig:tidy-workflow-img)Wickham diagram...</p>
</div>


I think a central advantage to this coursebook for language researchers is to thread the project goals without technical implementation in mind first.

Then, after a general idea about what the data should look like, how it should be analyzed, and how the analysis will contribute to knowledge in the field, we can move towards implementing these preliminary formulations in R code. In a way this is the classic separation between content and format –the content of our research should precede the format it should or will take. 

## Conventions {-}

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

In terms of prose, key concepts will be signaled using **_bold italics_**. Terms that appear in this typeface will also appear in the [glossary] at the end of the text. Furthermore, there are four pose text blocks that will be used to signal the reader's attention: *key points*, *notes*, *tips*, and *warnings*.  

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
<img src="01-course_files/figure-html/test-fig-1.png" alt="Test plot from mtcars dataset" width="70%" />
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

# R and RStudio {-}



# Git and GitHub {-}

[@Bryan2017a]


