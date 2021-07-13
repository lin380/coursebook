# Framing research {#framing-research}





<p style="font-weight:bold; color:red;">INCOMPLETE DRAFT</p>

> It is a capital mistake to theorize before one has data. Insensibly one begins to twist facts to suit theories, instead of theories to suit facts.
>
> ―-- Sir Arthur Conan Doyle, Sherlock Holmes

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

- ...

SWIRL:

- ? Grammar of Graphics II
- ...

WORKED/ RECIPE:

- ...

PROJECT:

- Literature review (LIN 330 description), research statement/ hypothesis, methods blueprint, annotated bibliography

-->



In this chapter ... note to thread this by starting with 'connect' over 'findings', as the contribution guides the process of deriving insight...

Before jumping into the code, every researcher must come to a project with a clear idea about the purpose of the analysis. This means doing your homework in order to understand what it is exactly that you want to achieve; that is, you need to identify a research question. The first step is become versed in the previous literature on the topic. What has been written? What are the main findings? Secondly, it is important to become familiar with the standard methods for approaching the topic of interest. How has the topic been approached methodologically? What are the types, sources, and quality of data employed? What have been the statistical approaches employed? What particular statistical tests have been chosen? Getting an overview not only of the domain-specific findings in the literature but also the methodological choices will help you identify promising plan for carrying out your research.


discuss how to develop a research plan, or what I will call a ‘research blueprint.’ At this point we will directly address Research Skills and elaborate on how research really comes together; how to bring yourself up to speed with the literature on a topic, how to develop a research goal or hypothesis, how to select data which is viable to address the research goal or hypothesis, how to determine the necessary information and appropriate measures to prepare for analysis, how to perform diagnostic statistics on the data and make adjustments before analysis, how to select and perform the relevant analytic statistics given the research goals, how to report your findings, and finally, how to structure your project so that it is well-documented and reproducible.


Build a blueprint: identify an area, determine/ access/ evaluate sources, annotated bibliography, research question

__Characteristics of research: __ [@Cross2006]

+ Purposive: Based on identification of an issue or problem worthy and capable of investigation
+ Inquisitive: Seeking to acquire new knowledge
+ Informed: Conducted from an awareness of previous, related research
+ Methodical: Planned and carried out in a disciplined manner
+ Communicable: Generating and reporting results which are feasible and accessible by others


Here is a reference to the Exercise \@ref(exr:test).

