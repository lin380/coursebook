# (PART) Foundations {-}

# Overview {-#foundations-overview}





**FOUNDATIONS**

<!-- edit -->
In this section the aims are to (1) provide an overview of quantitative research and their applications, by both highlighting visible applications and notable research in various fields. (2) We will under the hood a bit and consider how quantitative research contributes to language research. (3) I will layout the main types of research and situate quantitative text analysis inside these. Some attention will be given to the historical background to understand how theory (generative and usage-based grammar) has framed and to some degree continues to frame language research. (4) We will discuss how the programmatic approaches to language, which are fundamental for quantitative text analysis, also provide the opportunity to further science through process documentation and research reproducibility.  

<!-- Learning outcomes/ goals

Include these in the Canvas page for the day

-->

# Data, language, and text analysis

> Science walks forward on two feet, namely theory and experiment...Sometimes it is one foot which is put forward first, sometimes the other, but continuous progress is only made by the use of both.
> ---[Robert A. Millikan](https://www.nobelprize.org/uploads/2018/06/millikan-lecture.pdf) [-@Millikan1923]

<div class="rmdkey">
<p>The essential questions for this chapter are:</p>
<ul>
<li>what is the difference between quantitative and qualitative research?</li>
<li>where does text analysis fit in language research?</li>
<li>what are the benefits of programming approaches to text analysis?</li>
</ul>
</div>

<!-- COURSE STRUCTURE
TUTORIALS:

- Git-it: https://github.com/jlord/git-it-electron (interactive app to learn the basics of Git)

SWIRL:

- Variables and vectors
- Workspace

WORKED/ RECIPE:

- Literate programming
- GitHub collaboration

PROJECT:

- Interest statement, annotated references, goal(s), finding(s)
-->


<!-- CHAPTER OUTLINE



-->


<!-- Goals -->

*EDIT*

In this chapter I will aim to introduce the topic of text analysis and text analytics and frame the approach of this coursebook. The goals of this section are to work from the general field of data science/ data analysis to the particular sub-field of text analysis (where text is defined broadly as corpus). The aim is to introduce the context needed to understand how text analysis fits in a larger universe of data analysis and see the commonalities in the ever-ubiquitous field of data analysis, with attention to how language and linguistics studies employ data analysis down to the particular area of text analysis. To round out this chapter, I will provide a general overview of the rest of the coursebook motivating the general structure and sequencing as well as setting the foundation for programmatic approaches to data analysis.


## Making sense of a complex world

<!-- Making sense of a complex world 

- world of signals; objects, actions, and interactions
- humans strengths (implicit heuristics) and limitations (perspective, limited storage and limited fidelity) in making sense of the world
- the role of science to address human limitations
  - systematic, rigorous data collection and analysis, reporting
  - collective vetting from scientific community
  - repeat

-->

The world around us is full of actions and interactions so numerous that it is difficult to really comprehend. Through the lens each individual sees and experiences this world. We gain knowledge about this world and build up heuristic knowledge about how it works and how we do and can interact with it. This happens regardless of your educational background. As humans we are built for this. Our minds process countless sensory inputs many of which never make it to our conscious mind. They underlie skills and abilities that we take for granted like being able to predict what will happen if you see someone about to knock a wine glass off a table and onto a concrete floor. You've never seen this object before and this is the first time you've been to this winery, but somehow and from somewhere you 'instinctively' make an effort to warn the would-be-glass-breaker before it is too late. You most likely have not stopped to consider where this predictive knowledge has come from, or if you have, you may have just chalked it up to 'common sense'. As common as it may be, it is an incredible display of the brain's capacity to monitor your environment, relate the events and observations that take place, and store that information all the time not making a big fuss to tell you conscious mind what it's up to. 

So wait, this is a coursebook on text analytics and language, right? So what does all this have to do with that? Well, there are two points to make that are relevant for framing our journey: (1) the world is full of countless information which unfold in real-time at a scale that is daunting and (2) for all the power of the brain that works so efficiently behind the scene making sense of the world, we are one individual living one life that has a limited view of the world at large. Let me expand on these two points a little more. 

First let's be clear. There is no way for any one to experience all things at all times, i.e. omnipotence. But even extremely reduced slices of reality are still vastly outside of our experiental capacity, at least in real-time. One can make the point that since the inception of the internet an individual's ability to experience larger slices of the world has increased. But could you imagine reading, watching, and listening to every file that is currently accessible on the web? (or has been see the Wayback Machine)? Scale this back even further; let's take Wikipedia, the world's largest encyclopedia. Can you imagine reading every wiki entry? As large as a resource such as Wikipedia is ^[ADD: size of Wikipedia], it is still a small fragment of the written language that is produced on the web, just the web. Consider that for a moment.

To my second framing point, which is actually two points in one. I made underscored the efficiency of our brain's capacity to make sense of the world. That efficiency comes from some clever evolutionary twists that lead our brain to take in the world but it makes some shortcuts that compress the raw experience into heuristic understanding. What that means is that the brain is not a supercomputer. It does not store every experience in raw form, we do not have access to the records of our experience like we would imagine a computer would have access to the records logged in a database. Where our brains do excel is in making associations and predictions that help us (most of the time) navigate the complex world we inhabit. This point is key --our brains are doing some amazing work, but that work can give us the impression that we understand the world in more detail that we actually do. Let's do a little thought experiment. Close your eyes and think about the last time you saw your best friend. What were they wearing? Can you remember the colors? If your like me, or any other human, you probably will have a pretty confident feeling that you know the answers to these questions and there is a chance you a right. But it has been demonstrated in numerous experiments on human memory that our confidence does not correlate with accuracy. (where were you when ..? JFK, 9/11, ...other example) You've experienced an event, but there is no real reason that we should be our lives on what we experienced. It's a little bit scary, for sure, but the magic is that it works 'good enough' for practical purposes.

So here's the deal: as humans we are (1) clearly unable to experience large swaths of experience by the simple fact that we are individuals living individual lives and (2) the experiences we do live are not recorded with precision and therefore we cannot 'trust' our intuitions, at least in an absolute sense. 

<!-- Role of science in data analysis -->

What does that mean for our human curiosity about the world around us and our ability to reliably make sense of it? In short it means that we need to approach understanding our world with the tools of science. Science is so powerful because it makes strides to overcome our inherit limitations as humans (breadth of our experience and recall and relational abilities) and bring a complex world into a more digestible perspective. Science starts with question, identifies and collects data, careful selected slices of the complex world, submits this data to analysis through clearly defined and reproducible procedures, and reports the results for others to evaluate. This process is repeated, modifying, and manipulating the procedures, asking new questions and positing new explanations, all in an effort to make inroads to bring the complex into tangible view. 

In essence what science does is attempt to subvert our inherent limitations in understanding by drawing on carefully and purposefully collected slices of experience and letting the analysis of this experience speak, even if it goes against our intuitions (those powerful but sometime spurious heuristics that our brains use to make sense of the world). 

## Data analysis

<!-- The science of data 




-->

At this point I've sketched an outline strengths and limitations of humans' ability to make sense of the world and why science to address these limitations. This science I've described is the one you are familiar with and it has been an indespensible tool to make sense of the world. If you are like me, this description of science may be associated with visions of white coats, labs, and petri dishes. While science's foundation still stands strong in the 21st century, a series of intellectual and technological events mid-20th century set in motion changes that have changed aspects about how science is done, not why it is done. We could call this Science 2.0, but let's use the more popularized term "Data Science". The recognized beginnings of Data Science are attributed to work in the "Statistics and Data Analysis Research" department at Bell Labs during the 1960s. Although primarily conceptual and theoretic at the time, a framework for quantitative data analysis took shape that would anticipate what would come: sizable datasets which would "[...]require advanced statistical and computational techniques [...] and the software to implement them." [@Chambers2020] This framework emphasized both the inference-based research of traditional science, but also embraced exploratory research and recognized the need to address practical considerations that would arise when working with and deriving insight from an abundance of data. 

Fast-forward to the 21st century a world in which machine readable data is truly in abundance. With increased computing power and innovative uses of this technology the world wide web took flight. To put this in perspective, focusing in on language, the amount of text [here add stats on amount of data added to the web every day/month/year compared to all the literature from .. to ..?]. The data flood has not been limited to language, there are more sensors and recording devices than ever before which capture evermore swaths of the world we live in. Where increased computing power gave rise to the influx of data, it is also on of the primary methods for gathering, preparing, transforming, analyzing, and communicating insight derived from this data [@Donoho2017]. The vision laid out in the 1960s at Bell Labs had come to fruition. 

The interest in deriving insight from the available data is now almost ubiquitous. The science of data has now reached deep into all aspects of life where making sense of the world is sought. Predicting whether a loan applicant will get a loan [cite], whether a lump is cancerous [cite], what films to recommend based on your previous viewing history [cite], what players a sports team should sign [@Lewis2004] all now incorporate a common set of data analysis tools. 

These advances, however, are not predicated on data alone. As envisioned by researchers at Bell Labs, turning data into insight it takes computing skills (i.e. programming), knowledge of statistics, and, importantly, substantive/ domain expertise. This triad has been popularly represented by Drew Conway in a Venn diagram \@ref(fig:intro-data-science-venn). 

<div class="figure" style="text-align: center">
<img src="images/02-introduction/Data_Science_VD.png" alt="[Venn diagram](http://drewconway.com/zia/2013/3/26/the-data-science-venn-diagram) by Drew Conway" width="70%" />
<p class="caption">(\#fig:intro-data-science-venn)[Venn diagram](http://drewconway.com/zia/2013/3/26/the-data-science-venn-diagram) by Drew Conway</p>
</div>

This same toolbelt underlies well-known public-facing language applications. From the language-capable personal assistant applications, plagarism detection software, machine translation and search, tangible results of quantitative approaches to language are becoming standard fixtures in our lives. 

<!-- Highly visible applications in language -->

<div class="figure" style="text-align: center">
<img src="images/02-introduction/well-known-language-applications.png" alt="Well-known language applications" width="70%" />
<p class="caption">(\#fig:intro-language-applications)Well-known language applications</p>
</div>

The spread of quantitative data analysis too has taken root in academia. Even in areas that on first blush don't appear to be approached in a quantitative manner such as fields in the social sciences and humanities, data science is making important and sometimes disisplinary changes to the way that academic research is conducted. This coursebook focuses in on a domain that cuts across many of these fields; namely language. At this point let's turn to quantitative approaches to language.  


<!-- I want to steer the conversation more towards *the use of science to expand into areas of understanding the world, both in academia and in professional life.* One thought I had today in the gym is to introduce the __Moneyball__ case as an example of how traditional, human-based intuition has it's limitations and how approaching behavior and understanding the underlying mechanisms can be enhanced by scientific approaches. Moneyball is a good first case as it is most likely known by students, but it also is a well-documented case of how traditional wisdom was challenged and loss to rigorous data-driven analysis. -->


<!-- What I need to reconcile is the trajectory of human-based bias, science, and the expanding use of scientific approaches to a wide variety of areas and professions as the availability of data becomes more widespread and computing resources and statistical approaches more robust.  -->

## Language analysis

Language is a defining characteristic of our species. As such, the study of language is of key concern to a wide variety of fields. The goals of various fields, however, and as such approaches to language research vary. Whereas some language research traditions, namely those closely associated with Naom Chomsky, eschewed quantitative approaches to language research during the later half of the 20th century, many language research programs turned to and/or developed quantitative research methods either by necessity or through theoretical principles. For our purposes we will leave this branch aside and instead focus on the primary distinction between approaches to the quantitative study of language. On the one hand, experimental approaches collect data under controlled contexts, usually a lab context, in which participants are recruited to perform a language related task with stimuli that have been carefully curated by researchers to elicit some aspect of language behavior of interest. The resulting data from these intentionally designed experiments are then submitted to relevant statistical analysis and interpreted based on a pre-determined hypothesis *and the results and findings from this process are communicated through peer-reviewed publication.* Experimental approaches to language research are heavily influenced by procedures adapted from psychology. This link is logical as language is a central area of study in cognitive psychology. *This approach looks a much like the white-coat science that we made reference to earlier.*

On the other hand, language data can be collected through observational methods. In this approach, language behavior is collected through indirect methods. That is, that language researchers mine the use of language in naturalistic contexts ...

In both approaches the data analysis toolbelt is applicable and applied. Yet the distinctions in the type of data provide differing angles on language and ultimately conclusions based on language. 


<!-- I want to bring language into focus. Introducing __empirical approaches to language study__. This discussion should highlight the distinction between experimental data and observational data. -->

<!-- I want to contrast the types and trade-offs associated with both approaches. 

Experimental data is controlled rigorously, recruiting participants, controlling the conditions in which language is presented and behavior is measured. 

Observational data, one the other hand, is not controlled to the same degree. The data is collected in a way in which language is performed in more natural contexts. 

Both approaches have advantages and disadvantages. I want to highlight that although this coursebook focuses on observational data, robust understanding of language behavior requires a collaboration between both approaches.  -->


<!-- I occurs to me that I could try to work out tangible examples of *experimental data and observational data*. The first that comes to mind is observational --the Unibomber manifesto was not a controlled experiment. Language was produced and the FBI had the goal of analyzing the language found within to understand and identify the author (authorship attribution).  -->




## Text analysis


<!-- The __Unibomber manifesto__ brings language into the mix and, again, highlights the inability of individuals to readily detect patterns (the signal) found within texts. The aspect I have in mind is the phrase "Have your cake and eat it to" vs. "Eat your cake and have it to". The FBI was able to build a case against Ted Kasinzki base on this phrase tracing this idiomatic variance to a particular usage which had fallen out of popular usage. -->

## Overview of this coursebook




## Annotated readings

### Data analysis

**Lewis, Michael. 2004. Moneyball: The Art of Winning an Unfair Game. WW Norton & Company.** [@Lewis2004]

This is the story of the Oakland A's baseball team and the use of data analytics to maximize the use of their salary cap to acquire the most useful players based on metrics that were overlooked previously.

It is a story in how applied data science can uncover patterns that tend to be overlooked or are not visible without a scientific inquiry and the use of practical data science to find patterns. (p. 50)

**Chambers, J. M. (2020). S, R, and data science. Proceedings of the ACM on Programming Languages, 4(HOPL), 1–17. https://doi.org/10.1145/3386334** [@Chambers2020]


A definition of Data Science: "Data science consists of techniques and their application to derive and communicate scientifically valid inferences and predictions based on relevant data." (p. 2)

"Data analysis as practiced at Bell Labs is recognized as the precursor of what would now be described as 'data science'". (p. 1)

Work at Bell Labs consisted of what now is considered typical practices in data science "large datasets; iterative, probing analysis including visualization; problems of practical importance and, as a result, challenging computations. Data analysis that was useful and applicable to sizable datasets required advanced computational techniques for the time and good software to implement them."

That is, the practice required advanced statistical and computational techniques --these are the characteristics that distinguish 'data science' and other forms of traditional scientific research. 


```r
knitr::include_graphics("images/02-introduction/ngram-viewer-data.png")
```

<div class="figure" style="text-align: center">
<img src="images/02-introduction/ngram-viewer-data.png" alt="Google Ngram Viewer" width="100%" />
<p class="caption">(\#fig:ngram-viewer-data)Google Ngram Viewer</p>
</div>

Data science, and related terms, are in large part applied statistics. But there is much more that falls under the umbrella which falls outside of what one would consider statistics proper (see @Donoho2017).


**Donoho, D. (2017). 50 Years of Data Science. Journal of Computational and Graphical Statistics, 26(4), 745–766. https://doi.org/10.1080/10618600.2017.1384734** [@Donoho2017]

The author suggests what is coined "Data Science" is really six sub-divisions: 

1. Data Gathering, Preparation, and Exploration 
2. Data Representation and Transformation
3. Computing with Data
4. Data Modeling
5. Data Visualization and Presentation 
6. Science about Data Science

**Gupta, A. (2020, August 19). Data, Information, Knowledge, and Insights. https://www.linkedin.com/pulse/data-information-knowledge-insights-achin-gupta** [@Gupta2020]


```r
knitr::include_graphics("images/02-introduction/dikw-conspiracy.jpg")
```

<img src="images/02-introduction/dikw-conspiracy.jpg" width="70%" style="display: block; margin: auto;" />
**Chen, M., Ebert, D., Hagen, H., Laramee, R. S., Van Liere, R., Ma, K.-L., Ribarsky, W., Scheuermann, G., & Silver, D. (2008). Data, information, and knowledge in visualization. IEEE Computer Graphics and Applications, 29(1), 12–19.** [@Chen2008]

> __Data__: a representation of facts, concepts, or instructions in a formalized manner suitable for communication, interpretation, or processing by human beings or by automatic means.

> __Information__: the meaning that is currently assigned [by human beings or computers] to data by means of the conventions applied to those data. 

> __Knowledge__: understanding, awareness, or familiarity acquired through education or experience. Anything that has been learned, perceived, discovered, inferred, or understood.

"Despite the lack of an agreeable set of the definitions of data, information, and knowledge, a consensus exists that data isn't information and that information isn't knowledge."

**Ackoff, R. L. (1989). From data to wisdom. Journal of Applied Systems Analysis, 16(1), 3–9.** [@Ackoff1989]

- Data are symbols that represent the properties of objects and events. 
- Information consists of processed data, the processing directed at increasing its usefulness. 
- Knowledge is conveyed by instructions, answers to how-to questions.
- Understanding (Insight) is conveyed by explanations, answers to why questions.

From all this I infer that although we are able to develop computerized information-, knowledge-, and understanding-generating systems, we will never be able to generate wisdom by such systems. It may well be that wisdom—which is essential for the pursuit of ideals or ultimately valued ends—is the characteristic that differentiates man from machines. 

**Rowley, J. (2007). The wisdom hierarchy: Representations of the DIKW hierarchy. Journal of Information Science, 33(2), 163–180. https://doi.org/10.1177/0165551506070706** [@Rowley2007]


```r
knitr::include_graphics("images/02-introduction/Rowley-dikw.png")
```

<div class="figure" style="text-align: center">
<img src="images/02-introduction/Rowley-dikw.png" alt="The wisdom hierarchy, Rowley(2007)" width="70%" />
<p class="caption">(\#fig:dikw-rowley)The wisdom hierarchy, Rowley(2007)</p>
</div>


### Language analysis

**Levshina, N. (2015). How to do linguistics with R: Data exploration and statistical analysis. John Benjamins Publishing Company.** [@Levshina2015]

Chapter 2 "The quantitative turn in Linguistics" 

- Notes the gain in popularity of quantitative language research. Usage-based approaches, Cognitive Linguistics, Variationist approaches, etc. 

- Stresses the importance of using multivariate methods for studying and understanding the complexities of language.

- Also makes point that multiple kinds of evidence are key to understanding language behavior. 

### Text analysis


### Goals and organization

__Goals__

- Data Literacy (DL) - ability to interpret, assess, and contextualize findings based on data
- Information Literacy (IL) - ability to locate, evaluate, and use effectively the needed information
- Statistical Literacy (SL) - ability to use statistics as evidence in arguments
- Research Skills (RS) - ability to conduct original research, communicate findings, and make meaningful connections with the field
- Programming Skills (PS) - ability to implement research skills in a replicable form

__Why__

- ...


__What__

- Data to Insight

My modified DIKW to DIKI:


```r
knitr::include_graphics("images/02-introduction/diki-hierarchy.png")
```

<img src="images/02-introduction/diki-hierarchy.png" width="70%" style="display: block; margin: auto;" />

NOTE: I would modify Insight to "Contributions" and "Connections". I leave off wisdom as it is the last extension which deals with "effectiveness" and ultimately is judgment-level knowledge.


- Research blueprint

- Preparation

- Modeling

__How__

- Programming






