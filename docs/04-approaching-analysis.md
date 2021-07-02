# Approaching analysis





<p style="font-weight:bold; color:red;">INCOMPLETE DRAFT</p>

> Lies, damn lies, and statistics  
> ---Benjamin Disraeli, popularized by Mark Twain

<div class="rmdkey">
<p>The essential questions for this chapter are:</p>
<ul>
<li>What is the role of statistics in data analysis?</li>
<li>What is the importance of descriptive statistics in data analysis?</li>
<li>What are the main goals of the three statistical approaches to data analysis?</li>
</ul>
</div>

<!-- TUTORIALS:

- Primers: 
  - Primers: Data Visualization Basics: https://rstudio.cloud/learn/primers/1.1
  - Exploratory Data Analysis: https://rstudio.cloud/learn/primers/3.1

SWIRL:

- Packages and Functions (for more complex usage of R)
- The Grammar of Graphics (to visualize descriptive characteristics which are difficult to interpret in tabular or other, formats)

WORKED/ RECIPE:

- Descriptive stats: Visualizing datasets in tabular and graphical form (univariate, bivariate, multivariate)
- Descriptive stats: 
- Analytic stats: 
- Reporting: 

PROJECT:

- Annotated references, goal(s), finding(s), statistical approach (EDA, IDA, or PDA), test or algorithm, and type of results (interpretative, accuracy, inference)

-->




In this chapter I will build on the notions of data and information from the previous chapter. The aim of statistics in quantitative analysis is to uncover patterns in datasets. Thus statistics is aimed at deriving knowledge from information, the next step in the DIKI Hierarchy (Figure \@ref(fig:understanding-data-vis-sum)). Where the creation of information from data involves human intervention and conscious decisions, as we have seen, deriving knowledge from information involves even more conscious subjective decisions on how to assess and interrogate the information available and ultimately how to interpret the findings. The first step is to conduct a descriptive assessment of the information, both at the individual variable level and also between variables, the second is to interrogate the dataset either through exploratory, inferential, or predictive methods, and the third is to interpret and report the findings.

<!--
- ? include that I will provide examples of statistical methods and procedures that are associated with each of these main statistical approaches.
- ? include/ stress the importance of visualization in both descriptive and analytic approaches
- ? introduce/ define the concept of *modeling* and models in this chapter
  - an explicit and concise description of the structured patterns in the data [@Lantz2013]
- ...
-->

## Descriptive statistics

Descriptive statistics include a set of diagnostic measures and tabular and visual summaries which provide researchers a better understanding of the structure of a dataset, prepare the researcher to make decisions about which statistical methods and/ or tests are most appropriate, and to safeguard against false assumptions (missing data, data distributions, etc.). In this section we will first cover the importance of understanding the informational value that variables can represent and then move to use this understanding to approach summarizing individual variables and relationships between variables. 

