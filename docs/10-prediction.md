# Prediction {#prediction}





<p style="font-weight:bold; color:red;">INCOMPLETE DRAFT</p>

> ...

<div class="rmdkey">
<p>The essential questions for this chapter are:</p>
<ul>
<li>…</li>
<li>…</li>
<li>…</li>
</ul>
</div>

<!-- COURSE STRUCTURE

TUTORIALS:

- ...

SWIRL:

- ...

WORKED/ RECIPE:

- ...

PROJECT:

- ...

GOALS:

...

-->


<!-- IDEAS:

- English/ Spanish language detection (chapter)
  - ACTIVES
  - SUBTLEX_us
  - /Users/francojc/Documents/Academic/Teaching/Courses/2018-2019 Spring/LIN 380/Course/Video lectures/Language

- SPAM (recipe)
  - SMS messages
  - tadr::sms

- Nativeness (chapter)
  - CEDEL2 (Spanish)
  - Wricle and Locness (English?)
    - http://wricle.learnercorpora.com/
    - /Users/francojc/Documents/Academic/Research/Data/Language/Corpora/LOCNESS

- Authorship (lab)
  - /Users/francojc/Documents/Academic/Research/Data/Language/Corpora/Federalist papers
  - /Users/francojc/Documents/Academic/Teaching/Courses/2018-2019 Spring/LIN 380/RStudio/Data/Federalist/Documents
  
- RateMyProfessor (from recipe 8)  
  - https://data.mendeley.com/datasets/fvtfjyvw7d/2

-->




In this chapter ....



Orientation to the question(s) and dataset(s) to be explored ...

## Preparation

Data set transformation

Splitting into training and test sets

## Model training

Aim to use the create an abstraction of the patterns in the dataset


- Feature engineering

- Model selection

- Model evaluation

The In Figure () Let's consider the results from a hypothetical model of text classification on the SMS dataset I introduced at in this subsection. 




  - accuracy (measure of overall correct predictions)
  - precision (measure of the quality of the predictions)
    - Percentage of predicted 'ham' messages that were correct
  - recall (measure of the quantity of the predictions)
    - Percentage of actual 'ham' messages that were correct
  - F1-score (summarizes the balance between precision and recall)

Avoiding overfitting


## Model testing

Aim to test the abstracted model to new observations.  

Model testing

## Evaluation

Evaluation of results

Relationship between predicted and actual classes in a confusion matrix as seen in Figure \@ref(fig:pda-confusion-matrix-image).

<div class="figure" style="text-align: center">
<img src="images/10-prediction/pda-confusion-matrix.png" alt="Confusion matrix" width="90%" />
<p class="caption">(\#fig:pda-confusion-matrix-image)Confusion matrix</p>
</div>



## ...


In Table () we see the top five terms for each class after breaking the messages into terms and then counting up the frequencies.



<!-- There are a couple things we may want to take into consideration given our first-pass results. First, there appears to some overlap in the top terms in each class (i.e. 'you', 'to', and 'a'). Ideally we want to create maximum separation between the terms that are most indicative of each class. Think of this from the point of view of a human learner. If you were to study a frequency list like this to try to learn how do distinguish between 'spam' and 'ham' and then you were given the term 'you' to make your decision on a test your decision would almost be a complete guess --the uncertainty is high because term figures prominently in both classes. Second you will note that the frequency for the first five terms of 'ham' is much higher than terms in 'spam'. This imbalance suggests that there are simply more 'ham' messages in our data or that 'ham' messages are longer (have more terms), or both. Any of these sources can potentially bias our machine learner to choose 'ham' over 'spam' for reasons which are not founded on the distinction between terms. -->





## Summary

...



