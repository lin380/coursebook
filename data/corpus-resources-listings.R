# ABOUT -------------------------------------------------------------------

# Description: A script to pull bookmarks from Pinboard.in
# Usage: Source this script with an internet connection
# Author: Jerid C. Francom
# Date: 2021-06-22

# NOTE:
# To re-run these to refresh the rds data
# then delete the rmarkdown chunk cache to update


# SETUP -------------------------------------------------------------------

pacman::p_load(tidyverse, jsonlite)

get_pinboard_info <- function(url) {
  document <- fromJSON(txt=url)
  document %>%
    mutate(Resource = paste0('<a href="', document$u, '">', document$d, '</a>')) %>%
    arrange(d) %>%
    select(Resource, Description = n)
}

# Repositories ------------------------------------------------------------

# Specify: textbook, repository, corpora
url <- "https://feeds.pinboard.in/json/secret:c2bbe3d128210109bb00/u:jerid.francom/t:textbook/t:repository/t:corpora/"

data_repositories <- get_pinboard_info(url)
saveRDS(data_repositories, "data/data_repositories.rds")

# Corpora -----------------------------------------------------------------

# Specify: textbook, data, corpora
url <- "https://feeds.pinboard.in/json/secret:c2bbe3d128210109bb00/u:jerid.francom/t:textbook/t:data/t:corpora/"

data_corpora <- get_pinboard_info(url)
saveRDS(data_corpora, "data/data_corpora.rds")


# R API interfaces --------------------------------------------------------

# Specify: textbook, language, api
url <- "https://feeds.pinboard.in/json/secret:c2bbe3d128210109bb00/u:jerid.francom/t:textbook/t:language/t:api/"

data_apis <- get_pinboard_info(url)
saveRDS(data_apis, "data/data_apis.rds")


# Experimental ------------------------------------------------------------

# Specify: textbook, data, experimental
url <- "https://feeds.pinboard.in/json/secret:c2bbe3d128210109bb00/u:jerid.francom/t:textbook/t:data/t:experimental/"

data_experimental <- get_pinboard_info(url)
saveRDS(data_experimental, "data/data_experimental.rds")

# Corpus listings ---------------------------------------------------------

# Specify: textbook, data, listing
url <- "https://feeds.pinboard.in/json/secret:c2bbe3d128210109bb00/u:jerid.francom/t:textbook/t:data/t:listing/"

data_listings <- get_pinboard_info(url)
saveRDS(data_listings, "data/data_listings.rds")