To ground this discussion I will introduce a new dataset. This dataset is drawn from the [Barcelona English Language Corpus (BELC)](https://slabank.talkbank.org/access/English/BELC.html), which is found in the [TalkBank repository](http://talkbank.org/). I've selected the "Written composition" task from this corpus which contains writing samples from second language learners of English at different ages. Participants were given the task of writing for 15 minutes on the topic of "Me: my past, present and future". Data was collected for many (but not all) participants up to four times over the course of seven years. In Table \@ref(tab:belc-overview) I've included the first 10 observations from the dataset which reflects structural and transformational steps I've done so we start with a tidy dataset. 



<table>
<caption>(\#tab:belc-overview)First 10 observations of the BELC dataset for demonstration.</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> participant_id </th>
   <th style="text-align:left;"> age_group </th>
   <th style="text-align:left;"> sex </th>
   <th style="text-align:right;"> num_tokens </th>
   <th style="text-align:right;"> num_types </th>
   <th style="text-align:right;"> ttr </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> L02 </td>
   <td style="text-align:left;"> 10-year-olds </td>
   <td style="text-align:left;"> female </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 1.000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> L05 </td>
   <td style="text-align:left;"> 10-year-olds </td>
   <td style="text-align:left;"> female </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 0.833 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> L10 </td>
   <td style="text-align:left;"> 10-year-olds </td>
   <td style="text-align:left;"> female </td>
   <td style="text-align:right;"> 36 </td>
   <td style="text-align:right;"> 26 </td>
   <td style="text-align:right;"> 0.722 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> L11 </td>
   <td style="text-align:left;"> 10-year-olds </td>
   <td style="text-align:left;"> female </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 0.800 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> L12 </td>
   <td style="text-align:left;"> 10-year-olds </td>
   <td style="text-align:left;"> female </td>
   <td style="text-align:right;"> 41 </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 0.561 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> L16 </td>
   <td style="text-align:left;"> 10-year-olds </td>
   <td style="text-align:left;"> female </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 0.923 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> L22 </td>
   <td style="text-align:left;"> 10-year-olds </td>
   <td style="text-align:left;"> female </td>
   <td style="text-align:right;"> 47 </td>
   <td style="text-align:right;"> 30 </td>
   <td style="text-align:right;"> 0.638 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> L27 </td>
   <td style="text-align:left;"> 10-year-olds </td>
   <td style="text-align:left;"> female </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 1.000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> L28 </td>
   <td style="text-align:left;"> 10-year-olds </td>
   <td style="text-align:left;"> female </td>
   <td style="text-align:right;"> 84 </td>
   <td style="text-align:right;"> 34 </td>
   <td style="text-align:right;"> 0.405 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> L29 </td>
   <td style="text-align:left;"> 10-year-olds </td>
   <td style="text-align:left;"> female </td>
   <td style="text-align:right;"> 53 </td>
   <td style="text-align:right;"> 34 </td>
   <td style="text-align:right;"> 0.642 </td>
  </tr>
</tbody>
</table>

The entire dataset includes 79 observations from 36 participants. Each observation in the BELC dataset corresponds to an individual learner's composition. It includes which participant wrote the composition (`participant_id`), the age group they were part of at the time (`age_group`), their sex (`sex`), and the number of English words they produced (`num_tokens`), the number of unique English words they produced (`num_types`). The final variable (`ttr`) is the calculated ratio of number of unique words (`num_types`) to total words (`num_tokens`) for each composition. This is known as the Type-Token Ratio and it is a standard metric for measuring lexical diversity. 

### Information values

Understanding the informational value, or __level of measurement__, of a variable or set of variables in key to preparing for analysis as it has implications for what visualization techniques and statistical measures we can use to interrogate the dataset. There are two main levels of measurement a variable can take: categorical and continuous. __Categorical variables__ reflect class or group values. __Continuous variables__ reflect values that are measured along a continuum. 

The BELC dataset contains three categorical variables (`participant_id`, `age_group`, and `sex`) and three continuous variables (`num_tokens`, `num_types`, and `ttr`). The categorical variables identify class or group membership; which participant wrote the composition, what age group they were in, and their biological sex. The continuous variables measure attributes that can take a range of values without a fixed limit and the differences between each value are regular. The number of words and number of unique words for each composition can range from 1 to $n$ and the Type-Token Ratio being derived from these two variables is also continuous for the same reason. Furthermore, the differences between the each of values of these measures is on a defined interval, so for example a composition which has a word count (`num_tokens`) of 40 is exactly two times as large as a composition with a word count of 20.

The distinction between categorical an continuous levels of measurement, as mentioned above, are the main two and for some statistical approaches the only distinction that needs to be made to conduct an analysis. However, categorical and continuous can each be broken down into subcategories and for some descriptive and analytic purposes these distinctions are important. For categorical variables a distinction can be made between variables in which there is a structured relationship between the values and those in which there is not. _Nominal variables_ contain values which are labels denoting the membership in a class in which there is no relationship between the labels. _Ordinal variables_ also contain labels of classes, but in contrast to nominal variables, there is a relationship between the classes, namely one in which there is a precedence relationship or order. With this in mind, our categorical variables be sub-classified. There is no order between the values of `participant_id` and `sex` and they are therefore nominal whereas the values of `age_group` are ordered, each value refers to a sequential age group, and therefore it is ordinal.

Turning to continuous variables, another subdivision can be made which hinges on the existence of a non-arbitrary zero or not. _Interval variables_ contain values in which the difference between the values is regular and defined, but the measure has an arbitrary zero value. A typically cited example of an interval variable is temperature measurements on the Fahrenheit scale. A value of 0 on this scale does not mean there is 0 temperature. _Ratio variables_ have all the properties of interval variables but also include a non-arbitrary definition of zero. All of the continuous variables in the BELC dataset (`num_tokens`, `num_types`, and `ttr`) are ratio variables as a value of 0 would indicate the lack of this attribute. 

An hierarchical overview of the relationship between the two main and four sub-types of levels of measurement appear in Figure \@ref(fig:info-values-graphic).

<div class="figure" style="text-align: center">
<img src="images/04-approaching-analysis/Informational-values.png" alt="Levels of measurement graphic representation." width="90%" />
<p class="caption">(\#fig:info-values-graphic)Levels of measurement graphic representation.</p>
</div>

A few notes of practical importance; First, the distinction between interval and ratio variables is often not applicable in text analysis and therefore often treated together as continuous variables. Second, the distinction between ordinal and interval/continuous variables is not as clear cut as it may seem. Both variables contain values which have an ordered relationship. By definition the values of an ordinal variable do not reflect regular intervals between the units of measurement. But in practice interval/continuous variables with a defined number of values (say from a Likert scale used on a survey) may be treated as an ordinal variable as they may be better understood as reflecting class membership. Third, all continuous variables can be converted to categorical variables, but the reverse is not true. We could, for example, define a criterion for binning the word counts in `num_tokens` for each composition into ordered classes such as "low", "mid", "high". On the other hand, `sex` (as it has been measured here) cannot take intermediate values on a unfixed range. The upshot is that variables can be down-typed but not up-typed. In most cases it is preferred to treat continuous variables as such, if the nature of the variable permits it, as the down-typing of continuous data to categorical data results in a loss of information --which will result in a loss of information and hence statistical power which may lead to results that obscure meaningful patterns in the data [@Baayen2004]. 

<!--

As we established, an observation is a set of measurements associated with a unit of observation. The unit of observation establishes the basis for determining the informational value of each of the associated variables. 

In the BELC dataset the unit of observation was learner compositions and therefore each variable characterized this unit. So, for example, the word count (`num_tokens`) for each composition reflected a measurement along a continuum and as such it's level of measurement was continuous. However, if the unit of observation were different, say we were looking at specific language constructions, instead of compositions, then the words in those texts may potentially take on a different level of measurement. 

To illustrate this point, let's look at another dataset: the Datives dataset. This dataset is drawn from both the Switchboard Corpus and Wall Street Journal Corpus and was compiled by (cite) to investigate what is known as the Dative Alternation. 


<table>
<caption>(\#tab:datives-overview)First 10 observations of the Datives dataset for demonstration.</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> RealizationOfRec </th>
   <th style="text-align:left;"> Verb </th>
   <th style="text-align:left;"> AnimacyOfRec </th>
   <th style="text-align:left;"> AnimacyOfTheme </th>
   <th style="text-align:right;"> LengthOfTheme </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> NP </td>
   <td style="text-align:left;"> feed </td>
   <td style="text-align:left;"> animate </td>
   <td style="text-align:left;"> inanimate </td>
   <td style="text-align:right;"> 2.639 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> NP </td>
   <td style="text-align:left;"> give </td>
   <td style="text-align:left;"> animate </td>
   <td style="text-align:left;"> inanimate </td>
   <td style="text-align:right;"> 1.099 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> NP </td>
   <td style="text-align:left;"> give </td>
   <td style="text-align:left;"> animate </td>
   <td style="text-align:left;"> inanimate </td>
   <td style="text-align:right;"> 2.565 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> NP </td>
   <td style="text-align:left;"> give </td>
   <td style="text-align:left;"> animate </td>
   <td style="text-align:left;"> inanimate </td>
   <td style="text-align:right;"> 1.609 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> NP </td>
   <td style="text-align:left;"> offer </td>
   <td style="text-align:left;"> animate </td>
   <td style="text-align:left;"> inanimate </td>
   <td style="text-align:right;"> 1.099 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> NP </td>
   <td style="text-align:left;"> give </td>
   <td style="text-align:left;"> animate </td>
   <td style="text-align:left;"> inanimate </td>
   <td style="text-align:right;"> 1.386 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> NP </td>
   <td style="text-align:left;"> pay </td>
   <td style="text-align:left;"> animate </td>
   <td style="text-align:left;"> inanimate </td>
   <td style="text-align:right;"> 1.386 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> NP </td>
   <td style="text-align:left;"> bring </td>
   <td style="text-align:left;"> animate </td>
   <td style="text-align:left;"> inanimate </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> NP </td>
   <td style="text-align:left;"> teach </td>
   <td style="text-align:left;"> animate </td>
   <td style="text-align:left;"> inanimate </td>
   <td style="text-align:right;"> 2.398 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> NP </td>
   <td style="text-align:left;"> give </td>
   <td style="text-align:left;"> animate </td>
   <td style="text-align:left;"> inanimate </td>
   <td style="text-align:right;"> 0.693 </td>
  </tr>
</tbody>
</table>

-->

### Summaries

It is always key to gain insight into shape of the information through numeric, tabular and/ or visual summaries before jumping in to analytic statistical approaches. The most appropriate form of summarizing information will depend on the number and informational value(s) of our target variables. To get a sense of how this looks, let’s continue to work with the BELC dataset and pose different questions to the data with an eye towards seeing how various combinations of variables are descriptively explored.

#### Single variables

<!-- Exploring: single variables (univariate) -->

The way to statistically summarize a variable into a single measure is to derive a __measure of central tendency__. For a continuous variable the most common measure is the (arithmetic) _mean_, or avergage, which is simply the sum of all the values divided by the number of values. As a measure of central tendency, however, the mean can be less-than-reliable as it is sensitive to outliers which is to say that data points in the variable that are extreme relative to the overall distribution of the other values in the variable affect the value of the mean depending on how extreme the deviate. One way to assess the effects of outliers is to calculate a __measure of dispersion__. The most common of these is the _standard deviation_ which estimates the average amount of variability between the values in a continuous variable. Another way to assess, or rather side-step, outliers is to calculate another measure of central tendency, the _median_. A median is calculated by sorting all the values in the variable and then selecting the value which falls in the middle of all the other values. A median is less sensitive to outliers as extreme values (if there are few) only indirectly affect the selection of the middle value. Another measure of dispersion is to calculate quantiles. A _quantile_ slices the data in four percentile ranges providing a five value numeric summary of the spread of the values in a continuous variable. The spread between the first and third quantile is known as the Interquartile Range (IQR) and is also used as a single statistic to summarize variability between values in a continuous variable.

Below is a list of central tendency and dispersion scores for the continuous variables in the BELC dataset.


**Variable type: numeric**

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> skim_variable </th>
   <th style="text-align:right;"> n_missing </th>
   <th style="text-align:right;"> complete_rate </th>
   <th style="text-align:right;"> mean </th>
   <th style="text-align:right;"> sd </th>
   <th style="text-align:right;"> p0 </th>
   <th style="text-align:right;"> p25 </th>
   <th style="text-align:right;"> p50 </th>
   <th style="text-align:right;"> p75 </th>
   <th style="text-align:right;"> p100 </th>
   <th style="text-align:right;"> iqr </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> num_tokens </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 66.23 </td>
   <td style="text-align:right;"> 43.90 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 29.00 </td>
   <td style="text-align:right;"> 55.00 </td>
   <td style="text-align:right;"> 90.00 </td>
   <td style="text-align:right;"> 185 </td>
   <td style="text-align:right;"> 61.00 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> num_types </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 40.25 </td>
   <td style="text-align:right;"> 22.80 </td>
   <td style="text-align:right;"> 1.00 </td>
   <td style="text-align:right;"> 22.00 </td>
   <td style="text-align:right;"> 38.00 </td>
   <td style="text-align:right;"> 54.00 </td>
   <td style="text-align:right;"> 97 </td>
   <td style="text-align:right;"> 32.00 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ttr </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.67 </td>
   <td style="text-align:right;"> 0.13 </td>
   <td style="text-align:right;"> 0.41 </td>
   <td style="text-align:right;"> 0.57 </td>
   <td style="text-align:right;"> 0.64 </td>
   <td style="text-align:right;"> 0.73 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.16 </td>
  </tr>
</tbody>
</table>

<div class="rmdtip">
<p>The descriptive statistics returned above were generated by the <code>skimr</code> package.</p>
</div>

In the above summary, we see the mean, standard deviation (sd), and the quantiles (the five-number summary, p0, p25, p50, p75, and p100). The middle quantile (p50) is the median and the IQR is listed last. 

These are important measures for assessing the central tendency and dispersion and will be useful for reporting purposes, but to get a better feel of how a variable is distributed, nothing beats a visual summary.  A boxplot graphically summarizes many of these metrics. In Figure \@ref(fig:summaries-boxplots-belc) we see the same three continuous variables, but now in graphical form.

<div class="figure" style="text-align: center">
<img src="04-approaching-analysis_files/figure-html/summaries-boxplots-belc-1.png" alt="Boxplots for each of the continuous variables in the BELC dataset." width="90%" />
<p class="caption">(\#fig:summaries-boxplots-belc)Boxplots for each of the continuous variables in the BELC dataset.</p>
</div>

In a boxplot, the bold line is the median. The surrounding box around the median is the interquantile range. The extending lines above and below the IQR mark the largest and lowest value that is within 1.5 times either the 3rd (top of the box) or 1st (bottom of the box). Any values that fall outside, above or below, the extending lines are considered statistical outliers and are marked as dots (in this case red dots). ^[Note that each of these three variables are to be considered separately here (vertically). Later we will see the use of boxplots to compare a continuous variable across levels of a categorical variable (horizontally).]

Boxplots provide a robust and visually intuitive way of assessing central tendency and variability in a continuous variable but this type of plot can be complemented by looking at the overall distribution of the values in terms of their frequencies. A histogram provides a visualization of the frequency (and density in this case with the blue overlay) of the values across a continuous variable binned at regular intervals. 

In Figure \@ref(fig:summaries-histograms-belc) I've plotted histograms in the top row and density plots in the bottom row for the same three continuous variables from the BELC dataset.

<div class="figure" style="text-align: center">
<img src="04-approaching-analysis_files/figure-html/summaries-histograms-belc-1.png" alt="Histograms and density plots for the continuous variables in the BELC dataset." width="90%" />
<p class="caption">(\#fig:summaries-histograms-belc)Histograms and density plots for the continuous variables in the BELC dataset.</p>
</div>

Histograms provide insight into the distribution of the data. For our three continuous variables, the distributions happen not to be too strikingly distinct. They are, however, not the same either. When we explore continuous variables with histograms we are often trying to assess whether there is skew or not. There are three general types of skew, visualized in Figure \@ref(fig:summaries-skew-graphic) [@Bobbitt2021]. 

<div class="figure" style="text-align: center">
<img src="images/04-approaching-analysis/skew.png" alt="Examples of skew types in density plots." width="100%" />
<p class="caption">(\#fig:summaries-skew-graphic)Examples of skew types in density plots.</p>
</div>

In histograms/ density plots in which the distribution is either left or right, the median and the mean are not aligned. The _mode_, which indicates the most frequent value in the variable is also not aligned with the other two measures. In a left-skewed distribution the mean will be to the left of the median which is left of the mode whereas in a right-skewed distribution the opposite occurs. In a distribution with absolutely no skew these three measures are the same. In practice these measures rarely align perfectly but it is very typical for these three measures to approximate alignment. It is common enough that this distribution is called the Normal Distribution ^[formally known as a Gaussian Distribution] as it is very common in real-world data. 

Another and potentially more informative way to inspect the normality of a distribution is to create Quantile-Quantile plots (QQ Plot). In Figure \@ref(fig:summaries-qqnorm-plot-belc) I've created QQ plots for our three continuous variables. The line in each plot is the normal distribution and the more points that fall off of this line, the less likely that the distribution is normal.

<div class="figure" style="text-align: center">
<img src="04-approaching-analysis_files/figure-html/summaries-qqnorm-plot-belc-1.png" alt="QQ Plots for the continuous variables in the BELC dataset." width="90%" />
<p class="caption">(\#fig:summaries-qqnorm-plot-belc)QQ Plots for the continuous variables in the BELC dataset.</p>
</div>

A visual inspection can often be enough to detect non-normality, but in cases which visually approximate the normal distribution (such as these) we can perform the Shapiro-Wilk test of normality. This is an inferential test that compares a variable's distribution to the normal distribution. The likelihood that the distribution differs from the normal distribution is reflected in a $p$-value. A $p$-value below the .05 threshold suggests the distribution is non-normal. In Table \@ref(tab:summaries-normality-test-belc) we see that given this criterion only the distribution of `num_types` is normally distributed.

<table>
<caption>(\#tab:summaries-normality-test-belc)Results from Shapiro-Wilk test of normality for continuous variables in the BELC dataset.</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> variable </th>
   <th style="text-align:right;"> statistic </th>
   <th style="text-align:right;"> p_value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Number of tokens </td>
   <td style="text-align:right;"> 0.942 </td>
   <td style="text-align:right;"> 0.001 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Number of types </td>
   <td style="text-align:right;"> 0.970 </td>
   <td style="text-align:right;"> 0.058 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Type-Token Ratio </td>
   <td style="text-align:right;"> 0.947 </td>
   <td style="text-align:right;"> 0.003 </td>
  </tr>
</tbody>
</table>

Downstream in the analytic analysis, the distribution of continuous variables will need to be taken into account for certain statistical tests. Tests that assume 'normality' are parametric tests, those that do not are non-parametric. Distributions which approximate the normal distribution can sometimes be transformed to conform to the normal distribution either by outlier trimming or through statistical procedures (i.e. square root, log, or inverse transformation), if necessary. At this stage, however, the most important thing is to recognize whether the distributions approximate or wildly diverge from the normal distribution.

Before we leave continuous variables, let's consider another approach for visually summarizing a single continuous variable. The Empirical Cumulative Distribution Frequency, or _ECDF_, is a summary of the cumulative proportion of each of the values of a continuous variable. An ECDF plot can be useful in determining what proportion of the values fall above or below a certain percentage of the data.

In Figure \@ref(fig:summarize-ecdf-belc) we see ECDF plots for our three continuous variables.

<div class="figure" style="text-align: center">
<img src="04-approaching-analysis_files/figure-html/summarize-ecdf-belc-1.png" alt="ECDF plots for the continuous variables in the BELC dataset." width="90%" />
<p class="caption">(\#fig:summarize-ecdf-belc)ECDF plots for the continuous variables in the BELC dataset.</p>
</div>

Take, for example, the number of tokens (`num_tokens`) per composition. The ECDF plot tells us that 50% of the values in this variable are 56 words or less. In the three variables plotted, the cumulative growth is quite steady. In some cases it is not. When it is not, an ECDF goes a long way to provide us a glimpse into key bends in the proportions of values in a variable.

Now let's turn to descriptive statistics for categorical variables. For categorical variables, central tendency can be calculated as well but only a subset of measures given the reduced informational value of categorical variables. For nominal variables where there is no relationship between the levels the central tendency is simply the mode. The levels of ordinal variables, however, are relational and therefore the median, in addition to the mode, can also be used as a measure of central tendency. Note that a variable with one mode is unimodal, two modes, bimmodal, and in variables that have two or more modes multimodal.

<div class="rmdwarning">
<p>To get numeric value of the median for an ordinal variable the levels of the variable will need to be numeric as well. Non-numeric levels can be recoded to numeric for this purpose if necessary.</p>
</div>

Below is a list of the central tendency metrics for the categorical variables in the BELC dataset.


**Variable type: factor**

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> skim_variable </th>
   <th style="text-align:right;"> n_missing </th>
   <th style="text-align:right;"> complete_rate </th>
   <th style="text-align:left;"> ordered </th>
   <th style="text-align:right;"> n_unique </th>
   <th style="text-align:left;"> top_counts </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> participant_id </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:right;"> 36 </td>
   <td style="text-align:left;"> L05: 3, L10: 3, L11: 3, L12: 3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> age_group </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> 10-: 24, 16-: 24, 12-: 16, 17-: 15 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> sex </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> fem: 48, mal: 31 </td>
  </tr>
</tbody>
</table>

In practice when a categorical variable has few levels it is common to simply summarize the counts of each level in a table to get an overview of the variable. With ordinal variables with more numerous levels, the five-score summary (quantiles) can be useful to summarize the distribution. In contrast to continuous variables where a graphical representation is very helpful to get perspective on the shape of the distribution of the values, the exploration of single categorical variables is rarely enhanced by plots.

#### Multiple variables

In addition to the single variable summaries (univariate), it is very useful to understand how two (bivariate) or more variables (multivariate) are related to add to our understanding of the shape of the relationships in the dataset. Just as with univariate summaries, the informational values of the variables frame our approach. 

To explore the relationship between two continuous variables we can statistically summarize a relationship with a __coefficient of correlation__ which is a measure of __effect size__ between continuous variables. If the continuous variables approximate the normal distribution _Pearson's r_ is used, if not _Kendall's tau_ is the appropriate measure. A correlation coefficient ranges from -1 to 1 where 0 is no correlation and -1 or 1 is perfect correlation (either negative or positive). Let's assess the correlation coefficient for the variables `num_tokens` and `ttr`. Since these variables are not normally distributed, we use Kendall's tau. Using this measure the correlation coefficient is $-0.563$ suggesting there is a correlation, but not a particularly strong one. 

Correlation measures are important for reporting but to really appreciate a relationship it is best to graphically represent the variables in a _scatterplot_. In Figure \@ref(fig:summaries-bivariate-scatterplot-belc) we see the relationship between `num_tokens` and `ttr`.

<div class="figure" style="text-align: center">
<img src="04-approaching-analysis_files/figure-html/summaries-bivariate-scatterplot-belc-1.png" alt="Scatterplot..." width="90%" />
<p class="caption">(\#fig:summaries-bivariate-scatterplot-belc)Scatterplot...</p>
</div>

In both plots `ttr` is on the y-axis and `num_tokens` on the x-axis. The points correspond to the intersection between each of these variables for a single observation. In the left pane only the points are represented. Visually (and given the correlation coefficient) we can see that there is a negative relationship between the number of tokens and the Type-Token ratio: in other words, the more tokens a composition has the lower the Type-Token Ratio. In this case this trend is quite apparent, but in other cases is may not be. To provide an additional visual cue a trend line is often added to a scatterplot. In the right pane I've added a linear trend line. This line demarcates the optimal central tendency across the relationship, assuming a linear relationship. The steeper the line, or slope, the more likely the correlation is strong. The band, or ribbon, around this trend line indicates the __confidence interval__ which means that real central tendency could fall anywhere within this space. The wider the ribbon, the larger the variation between the observations. In this case we see that the ribbon widens when the number of tokens is either low or high. This means that the trend line could be potentially be drawn either steeper (more strongly correlated) or flatter (less strongly correlated). 

<div class="rmdtip">
<p>In plots comparing two or more variables, the choice of which variable to plot on the x- and y-axis is contingent on the research question and/ or the statistical approach. The language varies between statistical approaches: in inferential methods the x-axis is used to plot what is known as the dependent variable and the y-axis an independent variable. In predictive methods the dependent variable is known as the outcome and the independent variable a predictor. Exploratory methods do not draw distinctions between variables along these lines so the choice between which variable to plot along the x- and y-axis is often arbitrary.</p>
</div>

Let's add another variable to the mix, in this case the categorical variable `sex`, taking our bivariate exploration to a multivariate exploration. Again each point corresponds to an observation where the values for `num_tokens` and `ttr` intersect. But now each of these points is given a color that reflects which level of `sex` it is associated with.  

<div class="figure" style="text-align: center">
<img src="04-approaching-analysis_files/figure-html/summaries-multivariate-scatterplot-belc-1.png" alt="Scatterplot visualizing the relationship between `num_tokens` and `ttr`." width="90%" />
<p class="caption">(\#fig:summaries-multivariate-scatterplot-belc)Scatterplot visualizing the relationship between `num_tokens` and `ttr`.</p>
</div>

In this multivariate case, the scatterplot without the trend line is more difficult to interpret. The trend lines for the levels of `sex` help visually understand the variation of the relationship of `num_tokens`and `ttr` much better. But it is important to note that when there are multiple trend lines there is more than one slope to evaluate. The correlation coefficient can be calculated for each level of `sex` (i.e. 'male' and 'female') independently but the relationship between the each slope can be visually inspected and provide important information regarding each level's relative distribution. If the trend lines are parallel (ignoring the ribbons for the moment), as it appears in this case, this suggests that the relationship between the continuous variables is stable across the levels of the categorical variable, with males showing more lexical diversity than females declining at a similar rate. If the lines were to cross, or suggest that they would cross at some point, then there would be a potentially important difference between the levels of the categorical variable (known as an interaction). Now let's consider the meaning of the ribbons. Since the ribbons reflect the range in which the real trend line could fall, and these ribbons overlap, the differences between the levels of our categorical variable are likely not distinct. So at a descriptive level, this visual summary would suggest that there are no differences between the relationship between `num_tokens` and `ttr` for the distinct levels of `sex`.

Characterizing the relationship between two continuous variables, as we have seen is either performed through a correlation coefficient metric or visually. The approach for summarizing a bivariate relationship which combines a continuous and categorical variable is distinct. Since a categorical variable is by definition a class-oriented variable, a descriptive analysis can include a tabular representation, with some type of summary statistic. For example, if we consider the relationship between `num_tokens` and `age_group` we can calculate the mean for `num_tokens` for each level of `age_group`. To provide a metric of dispersion we can include either the standard error of the mean (SEM) and/ or the confidence interval (CI). 

In Table \@ref(tab:summarize-bivariate-cont-cat-table) we see each of these summary statistics.

<table>
<caption>(\#tab:summarize-bivariate-cont-cat-table)Summary table for `tokens` by `age_group`.</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> age_group </th>
   <th style="text-align:right;"> mean_num_tokens </th>
   <th style="text-align:right;"> sem </th>
   <th style="text-align:right;"> ci </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 10-year-olds </td>
   <td style="text-align:right;"> 27.8 </td>
   <td style="text-align:right;"> 3.69 </td>
   <td style="text-align:right;"> 6.07 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 12-year-olds </td>
   <td style="text-align:right;"> 57.4 </td>
   <td style="text-align:right;"> 7.12 </td>
   <td style="text-align:right;"> 11.71 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 16-year-olds </td>
   <td style="text-align:right;"> 81.7 </td>
   <td style="text-align:right;"> 6.15 </td>
   <td style="text-align:right;"> 10.11 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 17-year-olds </td>
   <td style="text-align:right;"> 112.4 </td>
   <td style="text-align:right;"> 12.98 </td>
   <td style="text-align:right;"> 21.35 </td>
  </tr>
</tbody>
</table>

The SEM is a metric which summarizes variation based on the number of values and the CI, as we have seen, summarizes the potential range of in which the mean may fall given a likelihood criterion (usually the same as the $p$-value, .05). 

Because we are assessing a categorical variable in combination with a continuous variable a table is an available visual summary. But as I have said before, a graphic summary is hard to beat. In the following figure (\@ref(fig:summaries-bivariate-barplot-belc)) a barplot is provided which includes the means of `num_tokens` for each level of `age_group`. The overlaid bars represent the confidence interval for each mean score. 
    
<div class="figure" style="text-align: center">
<img src="04-approaching-analysis_files/figure-html/summaries-bivariate-barplot-belc-1.png" alt="Barplot comparing the mean `num_tokens` by `age_group` from the BELC dataset." width="90%" />
<p class="caption">(\#fig:summaries-bivariate-barplot-belc)Barplot comparing the mean `num_tokens` by `age_group` from the BELC dataset.</p>
</div>

When CI ranges overlap, just as with ribbons in scatterplots, the likelihood that the differences between levels are 'real' is diminished. 

To gauge the effect size of this relationship we can use _Spearman's rho_ for rank-based coefficients. The score is 0.708 indicating that the relationship between `age_group` and `num_tokens` is quite strong. ^[To calculate effect sizes for the difference between two means, _Cohen's d_ is used.]

Now, if we want to explore a multivariate relationship and add `sex` to the current descriptive summary, we can create a summary table, but let's jump straight to a barplot. 

<div class="figure" style="text-align: center">
<img src="04-approaching-analysis_files/figure-html/summaries-multivariate-barplot-belc-1.png" alt="Barplot comparing the mean `num_tokens` by `age_group` and `sex` from the BELC dataset." width="90%" />
<p class="caption">(\#fig:summaries-multivariate-barplot-belc)Barplot comparing the mean `num_tokens` by `age_group` and `sex` from the BELC dataset.</p>
</div>

We see in Figure \@ref(fig:summaries-multivariate-barplot-belc) that on the whole, the appears to be general trend towards more tokens in a composition for more advanced learner levels. However, the non-overlap in CI bars for the '12-year-olds' for the levels of `sex` ('male' and 'female') suggest that 12-year-old females may produce more tokens per composition than males --a potential divergence from the overall trend. 

Barplots are a familiar and common visualization for summaries of continuous variables across levels of categorical variables, but a boxplot is another useful visualization of this type of relationship. 
  
<div class="figure" style="text-align: center">
<img src="04-approaching-analysis_files/figure-html/summaries-bivariate-boxplots-belc-1.png" alt="Boxplot of the relationship between `age_group` and `num_tokens` from the BELC dataset." width="90%" />
<p class="caption">(\#fig:summaries-bivariate-boxplots-belc)Boxplot of the relationship between `age_group` and `num_tokens` from the BELC dataset.</p>
</div>

As seen when summarizing single continuous variables, boxplots provide a rich set of information concerning the distribution of a continuous variable. In this case we can visually compare the continuous variable `num_tokens` with the categorical variable `age_group`. The plot in the right pane includes 'notches'. Notches represent the confidence interval, in boxplots this interval surrounds the median. When compared horizontally across levels of a categorical variable the overlap of notched spaces suggest that the true median may be within the same range. 
Additionally, when the confidence interval goes outside the interquantile range (the box) the notches hinge back to the either the 1st (lower) or the 3rd (higher) IQR range and suggests that the variability is high. 

We can also add a third variable to our exploration. As in the barplot in Figure \@ref(fig:summaries-multivariate-barplot-belc), the boxplot in Figure \@ref(fig:summaries-multivariate-boxplots-belc) suggests that there is an overall trend towards more tokens per composition as a learner advances in experience, except at the '12-year-old' level where there appears to be a difference between 'males' and 'females'.

<div class="figure" style="text-align: center">
<img src="04-approaching-analysis_files/figure-html/summaries-multivariate-boxplots-belc-1.png" alt="Boxplot of the relationship between `age_group`, `num_tokens` and `sex` from the BELC dataset." width="90%" />
<p class="caption">(\#fig:summaries-multivariate-boxplots-belc)Boxplot of the relationship between `age_group`, `num_tokens` and `sex` from the BELC dataset.</p>
</div>

Up to this point in our exploration of multiple variables we have always included at least one continuous variable. The central tendency for continuous variables can be summarized in multiple ways (mean, median, and mode) and when calculating means and medians, measures of dispersion are also provide helpful information summarize variability. When working with categorical variables, however, measures of central tendency and dispersion are more limited. For ordinal variables central tendency can be summarized by the median or mode and dispersion can be assessed with an interquantile range. For nominal variables the mode is the only measure of central tendency and dispersion is not applicable. For this reason relationships between categorical variables are typically summarized using __contingency tables__ which provide cross-variable counts for each level of the target categorical variables.

Let's explore the relationship between the categorical variables `sex` and `age_group`. In Table \@ref(tab:summaries-bivariate-categorical-table-belc) we see the contingency table with summary counts and percentages.

<table>
<caption>(\#tab:summaries-bivariate-categorical-table-belc)Contingency table for `age_group` and `sex`.</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> sex/age_group </th>
   <th style="text-align:left;"> 10-year-olds </th>
   <th style="text-align:left;"> 12-year-olds </th>
   <th style="text-align:left;"> 16-year-olds </th>
   <th style="text-align:left;"> 17-year-olds </th>
   <th style="text-align:left;"> Total </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> female </td>
   <td style="text-align:left;"> 58% (14) </td>
   <td style="text-align:left;"> 69% (11) </td>
   <td style="text-align:left;"> 54% (13) </td>
   <td style="text-align:left;"> 67% (10) </td>
   <td style="text-align:left;"> 61% (48) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> male </td>
   <td style="text-align:left;"> 42% (10) </td>
   <td style="text-align:left;"> 31%  (5) </td>
   <td style="text-align:left;"> 46% (11) </td>
   <td style="text-align:left;"> 33%  (5) </td>
   <td style="text-align:left;"> 39% (31) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Total </td>
   <td style="text-align:left;"> 100% (24) </td>
   <td style="text-align:left;"> 100% (16) </td>
   <td style="text-align:left;"> 100% (24) </td>
   <td style="text-align:left;"> 100% (15) </td>
   <td style="text-align:left;"> 100% (79) </td>
  </tr>
</tbody>
</table>

As the size of the contingency table increases, visual inspection becomes more difficult. As we have seen, a graphical summary often proves more helpful to detect patterns.

<div class="figure" style="text-align: center">
<img src="04-approaching-analysis_files/figure-html/summaries-bivariate-categorical-barplot-belc-1.png" alt="Barplot..." width="90%" />
<p class="caption">(\#fig:summaries-bivariate-categorical-barplot-belc)Barplot...</p>
</div>

In Figure \@ref(fig:summaries-bivariate-categorical-barplot-belc) the left pane shows the counts. Counts alone can be tricky to evaluate and adjusting the barplot to account for the proportions of males to females in each group, as shown in the right pane, provides a clearer picture of the relationship. From these barplots we can see there were more females in the study overall and particularly in the 12-year-olds and 17-year-olds groups. To gauge the association strength between `sex` and `age_group` we can calculate _Cramer's V_ which, in spirit, is like our correlation coefficients for the relationship between continuous variables. The Cramer's V score for this relationship is 0.12 which is low, suggesting that there is not a strong association between `sex` and `age_group` --in other words, the relationship is stable.

Let’s look at a more complex case in which we have three categorical variables. Now the dataset, as is, does not have a third categorical variable for us to explore but we can recast the continuous `num_tokens` variable as a categorical variable if we bin the scores into groups. I've binned tokens into three score groups with equal ranges in a new variable called `rank_tokens`.

Adding a second categorical independent variable ups the complexity of our analysis and as a result our visualization strategy will change. Our numerical summary will include individual two-way cross-tabulations for each of the levels for the third variable. In this case it is often best to use the variable with the fewest levels as the third variable, in this case `sex`.

<table>
<caption>(\#tab:summaries-multivariate-categorical-table-belc-female)Contingency table for `age_group`, `rank_tokens`, and `sex` (female).</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> rank_tokens/age_group </th>
   <th style="text-align:left;"> 10-year-olds </th>
   <th style="text-align:left;"> 12-year-olds </th>
   <th style="text-align:left;"> 16-year-olds </th>
   <th style="text-align:left;"> 17-year-olds </th>
   <th style="text-align:left;"> Total </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> low </td>
   <td style="text-align:left;"> 27% (13) </td>
   <td style="text-align:left;"> 10%  (5) </td>
   <td style="text-align:left;"> 4%  (2) </td>
   <td style="text-align:left;"> 6%  (3) </td>
   <td style="text-align:left;"> 48% (23) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> mid </td>
   <td style="text-align:left;"> 2%  (1) </td>
   <td style="text-align:left;"> 13%  (6) </td>
   <td style="text-align:left;"> 21% (10) </td>
   <td style="text-align:left;"> 6%  (3) </td>
   <td style="text-align:left;"> 42% (20) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> high </td>
   <td style="text-align:left;"> 0%  (0) </td>
   <td style="text-align:left;"> 0%  (0) </td>
   <td style="text-align:left;"> 2%  (1) </td>
   <td style="text-align:left;"> 8%  (4) </td>
   <td style="text-align:left;"> 10%  (5) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Total </td>
   <td style="text-align:left;"> 29% (14) </td>
   <td style="text-align:left;"> 23% (11) </td>
   <td style="text-align:left;"> 27% (13) </td>
   <td style="text-align:left;"> 21% (10) </td>
   <td style="text-align:left;"> 100% (48) </td>
  </tr>
</tbody>
</table>

<table>
<caption>(\#tab:summaries-multivariate-categorical-table-belc-male)Contingency table for `age_group`, `rank_tokens`, and `sex` (male).</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> rank_tokens/age_group </th>
   <th style="text-align:left;"> 10-year-olds </th>
   <th style="text-align:left;"> 12-year-olds </th>
   <th style="text-align:left;"> 16-year-olds </th>
   <th style="text-align:left;"> 17-year-olds </th>
   <th style="text-align:left;"> Total </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> low </td>
   <td style="text-align:left;"> 32% (10) </td>
   <td style="text-align:left;"> 13% (4) </td>
   <td style="text-align:left;"> 13%  (4) </td>
   <td style="text-align:left;"> 3% (1) </td>
   <td style="text-align:left;"> 61% (19) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> mid </td>
   <td style="text-align:left;"> 0%  (0) </td>
   <td style="text-align:left;"> 3% (1) </td>
   <td style="text-align:left;"> 23%  (7) </td>
   <td style="text-align:left;"> 6% (2) </td>
   <td style="text-align:left;"> 32% (10) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> high </td>
   <td style="text-align:left;"> 0%  (0) </td>
   <td style="text-align:left;"> 0% (0) </td>
   <td style="text-align:left;"> 0%  (0) </td>
   <td style="text-align:left;"> 6% (2) </td>
   <td style="text-align:left;"> 6%  (2) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Total </td>
   <td style="text-align:left;"> 32% (10) </td>
   <td style="text-align:left;"> 16% (5) </td>
   <td style="text-align:left;"> 35% (11) </td>
   <td style="text-align:left;"> 16% (5) </td>
   <td style="text-align:left;"> 100% (31) </td>
  </tr>
</tbody>
</table>

Contingency tables with this many levels are notoriously difficult to interpret. A plot that is often used for three-way contingency table summaries is a mosaic plot. In Figure \@ref(fig:summaries-multivariate-mosaic-belc) I have created a mosaic plot for the three categorical variables in the previous contingency tables. 

<div class="figure" style="text-align: center">
<img src="04-approaching-analysis_files/figure-html/summaries-multivariate-mosaic-belc-1.png" alt="Mosaic plot for three categorical variables `age_group`, `rank_tokens`, and `sex` in the BELC dataset." width="90%" />
<p class="caption">(\#fig:summaries-multivariate-mosaic-belc)Mosaic plot for three categorical variables `age_group`, `rank_tokens`, and `sex` in the BELC dataset.</p>
</div>
The mosaic plot suggests that the number of tokens per composition increase as the learner age group increases and that females show more tokens earlier. 


<!-- Section summary: -->

In sum, a dataset is information but when the observations become numerous or complex they are visually difficult to inspect and understand at a pattern level. Descriptive statistics are useful to provide the researcher an overview of the variables and (potential) relationships between variables in a dataset. The understanding derived from this exploration will prove useful in analytically approaching the dataset. 


*Consider adding a table with informational level, central tendency measure, dispersion measure, visualization??*

## Analytic statistics

Overview...

Statistical approaches have different aims which can be broken into three categories: exploratory, inferential, or predictive.


<!-- Structure:

- goals
- methods
- results
- reporting/ interpretation

-->

### Exploratory data analysis (EDA)



- Bottom-up approach, hypothesis generating, deriving novel insight from data, discovering patterns

One of two statistical learning approaches, this statistical approach is used to uncover potential relationships in the data and gain new insight in an area where predictions and hypotheses cannot be clearly made. In statistical learning, exploration is a type of **unsupervised learning**. Supervision here, and for Prediction, refers to the presence or absence of an outcome variable. By choosing exploration as our approach we make no assumptions (or hypotheses) about the relationships between any of the particular variables in the data. Rather we aims to investigate the extent to which we can induce meaningful patterns wherever they may lie. 

Findings from exploratory analyses can provide valuable insight for future study but they cannot be safely used to generalize to the larger population, which is why exploratory analyses are often known as hypothesis generating analyses (rather than hypothesis confirming). Given our generalizing power is curtailed, the data *can* be reused multiple times trying out various tests. 

While it is not strictly required, data for exploratory analysis is often partitioned into two sets, training and validation, at roughly an 80\%/20\% split. The training set is used for refining statistical measures and the test set is used to evaluate the refined measures. Although the evaluation results still cannot be used to generalize, the insight can be taken as stronger evidence that there is a potential relationship, or set of relationships, worthy of further study. 

*Although quantitative in nature, exploratory methods involve a high level of human interpretation. Human interpretation is a part of each stage of data analysis, and each statistical approach, in particular, but exploratory methods produce results that require associative thinking and pattern detection which is distinct from the other two statistical approaches, in particular, IDA.*

- ? Include methods, visualizations, examples/ applications/ studies?
  - Keyword analysis
  - Clustering
  - Topic modeling
- Note that these methods are document-level, or in terms of @Egbert2020 "linguistic descriptive" in nature.

### Inferential data analysis (IDA)

- Top-down approach, hypothesis testing, deriving confirmational insight from data

Also commonly known as hypothesis testing or confirmation, statistical inference aims to establish whether there is a reliable and generalizable relationship given patterns in the data. The approach makes the starting assumption that there is no relationship, or that the null hypothesis ($H_0$) is true. A relationship is only reliable, or *significant*, if the chance that the null hypothesis is false is less than some predetermined threshold; in which case we accept the alternative hypothesis ($H_1$). The standard threshold used in the Social Sciences, Linguistic included, is the famous p-value $p < .05$. Without digging into the deeper meaning of a p-value, in a nutshell a p-value is a confidence measure to suggest that the relationship you are investigating is robust and reliable given the data. 

There are two considerations to keep in mind when conducting IDA. First, in this approach all the data is used and is used *only* once. This is not the case for the other two categories fo statistical approaches. For this reason it is vital to identify your statistical approach from the outset of your research project. Second, failing to establish a clear hypothesis and testable hypothesis and then sticking to that hypothesis can lead researchers to engage in "p-hacking"; a practice of running multiple tests and/or parameters on the same data (i.e. reusing the data) until evidence for the alternative hypothesis appears. 

- ? Include methods, visualizations, examples/ applications/ studies?

### Predictive data analysis (PDA)

- Mixed approach, can be used for the generation of hypotheses or to test hypotheses, deriving intelligent action from data, discovering and leveraging patterns

The other statistical learning approach, Prediction, aims to uncover relationships in our data as they pertain to a particular outcome variable. This approach is known as **supervised learning**. Similar to Exploration in many ways, this approach also makes no assumptions about the potential relationships between variables in our data and the data can be used multiple times to refine our statistical tests in order to tease out the most effective method for our goals. Where an exploratory analysis aims to uncover meaningful patterns of any sort, prediction, however, is more focused in that the main aim is to ascertain the extent to which the variables in the data pattern, individually or together, in such a way to make reliable associations to a particular outcome variable in unseen data. To evaluate the robustness of a prediction model the data is partitioned into training and validation sets. Depending on the application and the amount of available data, a third 'development' set is sometimes created as a pseudo test set to facilitate the testing of multiple approaches before the final evaluation. The proportions vary, but it a good rule of thumb is to reserve 60\% of the data for training, 20\% for development, and 20\% for validation.

- ? Include methods, visualizations, examples/ applications/ studies?

- ? overfitting, a model that captures noise in training data obscuring the target pattern that is revealed when the model makes systematic errors on the testing data (new data)

## Reporting

- Descriptive analysis
  - Procedures to diagnose and correct
- Analytic analysis
  - Communicate findings in statistical appropriate forms
    - Depends on the analytic statistic(s) applied