::: {.exercise #test}
This is an exercise
:::


## Connect

### Research area

Area of interest

- _Research area_: the identification of a broad area of interest

Your areas of knowledge and interest

Perceived relevance for theoretical, social, or practical inquiry

### Research problem

Literature review: The main goals of a literature review are to discover, interpret, and evaluate sources of information from the primary literature.

__Purposive and inquisitive__ (Cross)

- _Research problem_: identification of a particular area of uncertainty/ debate in knowledge worthy of study

Viable given the availability of data, technical skills, or time frame

__Sources__

Strategies for finding the relevant literature

Literature review sources:

[WFU Linguistics Research Guide](https://guides.zsr.wfu.edu/linguistics)

- [Linguistics and Language Behavior Abstracts (LLBA)](http://databases.zsr.wfu.edu/?purl=28783)
- [ERIC]()
- [PsycINFO]
- ...

[WFU Digital Humanties Research Guide](https://guides.zsr.wfu.edu/c.php?g=922386&p=6648279)

Journals: 

Organizing references and citations:

- [Zotero](https://www.zotero.org/)
  - [Zotero Guide](https://guides.zsr.wfu.edu/zotero)
  - [zoterobib](https://zbib.org/) quick browser-based citation manager

__Investigation__

Objectives when considering the literature

- Research questions
- Data sources
- Information
- Findings

__Problem statement__

__Informed__ (Cross)

Identify a gap in the literature

- types of gaps
  - topical
  - methodological
  - target population
  - replicability

## Findings

Aim of considering the insight that can be gained ...


### Research aim

_Research aim_: a statement which identifies the analysis approach to be taken. This statement frames the form of the research question

- Explaining
- Evaluating
- Exploring

### Research question

Thesis statement

- _Research question_: a clearly defined statement which identifies an aspect of uncertainty and the particular relationships that this uncertainty concerns
  - _Unit of analysis_: entity of study which the research aims to use to investigate (determined by the research question)
  - _Unit of observation_: component(s) which are collected to derive insight into the topic of study (unit of analysis) (determined by the data collection method). The primary unit of investigation is the essential focus of the informational structure of the dataset.


Will take distinct forms for different research aims: 

- Explaining: hypothesis statement
- Evaluation: prediction goals, potential features
- Exploring: potential insight gained, ...

## Blueprint

Overview of the goals of a research blueprint

### Identify

__Methodical__ (Cross)

Importance of identifying key aspects to conduct the research

__Data__

Aligning data with the target population

__Information__

Aligning/ assessing the viability of the information that can be harnessed

__Analysis__

Identify the appropriate method(s) for conducting the analysis given the information and research aims

Determine the evaluation methods and expectations for the results

### Plan

Overview of the importance of establishing an implementation plan

__Communicable__ (Cross)


> Research design is essentially concerned with the basic architecture of research projects, with designing projects as systems that allow theory, data, and research methods to interface in such a way as to maximize a project’s ability to achieve its goals (see Figure 5.1). Research design involves a sequence of decisions that have to be taken in a project’s early stages, when one oversight or poor decision can lead to results that are ultimately trivial or untrustworthy. Thus, it is critically important to think carefully and systematically about research design before committing time and resources to acquiring texts or mastering software packages or programming languages for your text mining project.

[@Ignatow2017]

<img src="images/05-framing-research/Ignatow2017-research-design.png" width="90%" style="display: block; margin: auto;" />


__Organization__

Directories and files that will serve as the scaffolding for the research project

__Documentation__

- Data dictionaries
- Coding practices
- Reproducibility instructions

__Contingencies__

Considerations for unexpected snags in the research plan

## Summary {-}

- Round-up of the chapter
- Heads-up for the upcoming parts, implementation: preparation and modeling

<!--
## Annotated readings {-}

**Ignatow, G., & Mihalcea, R. (2017). An introduction to text mining: Research design, data collection, and analysis. Sage Publications.** 
[@Ignatow2017]

Chapter 5 "Designing your research project"

> Research design is essentially concerned with the basic architecture of research projects, with designing projects as systems that allow theory, data, and research methods to interface in such a way as to maximize a project’s ability to achieve its goals (see Figure 5.1). Research design involves a sequence of decisions that have to be taken in a project’s early stages, when one oversight or poor decision can lead to results that are ultimately trivial or untrustworthy. Thus, it is critically important to think carefully and systematically about research design before committing time and resources to acquiring texts or mastering software packages or programming languages for your text mining project.

<img src="images/05-framing-research/Ignatow2017-research-design.png" width="90%" style="display: block; margin: auto;" />


**Egbert, J., Larsson, T., & Biber, D. (2020). Doing Linguistics with a Corpus: Methodological Considerations for the Everyday User. Cambridge University Press.** [@Egbert2020]

Chapter 3 "Research Designs: Linguistically Meaningful Research Questions, Observational Units, Variables, and Dispersion"

- Research questions should drive decisions about the choice of observational unit, how variables are defined, and the choice of research design.
- Observational units can be defined at the level of the linguistic feature,
the text, or the corpus.
- Variables can be measured qualitatively, according to variants of a
linguistic feature, or quantitatively, using rates of occurrence for features.

Chapter 7 "Interpreting Quantitative Results"

- Linguistics is done by linguists, not by computers.
- In order to be useful, quantitative corpus linguistic analysis should be
coupled with sound qualitative interpretation.
- Researchers can rely on linguistic context, text-external context, and
linguistic theory to guide their interpretation of quantitative corpus findings.

-->
