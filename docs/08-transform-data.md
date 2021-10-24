# Transform data {#transform-data}





<p style="font-weight:bold; color:red;">DRAFT</p>

> Nothing is lost. Everything is transformed.
>
> --- Michael Ende, The Neverending Story

<div class="rmdkey">
<p>The essential questions for this chapter are:</p>
<ul>
<li>What is the role of data transformation in a text analysis project?</li>
<li>What are the general processes for preparing datasets for analysis?</li>
<li>How do each of these general processes transform datasets?</li>
</ul>
</div>

<!-- COURSE STRUCTURE

TUTORIALS:

- Primers: 
    - Join datasets
    - Tidytext tutorial https://juliasilge.shinyapps.io/learntidytext/#section-introduction

SWIRL:

- ...

WORKED/ RECIPE:

- ...

PROJECT:

- ...

GOALS:

...

-->



In this chapter we turn out attention to the process of moving a curated dataset one step closer to analysis. Where in the process of curating data into a dataset the goal was to derived a tidy dataset that contained the main relational characteristics of the data for our text analysis project, the transformation step refines and potential expands these characteristics such that they are more in line with our analysis aims. In this chapter I have grouped various transformation steps into four categories: normalization, recoding, generation, and merging. It is of note that the these categories have been ordered and are covered separately for descriptive reasons. In practice the ordering of which transformation to apply before another is highly idiosyncrastic and requires that the researcher evaluate the characteristics of the dataset and the desired results.  

Furthermore, since in any given project there may be more than one analysis that may be performed on the data, there may be distinct transformation steps which correspond to each analysis approach. Therefore it is possible that there are more than one transformed dataset created from the curated dataset. This is one of the reasons that we create a curated dataset instead of derived a transformed dataset from the original data. The curated dataset serves as a point of departure from which multiple transformational methods can derive distinct formats for distinct analyses. 

Let's now turn to demonstrations of some common transformational steps using datasets with which we are now familiar 

## Normalize

The process of normalizing datasets in essence is to santize the values of variable or set of variables such that there are no artifacts that will contaminate subsequent processing. It may be the case that non-linguistic metadata may require normalization but more often than not linguistic information is the most common target for normalization as text often includes artifacts from the acquisition process which will not be desired in the analysis. 

**Europarle Corpus**

Consider the curated Europarle Corpus dataset. I will read in the dataset. Since the dataset is quite large, I have also subsetted the dataset keeping only the first 1,000 observations for each of value of `type` for demonstration purposes.


```r
europarle <- read_csv(file = "../data/derived/europarle/europarle_curated.csv") %>%  # read curated dataset
  filter(sentence_id < 1001) # keep first 1000 observations for each type

glimpse(europarle)
```


```
#> Rows: 2,000
#> Columns: 3
#> $ type        <chr> "Source", "Target", "Source", "Target", "Source", "Target"…
#> $ sentence_id <dbl> 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, …
#> $ sentence    <chr> "Reanudación del período de sesiones", "Resumption of the …
```

Simply looking at the first 14 lines of this dataset, we can see that if our goal is to work with the transcribed ('Source') and translated ('Target') language, there are lines which do not appear to be of interest.


