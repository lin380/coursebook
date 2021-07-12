# Prediction {#prediction}





<p style="font-weight:bold; color:red;">INCOMPLETE DRAFT</p>

> ...

<div class="rmdkey">
<p>In this chapter you will learn:</p>
<ul>
<li>the goals of this textbook</li>
<li>the reasoning for using the R programming language</li>
<li>important text conventions employed in this textbook</li>
</ul>
</div>


```r
# Packages
```


text

## ...

text


In Table () we see the top five terms for each class after breaking the messages into terms and then counting up the frequencies.


```r
sms_f <- sms %>%
    unnest_tokens(terms, message, token = "regex", pattern = " ") %>%
    count(sms_type, terms)

sms_f %>%
    arrange(sms_type, desc(n)) %>%
    group_by(sms_type) %>%
    slice_head(n = 5) %>%
    select(sms_type, terms, frequency = n) %>%
    kable(booktabs = TRUE, caption = "Top five most frequent terms for 'ham' and 'spam'.")
```

<!-- There are a couple things we may want to take into consideration given our first-pass results. First, there appears to some overlap in the top terms in each class (i.e. 'you', 'to', and 'a'). Ideally we want to create maximum separation between the terms that are most indicative of each class. Think of this from the point of view of a human learner. If you were to study a frequency list like this to try to learn how do distinguish between 'spam' and 'ham' and then you were given the term 'you' to make your decision on a test your decision would almost be a complete guess --the uncertainty is high because term figures prominently in both classes. Second you will note that the frequency for the first five terms of 'ham' is much higher than terms in 'spam'. This imbalance suggests that there are simply more 'ham' messages in our data or that 'ham' messages are longer (have more terms), or both. Any of these sources can potentially bias our machine learner to choose 'ham' over 'spam' for reasons which are not founded on the distinction between terms. -->


```r
library(tidymodels)

sms_split <- initial_split(sms, strata = "sms_type")
train_data <- training(sms_split)
test_data <- testing(sms_split)

library(textrecipes)
```


The In Figure () Let's consider the results from a hypothetical model of text classification on the SMS dataset I introduced at in this subsection. 


<img src="images/10-prediction/pda-sms-contingency-table.png" width="90%" style="display: block; margin: auto;" />



  - accuracy (measure of overall correct predictions)
  - precision (measure of the quality of the predictions)
    - Percentage of predicted 'ham' messages that were correct
  - recall (measure of the quantity of the predictions)
    - Percentage of actual 'ham' messages that were correct
  - F1-score (summarizes the balance between precision and recall)


## Summary

...