Table: (\#tab:td-europarle-preview-1)Europarle Corpus curated dataset preview.

|type   | sentence_id|sentence                                                                                                                                                                                                                                 |
|:------|-----------:|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|Source |           1|Reanudación del período de sesiones                                                                                                                                                                                                      |
|Target |           1|Resumption of the session                                                                                                                                                                                                                |
|Source |           2|Declaro reanudado el período de sesiones del Parlamento Europeo, interrumpido el viernes 17 de diciembre pasado, y reitero a Sus Señorías mi deseo de que hayan tenido unas buenas vacaciones.                                           |
|Target |           2|I declare resumed the session of the European Parliament adjourned on Friday 17 December 1999, and I would like once again to wish you a happy new year in the hope that you enjoyed a pleasant festive period.                          |
|Source |           3|Como todos han podido comprobar, el gran "efecto del año 2000" no se ha producido. En cambio, los ciudadanos de varios de nuestros países han sido víctimas de catástrofes naturales verdaderamente terribles.                           |
|Target |           3|Although, as you will have seen, the dreaded 'millennium bug' failed to materialise, still the people in a number of countries suffered a series of natural disasters that truly were dreadful.                                          |
|Source |           4|Sus Señorías han solicitado un debate sobre el tema para los próximos días, en el curso de este período de sesiones.                                                                                                                     |
|Target |           4|You have requested a debate on this subject in the course of the next few days, during this part-session.                                                                                                                                |
|Source |           5|A la espera de que se produzca, de acuerdo con muchos colegas que me lo han pedido, pido que hagamos un minuto de silencio en memoria de todas las víctimas de las tormentas, en los distintos países de la Unión Europea afectados.     |
|Target |           5|In the meantime, I should like to observe a minute' s silence, as a number of Members have requested, on behalf of all the victims concerned, particularly those of the terrible storms, in the various countries of the European Union. |
|Source |           6|Invito a todos a que nos pongamos de pie para guardar un minuto de silencio.                                                                                                                                                             |
|Target |           6|Please rise, then, for this minute' s silence.                                                                                                                                                                                           |
|Source |           7|(El Parlamento, de pie, guarda un minuto de silencio)                                                                                                                                                                                    |
|Target |           7|(The House rose and observed a minute' s silence)                                                                                                                                                                                        |

`sentence_id` 1 appears to be title and `sentence_id` 7 reflects description of the parliamentary session. Both of these are artifacts that we would like to remove from the dataset. 

To remove these lines we can turn to the programming strategies we've previously worked with. Namely we will use `filter()` to filter observations in combination with `str_detect()` to detect matches for some pattern that is indicative of these lines that we want to remove and not of the other lines that we want to keep. 

Before we remove any lines, let's try craft a search pattern to identify these lines, and exclude the lines we will want to keep. Condition one is lines which start with an opening parenthesis `(`. Condition two is lines that do not end in standard sentence punctuation (`.`, `!`, or `?`). I've added both conditions to one `filter()` using the logical *OR* operator (`|`)  to ensure that either condition is matched in the output. 


```r
# Identify non-speech lines
europarle %>% 
  filter(str_detect(sentence, "^\\(") | str_detect(sentence, "[^.!?]$")) %>% # filter lines that detect a match for either condition 1 or 2
  slice_sample(n = 10) %>% # random sample of 10 observations
  knitr::kable(booktabs = TRUE,
        caption = 'Non-speech lines in the Europarle dataset.')
```



Table: (\#tab:td-europarle-search-non-speech)Non-speech lines in the Europarle dataset.

|type   | sentence_id|sentence                                                                                                                                                                                                                                                                |
|:------|-----------:|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|Target |          85|(Applause from the PSE Group)                                                                                                                                                                                                                                           |
|Target |         293|Structural Funds - Cohesion Fund coordination                                                                                                                                                                                                                           |
|Source |          93|(El Parlamento rechaza la petición) El Presidente.                                                                                                                                                                                                                      |
|Source |         110|(El Parlamento rechaza la propuesta por 164 votos a favor, 166 votos en contra y 7 abstenciones)                                                                                                                                                                        |
|Target |         220|Transport of dangerous goods by road                                                                                                                                                                                                                                    |
|Source |         673|A5-0078/1999 del Sr. Rapkay, en nombre de la Comisión de Asuntos Económicos y Monetarios, sobre el XXVIII Informe de la Comisión Europea sobre la política de competencia - 1998 (SEC(1999) 743 - C5-121/1999 - 1999/2124(COS));                                        |
|Source |          66|Orden de los trabajos                                                                                                                                                                                                                                                   |
|Source |         669|(El Acta queda aprobada)                                                                                                                                                                                                                                                |
|Source |           1|Reanudación del período de sesiones                                                                                                                                                                                                                                     |
|Target |         675|A5-0087/1999 by Mr Jonckheer, on behalf of the Committee on Economic and Monetary Affairs, on the seventh survey on state aid in the European Union in the manufacturing and certain other sectors. [COM(1999) 148 - C5-0107/1999 - 1999/2110(COS)] (Report 1995-1997); |

Since this search appears to match lines that we do not want to preserve, let's move now to eliminate these lines from the dataset. To do this we will use the same regular expression patterns, but now each condition will have it's own `filter()` call and the `str_detect()` will be negated with a prefixed `!`.


```r
europarle <- 
  europarle %>% # dataset
  filter(!str_detect(sentence, pattern = "^\\(")) %>% # remove lines starting with (
  filter(!str_detect(sentence, pattern = "[^.!?]$")) # remove lines not ending in ., !, or ?
```

Let's look at the first 14 lines again, now that we have eliminated these artifacts. 


Table: (\#tab:td-europarle-preview-2)Europarle Corpus non-speech lines removed.

|type   | sentence_id|sentence                                                                                                                                                                                                                                 |
|:------|-----------:|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|Source |           2|Declaro reanudado el período de sesiones del Parlamento Europeo, interrumpido el viernes 17 de diciembre pasado, y reitero a Sus Señorías mi deseo de que hayan tenido unas buenas vacaciones.                                           |
|Target |           2|I declare resumed the session of the European Parliament adjourned on Friday 17 December 1999, and I would like once again to wish you a happy new year in the hope that you enjoyed a pleasant festive period.                          |
|Source |           3|Como todos han podido comprobar, el gran "efecto del año 2000" no se ha producido. En cambio, los ciudadanos de varios de nuestros países han sido víctimas de catástrofes naturales verdaderamente terribles.                           |
|Target |           3|Although, as you will have seen, the dreaded 'millennium bug' failed to materialise, still the people in a number of countries suffered a series of natural disasters that truly were dreadful.                                          |
|Source |           4|Sus Señorías han solicitado un debate sobre el tema para los próximos días, en el curso de este período de sesiones.                                                                                                                     |
|Target |           4|You have requested a debate on this subject in the course of the next few days, during this part-session.                                                                                                                                |
|Source |           5|A la espera de que se produzca, de acuerdo con muchos colegas que me lo han pedido, pido que hagamos un minuto de silencio en memoria de todas las víctimas de las tormentas, en los distintos países de la Unión Europea afectados.     |
|Target |           5|In the meantime, I should like to observe a minute' s silence, as a number of Members have requested, on behalf of all the victims concerned, particularly those of the terrible storms, in the various countries of the European Union. |
|Source |           6|Invito a todos a que nos pongamos de pie para guardar un minuto de silencio.                                                                                                                                                             |
|Target |           6|Please rise, then, for this minute' s silence.                                                                                                                                                                                           |
|Source |           8|Señora Presidenta, una cuestión de procedimiento.                                                                                                                                                                                        |
|Target |           8|Madam President, on a point of order.                                                                                                                                                                                                    |
|Source |           9|Sabrá usted por la prensa y la televisión que se han producido una serie de explosiones y asesinatos en Sri Lanka.                                                                                                                       |
|Target |           9|You will be aware from the press and television that there have been a number of bomb explosions and killings in Sri Lanka.                                                                                                              |

One further issue that we may want to resolve concerns the fact that there are whitespaces between possessive forms (i.e. "minute’ s silence"). In this case we can employ `str_replace_all()` inside the `mutate()` function to overwrite the `sentence` values that match an apostrophe `'` with whitespace (`\\s`) before `s`.


```r
europarle <- 
  europarle %>% # dataset
  mutate(sentence = str_replace_all(string = sentence, 
                                    pattern = "'\\ss", 
                                    replacement = "'s")) # replace ' s with `s
```

Now we have normalized text in the `sentence` column in the Europarle dataset. 

**Last FM Lyrics**

<!-- (stanza separation, other) -->
Let's look at another dataset we have worked with during this coursebook: the Lastfm lyrics. Reading in the `lastfm_curated` dataset from the `data/derived/` directory we can see the structure for the curated structure. 


```r
lastfm <- read_csv(file = "../data/derived/lastfm/lastfm_curated.csv")  # read in lastfm_curated dataset
```




Table: (\#tab:td-lastfm-read-preview)Last fm lyrics dataset preview with one artist/ song per genre and the `lyrics` text truncated  at 200 characters for display purposes.

|artist        |song             |lyrics                                                                                                                                                                                                   |genre   |
|:-------------|:----------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------|
|Alan Jackson  |Little Bitty     |Have a little love on a little honeymoonYou got a little dish and you got a little spoonA little bitty house and a little bitty yardA little bitty dog and a little bitty car Well, it's alright to b... |country |
|50 Cent       |In Da Club       |Go, go, go, go, go, goGo, shortyIt's your birthdayWe gon' party like it's your birthdayWe gon' sip Bacardi like it's your birthdayAnd you know we don't give a fuck it's not your birthday You can fi... |hip-hop |
|Black Sabbath |Paranoid         |Finished with my woman'Cause she couldn't help me with my mindPeople think I'm insaneBecause I am frowning all the time All day long, I think of thingsBut nothing seems to satisfyThink I'll lose my... |metal   |
|a-ha          |Take On Me       |Talking awayI don't know whatWhat to sayI'll say it anywayToday is another day to find youShying awayOh, I'll be coming for your love, okay? Take On Me (Take On Me)Take me on (Take On Me)I'll be go... |pop     |
|3 Doors Down  |Here Without You |A hundred days have made me olderSince the last time that I saw your pretty faceA thousand lies have made me colderAnd I don't think I can look at this the same But all the miles that separateDisap... |rock    |

There are a few things that we might want to clean out of the `lyrics` column's values. First, there are lines from the original webscrape where the end of one stanza runs into the next without whitespace between them (i.e. "honeymoonYou"). These reflect contiguous end-new line segments where stanzas were joined in the curation process. Second, we see that there are what appear to be backing vocals which appear between parentheses (i.e. "(Take On Me)"). 

In both cases we will use `mutate()`. With contiguous end-new line segments we will use `str_replace_all()` inside and for backing vocals in parentheses we will use `str_remove_all()`. 

The pattern to match for end-new lines from the stanzas will use some regular expression magic. The base pattern includes finding a pair of lowercase-uppercase letters (i.e. "nY", in "honeymoo**nY**ou"). For this we can use the pattern `[a-z][A-Z]`. To replace this pattern using the lowercase letter then a space and then the uppercase letter we take advantage of the grouping syntax in regular expressions `(...)`. So we add parentheses around the two groups to capture like this `([a-z])([A-Z])`. In the replacement argument of the `str_replace_all()` function we then specify to use the captured groups in the order they appear `\\1` for the lowercase letter match and `\\2` for the uppercase letter match. 

Now, I've looked more extensively at the `lyrics` column and found that there are other combinations that are joined between stanzas. Namely that `'`, `!`, `,`, `)`, `?`, and `I` also may precede the uppercase letter. To make sure we capture these possibilities as well I've updated the regular expression to `([a-z'!,.)?I])([A-Z])`. 

Now to remove the backing vocals, the regex pattern is `\\(.+?\\)` --match the parentheses and everything within the parentheses. The added `?` after the `+` operator is what is known as a 'lazy' operator. This specifies that the `.+` will match the minimal string that is enclosed by the trailing `)`. If we did not include this then we would get matches that span from the first parenthesis `(` all the way to the last, which would match real lyrics, not just the backing vocals.

Putting this to work let's clean the `lyrics` column.


```r
lastfm <- 
  lastfm %>% # dataset
  mutate(lyrics = 
           str_replace_all(string = lyrics, 
                           pattern = "([a-z'!,.)?I])([A-Z])", # find contiguous end/ new line segments
                           replacement = "\\1 \\2")) %>%  # replace with whitespace between
  mutate(lyrics = str_remove_all(lyrics, "\\(.+?\\)")) # remove backing vocals (Take On Me)
```


Table: (\#tab:td-lastfm-clean-end-lines-preview)Last fm lyrics with cleaned lyrics...

|artist        |song             |lyrics                                                                                                                                                                                                   |genre   |
|:-------------|:----------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------|
|Alan Jackson  |Little Bitty     |Have a little love on a little honeymoon You got a little dish and you got a little spoon A little bitty house and a little bitty yard A little bitty dog and a little bitty car Well, it's alright t... |country |
|50 Cent       |In Da Club       |Go, go, go, go, go, go Go, shorty It's your birthday We gon' party like it's your birthday We gon' sip Bacardi like it's your birthday And you know we don't give a fuck it's not your birthday You c... |hip-hop |
|Black Sabbath |Paranoid         |Finished with my woman' Cause she couldn't help me with my mind People think I'm insane Because I am frowning all the time All day long, I think of things But nothing seems to satisfy Think I'll lo... |metal   |
|a-ha          |Take On Me       |Talking away I don't know what What to say I'll say it anyway Today is another day to find you Shying away Oh, I'll be coming for your love, okay? Take On Me  Take me on  I'll be gone In a day or t... |pop     |
|3 Doors Down  |Here Without You |A hundred days have made me older Since the last time that I saw your pretty face A thousand lies have made me colder And I don't think I can look at this the same But all the miles that separate D... |rock    |

Now given the fact that songs are poems, there are many lines that are not complete sentences so there is no practical way to try to segment these into grammatical sentence units. So in this case, this seems like a good stopping point for normalizing the lastfm dataset.


<!-- Consider:

- last.fm lyrics, line-break artifacts
- 


The process of normalization aims to _sanitize_ the values within a variable or set of variables. This may include removing whitespace, punctuation, numerals, or special characters or substituting uppercase for lowercase characters, numerals for word versions, acronyms for their full forms, irregular or incorrect spelling for accepted forms, or removing common words (stopwords), etc.

-->

## Recode

<!-- Consider:

The process of recoding aims to _recast_ the values of a variable or set of variables to a new variable or set of variables to enable more direct access. This may include extracting values from a variable, stemming or lemmatization of words, tokenization of linguistic forms (words, ngrams, sentences, etc.), calculating the lengths of linguistic units, removing variables that will not be used in the analysis, etc.
-->

Normalizing text can be seen as an extension of dataset curation to some extent in that the structure of the dataset is maintained. In both the Europarle and Lastfm cases we saw this to be true. In the case of recoding, and other transformational steps, the aim will be to modify the dataset structure either by rows, columns, or both. Recoding processes can be characterized by the creation of structural changes which are derived from values in variables effectively recasting values as new variables to enable more direct access in our analyses.

**Switchboard Dialogue Act Corpus**

The Switchboard Dialogue Act Corpus dataset that was curated in the previous chapter contains a number of variables describing conversations between speakers of American English. 

Let's read in this dataset and take a closer look.


```r
sdac <- read_csv(file = "../data/derived/sdac/sdac_curated.csv")  # read curated dataset
```



Among a number of metadata variables, curated dataset includes the `utterance_text` column which contains dialogue from the conversations interleaved with a [disfluency annotation scheme](https://staff.fnwi.uva.nl/r.fernandezrovira/teaching/DM-materials/DFL-book.pdf). 


Table: (\#tab:td-sdac-preview-curated-dataset)20 randomly sampled lines of the SDAC curated dataset.

| doc_id|damsl_tag |speaker | turn_num| utterance_num|utterance_text                                                                                                                                                                                                                             | speaker_id|
|------:|:---------|:-------|--------:|-------------:|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------:|
|   2479|sd        |B       |       20|             3|I'm kind of had [ different, + different ] ideas from what probably the majority of people have, /                                                                                                                                         |       1096|
|   2716|sd@       |A       |       85|             2|then if people weren't having to spend these huge amounts of money on getting insurance coverage.                                                                                                                                          |       1231|
|   4917|%         |B       |       44|             3|{C and. } # -/                                                                                                                                                                                                                             |       1687|
|   2875|sd        |A       |      127|             2|{E I mean, }                                                                                                                                                                                                                               |       1104|
|   2950|%         |B       |      108|             1|{C And, } -/                                                                                                                                                                                                                               |       1266|
|   4104|sv        |B       |       54|             3|{C because } they're real snobby about their language  /                                                                                                                                                                                   |       1508|
|   2773|sv        |B       |       38|             2|{C so } it will be a good topic for me in the class for along time <laughter>. /                                                                                                                                                           |       1239|
|   2537|sd        |B       |       16|             2|{C but, } {F um, } {D you know, } [ I don't, +  I'm not ] particularly  concerned with what people do, {F um, } after they leave for the day especially [ if I don't, +   if I don't, ] {F uh, } see any results of it the next # day. # / |       1142|
|   3699|qy        |A       |        1|             2|{F Uh, } do you live in a home? /                                                                                                                                                                                                          |       1466|
|   3565|sd        |A       |       47|             2|it was flat -- /                                                                                                                                                                                                                           |       1455|
|   4707|+         |A       |        4|             1|<Cough> I turned ] mine in about twelve hours early at noon. /                                                                                                                                                                             |       1190|
|   2663|sd        |B       |       34|             1|I think if the President, be him Republican or Democrat, - /                                                                                                                                                                               |       1084|
|   4626|%         |A       |       45|             5|{F Uh, } {C and } it, {F uh, } - /                                                                                                                                                                                                         |       1196|
|   2268|aa^r      |B       |      148|             2|No. /                                                                                                                                                                                                                                      |       1112|
|   4318|sv        |A       |       89|             2|{C But, } {F uh, } {F uh, } it's interesting,  /                                                                                                                                                                                           |       1606|
|   4329|ft        |B       |       84|             1|{D Well, } thank you. /                                                                                                                                                                                                                    |       1287|
|   2554|aa        |B       |      110|             1|Absolutely. /                                                                                                                                                                                                                              |       1142|
|   3716|+         |B       |       72|             1|-- {F uh, } I will use a little bit of mustard with it. /                                                                                                                                                                                  |       1315|
|   3320|sv        |A       |       79|             4|{C but } they do. /                                                                                                                                                                                                                        |       1413|
|   3064|sd        |B       |      138|             1|Boy, I wish I could say that my house and, - /                                                                                                                                                                                             |       1005|
Let's drop a few variables from our dataset to rein in our focus. I will keep the `doc_id`, `speaker_id`, and `utterance_text`. 


```r
sdac_simplified <- 
  sdac %>% # dataset
  select(doc_id, speaker_id, utterance_text) # columns to retain
```


Table: (\#tab:td-sdac-simple-preview)First 10 lines of the simplified SDAC curated dataset.

| doc_id| speaker_id|utterance_text                                                             |
|------:|----------:|:--------------------------------------------------------------------------|
|   4325|       1632|Okay.  /                                                                   |
|   4325|       1632|{D So, }                                                                   |
|   4325|       1519|[ [ I guess, +                                                             |
|   4325|       1632|What kind of experience [ do you, + do you ] have, then with child care? / |
|   4325|       1519|I think, ] + {F uh, } I wonder ] if that worked. /                         |
|   4325|       1632|Does it say something? /                                                   |
|   4325|       1519|I think it usually does.  /                                                |
|   4325|       1519|You might try, {F uh, }  /                                                 |
|   4325|       1519|I don't know,  /                                                           |
|   4325|       1519|hold it down a little longer,  /                                           |


In this disfluency annotation system, there are various conventions used for non-sentence elements. If say, for example, a researcher were to be interested in understanding the use of filled pauses ('uh' or 'uh'), the aim would be to identify those lines where the `{F ...}` annotation is used around the utterances 'uh' and 'um'.  

To do this we turn to the `str_count()` function. This function will count the number of matches found for a pattern. We can use a regular expression to identify the pattern of interest which is all the instances of `{F` followed by either `uh` or `um`. Since the disfluencies may start an utterance, and therefore be capitalized we need to formulate a regular expression which allows for either `U` or `u` for each disfluency type. The result from each disfluency match will be added to a new column. To create a new column we will wrap each `str_count()` with `mutate()` and give the new column a meaningful name. In this case I've opted for `uh` and `um`. 


```r
sdac_disfluencies <- 
  sdac_simplified %>% # dataset
  mutate(uh = str_count(utterance_text, "\\{F [Uu]h")) %>% # match {F Uh or {F uh}
  mutate(um = str_count(utterance_text, "\\{F [Uu]m")) # match {F Um or {F um}
```


Table: (\#tab:td-sdac-count-disfluencies-show)First 20 lines of SDAC dataset with counts for the disfluencies 'uh' and 'um'.

| doc_id| speaker_id|utterance_text                                                             | uh| um|
|------:|----------:|:--------------------------------------------------------------------------|--:|--:|
|   4325|       1632|Okay.  /                                                                   |  0|  0|
|   4325|       1632|{D So, }                                                                   |  0|  0|
|   4325|       1519|[ [ I guess, +                                                             |  0|  0|
|   4325|       1632|What kind of experience [ do you, + do you ] have, then with child care? / |  0|  0|
|   4325|       1519|I think, ] + {F uh, } I wonder ] if that worked. /                         |  1|  0|
|   4325|       1632|Does it say something? /                                                   |  0|  0|
|   4325|       1519|I think it usually does.  /                                                |  0|  0|
|   4325|       1519|You might try, {F uh, }  /                                                 |  1|  0|
|   4325|       1519|I don't know,  /                                                           |  0|  0|
|   4325|       1519|hold it down a little longer,  /                                           |  0|  0|
|   4325|       1519|{C and } see if it, {F uh, } -/                                            |  1|  0|
|   4325|       1632|Okay <beep>.  /                                                            |  0|  0|
|   4325|       1632|<<long pause>> {D Well, }                                                  |  0|  0|
|   4325|       1519|Okay  /                                                                    |  0|  0|
|   4325|       1519|[ I, +                                                                     |  0|  0|
|   4325|       1632|Does it usually make a recording or s-, /                                  |  0|  0|
|   4325|       1519|{D Well, } I ] don't remember.  /                                          |  0|  0|
|   4325|       1519|It seemed like it did,  /                                                  |  0|  0|
|   4325|       1519|{C but } <laughter> it might not.  /                                       |  0|  0|
|   4325|       1519|[ I guess + --                                                             |  0|  0|

Now we have two new columns, `uh` and `um` which indicate how many times the relevant pattern was matched for a given utterance. By choosing to focus on disfluencies, however, we have made a decision to change the unit of observation from the utterance to the use of filled pauses (`uh` and `um`). This means that as the dataset stands, it is not in tidy format --where each observation corresponds to the observational unit. When datasets are misaligned in this particular way, there are in what is known as 'wide' format. What we want to do, then, is to restructure our dataset such that each row corresponds to the unit of observation --in this case each filled pause type. 

To convert our current (wide) dataset to one where each filler type is listed and the counts are measured for each utterance we turn to the `pivot_longer()` function. This function creates two new columns, one in which the column names are listed and one for the values for each of the column names.  


```r
sdac_disfluencies <- 
  sdac_disfluencies %>% # dataset
  pivot_longer(cols = c("uh", "um"), # columns to convert
               names_to = "filler", # column for the column names (i.e. filler types)
               values_to = "count") # column for the column values (i.e. counts)
```


Table: (\#tab:td-sdac-count-disfluencies-longer-show)First 20 lines of SDAC dataset with tidy format for `fillers` as the unit of observation.

| doc_id| speaker_id|utterance_text                                                             |filler | count|
|------:|----------:|:--------------------------------------------------------------------------|:------|-----:|
|   4325|       1632|Okay.  /                                                                   |uh     |     0|
|   4325|       1632|Okay.  /                                                                   |um     |     0|
|   4325|       1632|{D So, }                                                                   |uh     |     0|
|   4325|       1632|{D So, }                                                                   |um     |     0|
|   4325|       1519|[ [ I guess, +                                                             |uh     |     0|
|   4325|       1519|[ [ I guess, +                                                             |um     |     0|
|   4325|       1632|What kind of experience [ do you, + do you ] have, then with child care? / |uh     |     0|
|   4325|       1632|What kind of experience [ do you, + do you ] have, then with child care? / |um     |     0|
|   4325|       1519|I think, ] + {F uh, } I wonder ] if that worked. /                         |uh     |     1|
|   4325|       1519|I think, ] + {F uh, } I wonder ] if that worked. /                         |um     |     0|
|   4325|       1632|Does it say something? /                                                   |uh     |     0|
|   4325|       1632|Does it say something? /                                                   |um     |     0|
|   4325|       1519|I think it usually does.  /                                                |uh     |     0|
|   4325|       1519|I think it usually does.  /                                                |um     |     0|
|   4325|       1519|You might try, {F uh, }  /                                                 |uh     |     1|
|   4325|       1519|You might try, {F uh, }  /                                                 |um     |     0|
|   4325|       1519|I don't know,  /                                                           |uh     |     0|
|   4325|       1519|I don't know,  /                                                           |um     |     0|
|   4325|       1519|hold it down a little longer,  /                                           |uh     |     0|
|   4325|       1519|hold it down a little longer,  /                                           |um     |     0|


**Last fm**

<!-- tokenization (`unnest_tokens`, words/ n-grams) -->

In the previous example, we used a matching approach to extract information embedded in one column of the dataset and recoded the dataset to maintain the fidelity between the particular unit of observation and the other metadata.

Another common approach for recoding datasets in text analysis projects involves recoding linguistic units as smaller units; a process known as tokenization. 

Let's return to the `lastfm` object we normalized earlier in the chapter to see the various ways one can choose to tokenize linguistic information. 


Table: (\#tab:td-lastfm-clean-end-lines-preview-2)Last fm dataset with normalized lyrics.

|artist        |song             |lyrics                                                                                                                                                                                                   |genre   |
|:-------------|:----------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------|
|Alan Jackson  |Little Bitty     |Have a little love on a little honeymoon You got a little dish and you got a little spoon A little bitty house and a little bitty yard A little bitty dog and a little bitty car Well, it's alright t... |country |
|50 Cent       |In Da Club       |Go, go, go, go, go, go Go, shorty It's your birthday We gon' party like it's your birthday We gon' sip Bacardi like it's your birthday And you know we don't give a fuck it's not your birthday You c... |hip-hop |
|Black Sabbath |Paranoid         |Finished with my woman' Cause she couldn't help me with my mind People think I'm insane Because I am frowning all the time All day long, I think of things But nothing seems to satisfy Think I'll lo... |metal   |
|a-ha          |Take On Me       |Talking away I don't know what What to say I'll say it anyway Today is another day to find you Shying away Oh, I'll be coming for your love, okay? Take On Me  Take me on  I'll be gone In a day or t... |pop     |
|3 Doors Down  |Here Without You |A hundred days have made me older Since the last time that I saw your pretty face A thousand lies have made me colder And I don't think I can look at this the same But all the miles that separate D... |rock    |
In the current `lastfm` dataset, the unit of observation is the lyrics for the entire artist, song, and genre combination. If, however, we would like to change the unit to say words, we would like each word used to appear on its own row, while still maintaining the other relevant attributes associated with each word. 

The tidytext package includes a very useful function `unnest_tokens()` which allows us to tokenize some textual input into smaller linguistic units. The 'unnest' part of the the function name refers to the process of extracting the unit of interest while maintaining the other relevant attributes. Let's see this in action. 


```r
lastfm %>% # dataset
  unnest_tokens(output = word, # column for tokenized output
                input = lyrics, # input column
                token = "words") %>% # tokenize unit type
  slice_head(n = 10) %>%  # preview first 10 lines
  kable(booktabs = TRUE,
        caption = "First 10 observations for lastfm dataset tokenized by words.")
```



Table: (\#tab:td-lastfm-tokenize-words)First 10 observations for lastfm dataset tokenized by words.

|artist       |song         |genre   |word      |
|:------------|:------------|:-------|:---------|
|Alan Jackson |Little Bitty |country |have      |
|Alan Jackson |Little Bitty |country |a         |
|Alan Jackson |Little Bitty |country |little    |
|Alan Jackson |Little Bitty |country |love      |
|Alan Jackson |Little Bitty |country |on        |
|Alan Jackson |Little Bitty |country |a         |
|Alan Jackson |Little Bitty |country |little    |
|Alan Jackson |Little Bitty |country |honeymoon |
|Alan Jackson |Little Bitty |country |you       |
|Alan Jackson |Little Bitty |country |got       |
We can see from the output, each word appears on a separate line in the order of appearance in the input text (`lyrics`). Furthermore, the output is in tidy format as each of the words is still associated with the relevant attribute values (`artist`, `song`, and `genre`). By default the tokenized text output is lowercased and the original text input column is dropped. These can be overridden, however, if desired.

In addition to 'words', the `unnest_tokens()` function provides easy access to a number of common tokenized units including 'characters', 'sentences', and 'paragraphs'. 


```r
lastfm %>% # dataset
  unnest_tokens(output = character, # column for tokenized output
                input = lyrics, # input column
                token = "characters") %>% # tokenize unit type
  slice_head(n = 10) %>%  # preview first 10 lines
  kable(booktabs = TRUE,
        caption = "First 10 observations for lastfm dataset tokenized by characters.")
```



Table: (\#tab:td-lastfm-tokenize-characters)First 10 observations for lastfm dataset tokenized by characters.

|artist       |song         |genre   |character |
|:------------|:------------|:-------|:---------|
|Alan Jackson |Little Bitty |country |h         |
|Alan Jackson |Little Bitty |country |a         |
|Alan Jackson |Little Bitty |country |v         |
|Alan Jackson |Little Bitty |country |e         |
|Alan Jackson |Little Bitty |country |a         |
|Alan Jackson |Little Bitty |country |l         |
|Alan Jackson |Little Bitty |country |i         |
|Alan Jackson |Little Bitty |country |t         |
|Alan Jackson |Little Bitty |country |t         |
|Alan Jackson |Little Bitty |country |l         |

The other two built-in options 'sentences' and 'paragraphs' depend on punctuation and/ or line breaks to function, so in this particular dataset, these options will not work given the particular characteristics of the `lyrics` variable. 

There are even other options which allow for the creation of sequences of linguistic units. Say we want to tokenize our lyrics into two-word sequences, we can specify the `token` as 'ngrams' and then add the argument `n = 2` to reflect we want two-word sequences. 


```r
lastfm %>% 
  unnest_tokens(output = bigram, # column for tokenized output
                input = lyrics, # input column
                token = "ngrams", # tokenize unit type
                n = 2) %>%  # size of word sequences 
  slice_head(n = 10) %>%  # preview first 10 lines
  kable(booktabs = TRUE,
        caption = "First 10 observations for lastfm dataset tokenized by bigrams")
```



Table: (\#tab:td-lastfm-tokenize-bigrams)First 10 observations for lastfm dataset tokenized by bigrams

|artist       |song         |genre   |bigram           |
|:------------|:------------|:-------|:----------------|
|Alan Jackson |Little Bitty |country |have a           |
|Alan Jackson |Little Bitty |country |a little         |
|Alan Jackson |Little Bitty |country |little love      |
|Alan Jackson |Little Bitty |country |love on          |
|Alan Jackson |Little Bitty |country |on a             |
|Alan Jackson |Little Bitty |country |a little         |
|Alan Jackson |Little Bitty |country |little honeymoon |
|Alan Jackson |Little Bitty |country |honeymoon you    |
|Alan Jackson |Little Bitty |country |you got          |
|Alan Jackson |Little Bitty |country |got a            |

The 'n' in 'ngram' refers to the number of word-sequence units we want to tokenize. Two-word sequences are known as 'bigrams', three-word sequences 'trigrams', and so on.


<!-- - (BELC (speaker ages) -`case_when()`) -->


## Generate

In the process of recoding a dataset the transformation of the dataset works with information that is already explicit. The process of generation, however, aims to make implicit information explicit. The most common type of operation involved in the generation process is the addition of linguistic annotation. This process can be accomplished manually by a researcher or research team or automatically through the use of pre-trained linguistic resources and/ or software. Ideally the annotation of linguistic information can be conducted automatically. 

There are important considerations, however, that need to be taken into account when choosing whether linguistic annotation can be conducted automatically. First and foremost has to do with the type of annotation desired. Information such as part of speech (grammatical category) and morpho-syntactic information are the the most common types of linguistic annotation that can be conducted automatically. Second the degree to which the resource that will be used to annotate the linguistic information is aligned with the language variety and/or register is also a key consideration. As noted, automatic linguistic annotation methods are contingent on pre-trained resources. The language and language variety used to develop these resources may not be available for the language under investigation, or if it does, the language variety and/ or register may not align. The degree to which a resource does not align with the linguistic information targeted for annotation is directly related to the quality of the final annotations. To be clear, no annotation method, whether manual or automatic is guaranteed to be perfectly accurate. 

Let's take a look at annotation some of the language from the Europarle dataset we normalized. 


```r
europarle %>%
    filter(type == "Target") %>%
    slice_head(n = 10) %>%
    kable(booktabs = TRUE, caption = "First 10 lines in English from the normalized SDAC dataset.")
```



Table: (\#tab:unnamed-chunk-3)First 10 lines in English from the normalized SDAC dataset.

|type   | sentence_id|sentence                                                                                                                                                                                                                                                                                          |
|:------|-----------:|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|Target |           2|I declare resumed the session of the European Parliament adjourned on Friday 17 December 1999, and I would like once again to wish you a happy new year in the hope that you enjoyed a pleasant festive period.                                                                                   |
|Target |           3|Although, as you will have seen, the dreaded 'millennium bug' failed to materialise, still the people in a number of countries suffered a series of natural disasters that truly were dreadful.                                                                                                   |
|Target |           4|You have requested a debate on this subject in the course of the next few days, during this part-session.                                                                                                                                                                                         |
|Target |           5|In the meantime, I should like to observe a minute's silence, as a number of Members have requested, on behalf of all the victims concerned, particularly those of the terrible storms, in the various countries of the European Union.                                                           |
|Target |           6|Please rise, then, for this minute's silence.                                                                                                                                                                                                                                                     |
|Target |           8|Madam President, on a point of order.                                                                                                                                                                                                                                                             |
|Target |           9|You will be aware from the press and television that there have been a number of bomb explosions and killings in Sri Lanka.                                                                                                                                                                       |
|Target |          10|One of the people assassinated very recently in Sri Lanka was Mr Kumar Ponnambalam, who had visited the European Parliament just a few months ago.                                                                                                                                                |
|Target |          11|Would it be appropriate for you, Madam President, to write a letter to the Sri Lankan President expressing Parliament's regret at his and the other violent deaths in Sri Lanka and urging her to do everything she possibly can to seek a peaceful reconciliation to a very difficult situation? |
|Target |          12|Yes, Mr Evans, I feel an initiative of the type you have just suggested would be entirely appropriate.                                                                                                                                                                                            |

We will use the cleanNLP package to do our linguistic annotation. The annotation process depends on the pre-trained language models. There is [a list of the models available to access](https://github.com/bnosac/udpipe#pre-trained-models). The `load_model_udpipe()` custom function below downloads the specified language model and initialized the `udpipe` engine (`cnlp_init_udpipe()`) for conducting annotations. 


```r
load_model_udpipe <- function(model_lang) {
  # Function
  # Download and load the specified udpipe language model
  
  cnlp_init_udpipe(model_lang) # to download the model, if not downloaded
base_path <- system.file("extdata", package = "cleanNLP") # get the base path
  model_name <- # extract the model_name
    base_path %>% # extract the base path
    dir() %>% # get the directory
    stringr::str_subset(pattern = paste0("^", model_lang)) # extract the name of the model
  
  udpipe::udpipe_load_model(file = file.path(base_path, model_name, fsep = "/")) %>% # create the path to the downloaded model stored on disk
    return()
}
```

In a test case, let's load the 'english' model to annotate a sentence line from the Europarle dataset to illustrate the basic workflow. 


```r
eng_model <- load_model_udpipe("english") # load and initialize the language model, 'english' in this case.

eng_annotation <- 
  europarle %>% # dataset 
  filter(type == "Target" & sentence_id == 6) %>% # select English and sentence_id 6
  cnlp_annotate(text_name = "sentence", # input text (sentence)
                doc_name = "sentence_id") # specify the grouping column (sentence_id)

glimpse(eng_annotation) # preview structure
#> List of 2
#>  $ token   : tibble [11 × 11] (S3: tbl_df/tbl/data.frame)
#>   ..$ doc_id       : num [1:11] 6 6 6 6 6 6 6 6 6 6 ...
#>   ..$ sid          : int [1:11] 1 1 1 1 1 1 1 1 1 1 ...
#>   ..$ tid          : chr [1:11] "1" "2" "3" "4" ...
#>   ..$ token        : chr [1:11] "Please" "rise" "," "then" ...
#>   ..$ token_with_ws: chr [1:11] "Please " "rise" ", " "then" ...
#>   ..$ lemma        : chr [1:11] "please" "rise" "," "then" ...
#>   ..$ upos         : chr [1:11] "INTJ" "VERB" "PUNCT" "ADV" ...
#>   ..$ xpos         : chr [1:11] "UH" "VB" "," "RB" ...
#>   ..$ feats        : chr [1:11] NA "Mood=Imp|VerbForm=Fin" NA "PronType=Dem" ...
#>   ..$ tid_source   : chr [1:11] "2" "0" "2" "10" ...
#>   ..$ relation     : chr [1:11] "discourse" "root" "punct" "advmod" ...
#>  $ document: tibble [1 × 2] (S3: tbl_df/tbl/data.frame)
#>   ..$ type  : chr "Target"
#>   ..$ doc_id: num 6
#>  - attr(*, "class")= chr [1:2] "cnlp_annotation" "list"
```

We see that the structure returned by the `cnlp_annotate()` function is a list. This list contains two data frames (tibbles). One for the tokens (and there annotation information) and the document (the metadata information). We can inspect the annotation characteristics for this one sentence by targetting the `$tokens` data frame. Let's take a look at the linguistic annotation information returned. 


Table: (\#tab:td-generation-test-annotation-english)Annotation information for a single English sentence from the Europarle dataset.

| doc_id| sid|tid |token   |token_with_ws |lemma   |upos  |xpos |feats                         |tid_source |relation  |
|------:|---:|:---|:-------|:-------------|:-------|:-----|:----|:-----------------------------|:----------|:---------|
|      6|   1|1   |Please  |Please        |please  |INTJ  |UH   |NA                            |2          |discourse |
|      6|   1|2   |rise    |rise          |rise    |VERB  |VB   |Mood=Imp&#124;VerbForm=Fin    |0          |root      |
|      6|   1|3   |,       |,             |,       |PUNCT |,    |NA                            |2          |punct     |
|      6|   1|4   |then    |then          |then    |ADV   |RB   |PronType=Dem                  |10         |advmod    |
|      6|   1|5   |,       |,             |,       |PUNCT |,    |NA                            |10         |punct     |
|      6|   1|6   |for     |for           |for     |ADP   |IN   |NA                            |10         |case      |
|      6|   1|7   |this    |this          |this    |DET   |DT   |Number=Sing&#124;PronType=Dem |8          |det       |
|      6|   1|8   |minute  |minute        |minute  |NOUN  |NN   |Number=Sing                   |10         |nmod:poss |
|      6|   1|9   |'s      |'s            |'s      |PART  |POS  |NA                            |8          |case      |
|      6|   1|10  |silence |silence       |silence |NOUN  |NN   |Number=Sing                   |2          |conj      |
|      6|   1|11  |.       |.             |.       |PUNCT |.    |NA                            |2          |punct     |

There is quite a bit of information which is returned from `cnlp_annotate()`. First note that the input sentence has been tokenized by word. Each token includes the token, lemma, part of speech (`upos` and `xpos`), morphological features (`feats`), and syntactic relationships (`tid_source` and `relation`). It is also key to note that the `doc_id`, `sid` and `tid` maintain the relational attributes from the original dataset --and therefore maintains our annotated dataset in tidy format.


Let's now annotate the same sentence from the Europarle corpus for the Source ('Spanish') and note the similarities and differences.


```r
spa_model <- load_model_udpipe("spanish") # load and initialize the language model, 'spanish' in this case.

spa_annotation <- 
  europarle %>% # dataset 
  filter(type == "Source" & sentence_id == 6) %>% # select Spanish and sentence_id 6
  cnlp_annotate(text_name = "sentence", # input text (sentence)
                doc_name = "sentence_id") # specify the grouping column (sentence_id)
```


Table: (\#tab:td-generation-test-annotation-spanish)Annotation information for a single Spanish sentence from the Europarle dataset.

| doc_id| sid|tid |token    |token_with_ws |lemma    |upos  |xpos |feats                                                                                           |tid_source |relation |
|------:|---:|:---|:--------|:-------------|:--------|:-----|:----|:-----------------------------------------------------------------------------------------------|:----------|:--------|
|      6|   1|1   |Invito   |Invito        |Invito   |VERB  |NA   |Gender=Masc&#124;Number=Sing&#124;VerbForm=Fin                                                  |0          |root     |
|      6|   1|2   |a        |a             |a        |ADP   |NA   |NA                                                                                              |3          |case     |
|      6|   1|3   |todos    |todos         |todo     |PRON  |NA   |Gender=Masc&#124;Number=Plur&#124;PronType=Tot                                                  |1          |obj      |
|      6|   1|4   |a        |a             |a        |ADP   |NA   |NA                                                                                              |7          |mark     |
|      6|   1|5   |que      |que           |que      |SCONJ |NA   |NA                                                                                              |4          |fixed    |
|      6|   1|6   |nos      |nos           |yo       |PRON  |NA   |Case=Acc,Dat&#124;Number=Plur&#124;Person=1&#124;PrepCase=Npr&#124;PronType=Prs&#124;Reflex=Yes |7          |iobj     |
|      6|   1|7   |pongamos |pongamos      |pongar   |VERB  |NA   |Mood=Ind&#124;Number=Plur&#124;Person=1&#124;Tense=Pres&#124;VerbForm=Fin                       |1          |advcl    |
|      6|   1|8   |de       |de            |de       |ADP   |NA   |NA                                                                                              |9          |case     |
|      6|   1|9   |pie      |pie           |pie      |NOUN  |NA   |Gender=Masc&#124;Number=Sing                                                                    |7          |obl      |
|      6|   1|10  |para     |para          |para     |ADP   |NA   |NA                                                                                              |11         |mark     |
|      6|   1|11  |guardar  |guardar       |guardar  |VERB  |NA   |VerbForm=Inf                                                                                    |1          |advcl    |
|      6|   1|12  |un       |un            |uno      |DET   |NA   |Definite=Ind&#124;Gender=Masc&#124;Number=Sing&#124;PronType=Art                                |13         |det      |
|      6|   1|13  |minuto   |minuto        |minuto   |NOUN  |NA   |Gender=Masc&#124;Number=Sing                                                                    |11         |obj      |
|      6|   1|14  |de       |de            |de       |ADP   |NA   |NA                                                                                              |15         |case     |
|      6|   1|15  |silencio |silencio      |silencio |NOUN  |NA   |Gender=Masc&#124;Number=Sing                                                                    |13         |nmod     |
|      6|   1|16  |.        |.             |.        |PUNCT |NA   |NA                                                                                              |1          |punct    |

For the Spanish version of this sentence, we see the same variables. However, the `feats` variable has morphological information which is specific to Spanish --notably gender and mood. 

\BeginKnitrBlock{rmdtip}<div class="rmdtip">The rsyntax package [@R-rsyntax] can be used to recode and extract patterns from the output from automatic linguistic annotations using cleanNLP. [See the documentation for more information](https://github.com/vanatteveldt/rsyntax).</div>\EndKnitrBlock{rmdtip}


<!-- Consider:


- Europarle Corpus, syntactic annotation

- Syntactic parsing for last.fm music lyrics, phrasal verbs (compound:prt) a la [@Akbary2018], with automated approach
- SOTU Corpus, frequency weighting and scaling for clustering algorithm?
- ...


The process of generation aims to _augment_ a variable or set of variables. In essence this aims to make implicit attributes explicit to that they are directly accessible. This often targeted at the automatic generation of linguistic annotations such as grammatical category (part-of-speech) or syntactic structure. 


-->

## Merge

One final class of transformations that can be applied to curated datasets to enhance their informativeness for a research project is the process of merging two or more datasets. To merge datasets it is required that the datasets share one or more attributes. With a common attribute two datasets can be joined to coordinate the attributes of one dataset with the other effectively adding attributes and one dataset with extended information. Another approach is to join datasets with the goal of filtering one of the datasets given the matching attribute. 

Let's see this in practice. Take the `lastfm` dataset. Let's tokenize the dataset into words, using `unnest_tokens()` such that our unit of observation is words. 


```r
lastfm_words <- 
  lastfm %>% # dataset
  unnest_tokens(output = "word", # output column
                input = "lyrics", # input column
                token = "words") # tokenized unit (words)

lastfm_words %>% # dataset
  slice_head(n = 10) %>% # first 10 observations
  kable(booktabs = TRUE,
        caption = "First 10 observations for `lastfm_words` dataset.")
```



Table: (\#tab:unnamed-chunk-5)First 10 observations for `lastfm_words` dataset.

|artist       |song         |genre   |word      |
|:------------|:------------|:-------|:---------|
|Alan Jackson |Little Bitty |country |have      |
|Alan Jackson |Little Bitty |country |a         |
|Alan Jackson |Little Bitty |country |little    |
|Alan Jackson |Little Bitty |country |love      |
|Alan Jackson |Little Bitty |country |on        |
|Alan Jackson |Little Bitty |country |a         |
|Alan Jackson |Little Bitty |country |little    |
|Alan Jackson |Little Bitty |country |honeymoon |
|Alan Jackson |Little Bitty |country |you       |
|Alan Jackson |Little Bitty |country |got       |

Consider the `get_sentiments()` function which returns words which have been classified as 'positive'- or 'negative'-biased, if the lexicon is set to 'bing' [@Hu2004].


```r
sentiments_bing <- get_sentiments(lexicon = "bing")  # get 'bing' lexicon

sentiments_bing %>%
    slice_head(n = 10)  # preview first 10 observations
#> # A tibble: 10 × 2
#>    word        sentiment
#>    <chr>       <chr>    
#>  1 2-faces     negative 
#>  2 abnormal    negative 
#>  3 abolish     negative 
#>  4 abominable  negative 
#>  5 abominably  negative 
#>  6 abominate   negative 
#>  7 abomination negative 
#>  8 abort       negative 
#>  9 aborted     negative 
#> 10 aborts      negative
```
Since the `sentiments_bing` dataset and the `lastfm_words` dataset both share a column `word` (which has the same type of values) we can join these two datasets. The `sentiments_bing` dataset has 6786 unique words. Let's check how many distinct words our `lastfm_words` dataset has. 



```r
lastfm_words %>% # dataset
  distinct(word) %>% # find unique words
  nrow() # count distinct rows/ words
#> [1] 4614
```

One thing to note is that the `sentiments_bing` dataset does not include function words, that is words that are associated with closed-class categories (pronouns, determiners, prepositions, etc.) as these words do not have semantic content along the lines of positive and negative. So many of the words that appear in the `lastfm_words` will not be matched. Other thing to note is that the `sentiments_bing` lexicon will undoubtly have words that do not appear in the `lastfm_words` and vice versa. 

If we want to keep all the words in the `lastfm_words` and add the sentiment information for those words that do match in both datasets, we can use the `left_join()` function. `lastfm_words` will be the dataset on the 'left' and therefore all rows in this dataset will be retained.


```r
left_join(lastfm_words, sentiments_bing) %>% 
  slice_head(n = 10) %>% # first 10 observations
  kable(booktabs = TRUE,
        caption = "First 10 observations for the `lastfm_words` sentiments_bing` left join.")
```



Table: (\#tab:td-lastfm-words-bing-left-joing)First 10 observations for the `lastfm_words` sentiments_bing` left join.

|artist       |song         |genre   |word      |sentiment |
|:------------|:------------|:-------|:---------|:---------|
|Alan Jackson |Little Bitty |country |have      |NA        |
|Alan Jackson |Little Bitty |country |a         |NA        |
|Alan Jackson |Little Bitty |country |little    |NA        |
|Alan Jackson |Little Bitty |country |love      |positive  |
|Alan Jackson |Little Bitty |country |on        |NA        |
|Alan Jackson |Little Bitty |country |a         |NA        |
|Alan Jackson |Little Bitty |country |little    |NA        |
|Alan Jackson |Little Bitty |country |honeymoon |NA        |
|Alan Jackson |Little Bitty |country |you       |NA        |
|Alan Jackson |Little Bitty |country |got       |NA        |

So we see that quite a few of the words from `lastfm_words` are not matched. To focus in on those words in `lastfm_words` that do match, we'll run the same join operation and filter for rows where `sentiment` is not empty (i.e. that there is a match in the `sentiments_bing` lexicon). 


```r
left_join(lastfm_words, sentiments_bing) %>%
  filter(sentiment != "") %>% # return matched sentiments
  slice_head(n = 10) %>% # first 10 observations
  kable(booktabs = TRUE,
        caption = "First 10 observations for the `lastfm_words` sentiments_bing` left join.")
```



Table: (\#tab:td-lastfm-words-bing-left-joing-filter)First 10 observations for the `lastfm_words` sentiments_bing` left join.

|artist       |song         |genre   |word  |sentiment |
|:------------|:------------|:-------|:-----|:---------|
|Alan Jackson |Little Bitty |country |love  |positive  |
|Alan Jackson |Little Bitty |country |well  |positive  |
|Alan Jackson |Little Bitty |country |well  |positive  |
|Alan Jackson |Little Bitty |country |well  |positive  |
|Alan Jackson |Little Bitty |country |smile |positive  |
|Alan Jackson |Little Bitty |country |well  |positive  |
|Alan Jackson |Little Bitty |country |well  |positive  |
|Alan Jackson |Little Bitty |country |well  |positive  |
|Alan Jackson |Little Bitty |country |smile |positive  |
|Alan Jackson |Little Bitty |country |good  |positive  |

Let's turn to another type of join: an anti-join. The purpose of an anti-join is to eliminate matches. This makes sense for a quick and dirty approach to removing function words (i.e. those grammatical words with little semantic content). In this case we use the `get_stopwords()` function to get the dataset. We'll specify English as the language and we'll use the default lexicon ('Snowball'). 


```r
english_stopwords <- get_stopwords(language = "en", )  # get English stopwords from the Snowball lexicon

english_stopwords %>%
    slice_head(n = 10)  # preview first 10 observations
#> # A tibble: 10 × 2
#>    word      lexicon 
#>    <chr>     <chr>   
#>  1 i         snowball
#>  2 me        snowball
#>  3 my        snowball
#>  4 myself    snowball
#>  5 we        snowball
#>  6 our       snowball
#>  7 ours      snowball
#>  8 ourselves snowball
#>  9 you       snowball
#> 10 your      snowball
```

Now if we want to eliminate stopwords from our `lastfm_words` dataset we use `anti_join()`. All the observations in the `lastfm_words` where there is not a match in `english_stopwords` will be returned. 


```r
anti_join(lastfm_words, english_stopwords) %>%
    slice_head(n = 10) %>%
    kable(booktabs = TRUE, caption = "First 10 observations in `lastfm_words` after filtering for English stopwords.")
```



Table: (\#tab:td-lastfm-words-stopwords-anti-join)First 10 observations in `lastfm_words` after filtering for English stopwords.

|artist       |song         |genre   |word      |
|:------------|:------------|:-------|:---------|
|Alan Jackson |Little Bitty |country |little    |
|Alan Jackson |Little Bitty |country |love      |
|Alan Jackson |Little Bitty |country |little    |
|Alan Jackson |Little Bitty |country |honeymoon |
|Alan Jackson |Little Bitty |country |got       |
|Alan Jackson |Little Bitty |country |little    |
|Alan Jackson |Little Bitty |country |dish      |
|Alan Jackson |Little Bitty |country |got       |
|Alan Jackson |Little Bitty |country |little    |
|Alan Jackson |Little Bitty |country |spoon     |

We can also merge datasets that we generate in our analysis or that we import from other sources. This can be useful when there are cases in which a corpus has associated metadata that is contained in files separate from the corpus itself. This is the case for the Switchboard Dialogue Act Corpus. 

Our existing, disfluency recoded, version includes the following variables. 


```r
sdac_disfluencies %>% # dataset
  slice_head(n = 10) # preview first 10 observations
#> # A tibble: 10 × 5
#>    doc_id speaker_id utterance_text                                 filler count
#>     <dbl>      <dbl> <chr>                                          <chr>  <int>
#>  1   4325       1632 Okay.  /                                       uh         0
#>  2   4325       1632 Okay.  /                                       um         0
#>  3   4325       1632 {D So, }                                       uh         0
#>  4   4325       1632 {D So, }                                       um         0
#>  5   4325       1519 [ [ I guess, +                                 uh         0
#>  6   4325       1519 [ [ I guess, +                                 um         0
#>  7   4325       1632 What kind of experience [ do you, + do you ] … uh         0
#>  8   4325       1632 What kind of experience [ do you, + do you ] … um         0
#>  9   4325       1519 I think, ] + {F uh, } I wonder ] if that work… uh         1
#> 10   4325       1519 I think, ] + {F uh, } I wonder ] if that work… um         0
```


The [online documentation page](https://catalog.ldc.upenn.edu/docs/LDC97S62/) provides a key file `caller_tab.csv` which contains speaker metadata information. Included in this `.csv` file is a column `caller_no` which contains the `speaker_id` we currently have in the `sdac_disfluencies` dataset. Let's read this file into our R session renaming `caller_no` to `speaker_id` to prepare to join these datasets. 


```r
sdac_speaker_meta <- 
  read_csv(file = "https://catalog.ldc.upenn.edu/docs/LDC97S62/caller_tab.csv", 
           col_names = c("speaker_id", # changed from `caller_no`
                         "pin",
                         "target",
                         "sex",
                         "birth_year",
                         "dialect_area",
                         "education",
                         "ti",
                         "payment_type",
                         "amt_pd",
                         "con",
                         "remarks",
                         "calls_deleted",
                         "speaker_partition"))

glimpse(sdac_speaker_meta)
#> Rows: 543
#> Columns: 14
#> $ speaker_id        <dbl> 1000, 1001, 1002, 1003, 1004, 1005, 1007, 1008, 1010…
#> $ pin               <dbl> 32, 102, 104, 5656, 123, 166, 274, 322, 445, 461, 57…
#> $ target            <chr> "N", "N", "N", "N", "N", "Y", "N", "N", "N", "N", "Y…
#> $ sex               <chr> "FEMALE", "MALE", "FEMALE", "MALE", "FEMALE", "FEMAL…
#> $ birth_year        <dbl> 1954, 1940, 1963, 1947, 1958, 1956, 1965, 1939, 1932…
#> $ dialect_area      <chr> "SOUTH MIDLAND", "WESTERN", "SOUTHERN", "NORTH MIDLA…
#> $ education         <dbl> 1, 3, 2, 2, 2, 2, 2, 1, 1, 2, 2, 1, 2, 2, 3, 3, 2, 3…
#> $ ti                <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0…
#> $ payment_type      <chr> "CASH", "GIFT", "GIFT", "NONE", "GIFT", "GIFT", "CAS…
#> $ amt_pd            <dbl> 15, 10, 11, 7, 11, 22, 20, 3, 11, 9, 25, 9, 1, 16, 1…
#> $ con               <chr> "N", "N", "N", "Y", "N", "Y", "N", "Y", "N", "N", "N…
#> $ remarks           <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
#> $ calls_deleted     <dbl> 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0…
#> $ speaker_partition <chr> "DN2", "XP", "XP", "DN2", "XP", "ET", "DN1", "DN1", …
```

Now to join the `sdac_disfluencies` and `sdac_speaker_meta`. Let's turn to `left_join()` again as we want to retain all the observations (rows) from `sdac_disfluencies` and add the columns for `sdac_speaker_meta` where the `speaker_id` column values match. 


```r
sdac_disfluencies <- left_join(sdac_disfluencies, sdac_speaker_meta)  # join by ``speaker_id`

glimpse(sdac_disfluencies)
#> Rows: 447,212
#> Columns: 18
#> $ doc_id            <dbl> 4325, 4325, 4325, 4325, 4325, 4325, 4325, 4325, 4325…
#> $ speaker_id        <dbl> 1632, 1632, 1632, 1632, 1519, 1519, 1632, 1632, 1519…
#> $ utterance_text    <chr> "Okay.  /", "Okay.  /", "{D So, }", "{D So, }", "[ […
#> $ filler            <chr> "uh", "um", "uh", "um", "uh", "um", "uh", "um", "uh"…
#> $ count             <int> 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0…
#> $ pin               <dbl> 7713, 7713, 7713, 7713, 775, 775, 7713, 7713, 775, 7…
#> $ target            <chr> "N", "N", "N", "N", "N", "N", "N", "N", "N", "N", "N…
#> $ sex               <chr> "FEMALE", "FEMALE", "FEMALE", "FEMALE", "FEMALE", "F…
#> $ birth_year        <dbl> 1962, 1962, 1962, 1962, 1971, 1971, 1962, 1962, 1971…
#> $ dialect_area      <chr> "WESTERN", "WESTERN", "WESTERN", "WESTERN", "SOUTH M…
#> $ education         <dbl> 2, 2, 2, 2, 1, 1, 2, 2, 1, 1, 2, 2, 1, 1, 1, 1, 1, 1…
#> $ ti                <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0…
#> $ payment_type      <chr> "CASH", "CASH", "CASH", "CASH", "CASH", "CASH", "CAS…
#> $ amt_pd            <dbl> 10, 10, 10, 10, 4, 4, 10, 10, 4, 4, 10, 10, 4, 4, 4,…
#> $ con               <chr> "Y", "Y", "Y", "Y", "Y", "Y", "Y", "Y", "Y", "Y", "Y…
#> $ remarks           <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
#> $ calls_deleted     <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0…
#> $ speaker_partition <chr> "UNC", "UNC", "UNC", "UNC", "UNC", "UNC", "UNC", "UN…
```

Now there are some metadata columns we may want to keep and others we may want to drop as they may not be of importance for our analysis. I'm going to assume that we want to keep `sex`, `birth_year`, `dialect_area`, and `education` and drop the rest. 


```r
sdac_disfluencies <- 
  sdac_disfluencies %>% # dataset
  select(doc_id:count, sex:education) # subset key columns
```


Table: (\#tab:td-sdac-disfluencies-meta-preview)First 10 observations for the `sdac_disfluencies` dataset with speaker metadata.

| doc_id| speaker_id|utterance_text                                                             |filler | count|sex    | birth_year|dialect_area  | education|
|------:|----------:|:--------------------------------------------------------------------------|:------|-----:|:------|----------:|:-------------|---------:|
|   4325|       1632|Okay.  /                                                                   |uh     |     0|FEMALE |       1962|WESTERN       |         2|
|   4325|       1632|Okay.  /                                                                   |um     |     0|FEMALE |       1962|WESTERN       |         2|
|   4325|       1632|{D So, }                                                                   |uh     |     0|FEMALE |       1962|WESTERN       |         2|
|   4325|       1632|{D So, }                                                                   |um     |     0|FEMALE |       1962|WESTERN       |         2|
|   4325|       1519|[ [ I guess, +                                                             |uh     |     0|FEMALE |       1971|SOUTH MIDLAND |         1|
|   4325|       1519|[ [ I guess, +                                                             |um     |     0|FEMALE |       1971|SOUTH MIDLAND |         1|
|   4325|       1632|What kind of experience [ do you, + do you ] have, then with child care? / |uh     |     0|FEMALE |       1962|WESTERN       |         2|
|   4325|       1632|What kind of experience [ do you, + do you ] have, then with child care? / |um     |     0|FEMALE |       1962|WESTERN       |         2|
|   4325|       1519|I think, ] + {F uh, } I wonder ] if that worked. /                         |uh     |     1|FEMALE |       1971|SOUTH MIDLAND |         1|
|   4325|       1519|I think, ] + {F uh, } I wonder ] if that worked. /                         |um     |     0|FEMALE |       1971|SOUTH MIDLAND |         1|



<!-- Consider:

- sentiment lexicons
- 
- Switchboard Dialog Act Corpus, stand-off meta-data files
- 


The process of merging aims to _join_ a variable or set of variables with another variable or set of variables from another dataset. The option to merge two (or more) datasets requires that there is a shared variable that indexes and aligns the datasets. 

-->

## Documentation

Documentation of the transformed dataset is just as important as the curated dataset. Therefore we use the same process as covered in the previous chapter. First we write the transformed dataset to disk and then we work to provide a data dictionary for this dataset. I've included the `data_dic_starter()` custom function to apply to our dataset(s). 


```r
data_dic_starter <- function(data, file_path) {
  # Function:
  # Creates a .csv file with the basic information
  # to document a curated dataset
  
  tibble(variable_name = names(data), # column with existing variable names 
       name = "", # column for human-readable names
       description = "") %>% # column for prose description
  write_csv(file = file_path) # write to disk
}
```

Let's apply our function to the `sdac_disfluencies` dataset using the R console (not part of our project script to avoid overwriting our documentation!).


```r
data_dic_starter(data = sdac_disfluencies, file_path = "../data/derived/sdac/data_dictionary_sdac_disfluencies.csv")
```

```bash
data/derived/
└── sdac/
    ├── data_dictionary_sdac.csv
    ├── data_dictionary_sdac_disfluencies.csv
    ├── sdac_curated.csv
    └── sdac_transformed_disfluencies.csv
```

Open the `data_dictionary_sdac_disfluencies.csv` file in spreadsheet software and add the relevant description of the dataset. 

## Summary {-}

In this chapter we covered the process of transforming datasets. The goal is to manipulate the curated dataset to make it align better for analysis. 
There are four general types of transformation steps: normalization, recoding, generation, and merging. In any given research project some or all of these steps will be employed --but not necessarily in the order presented in this chapter. Furthermore there may also be various datasets generated in at this stage each with a distinct analysis focus in mind. In any case it is important to write these datasets to disk and to document them according to the principles that we have established in the previous chapter. 

This chapter concludes the section on data/ dataset preparation. The next section we turn to analyzing datasets. This is the stage where we interrogate the datasets to derive knowledge and insight either through inference, prediction, and/ or exploratory methods.


