#Load packages
library(dplyr) #for data manipulation
library(tidytext) #for n-grams
library(tidyr) #for separate() & unite() functions
library(readxl) #to read excel files
library(tm) #for text processing


#set working directory
setwd("D:/R Scripts/")

# 1. Import & Load data as a corpus 
setwd("C:/Users/Lenovo/Downloads")
data<-read_excel("premature_dump.xlsx", sheet="Sheet2")

data<-read.csv("data.csv")

textdata <- Corpus(VectorSource(data$review)) #from tm

# 2. Text processing

# Remove extra whitespace
textdata <- tm_map(textdata, stripWhitespace)
# Convert text to lowercase
textdata <- tm_map(textdata, tolower)
# Remove common English stopwords
textdata <- tm_map(textdata, removeWords, stopwords("english"))
# Remove punctuation marks
textdata <- tm_map(textdata, removePunctuation)
# Remove numbers
textdata <- tm_map(textdata, removeNumbers)
# Text Stemming: Reduce words to their root form
library(textstem)
textdata <- tm_map(textdata, lemmatize_strings)

df <- data.frame(text = get("content", textdata))
colnames(df)<-c("text")

#unigrams and their frequency
unigrams<-df%>%select(text)%>%unnest_tokens(unigram, text, token = "ngrams", n = 1)%>%count(unigram, sort = TRUE)
#renaming second column to frequency
names(unigrams)[2]<-"frequency"
#Remove keywords containing single character
unigrams<-unigrams%>%filter(nchar(unigram)>2)
#unigrams_cleaned <- unigrams %>%filter(!unigram %in% stop_words$word)
clipr::write_clip(unigrams) 



#bigrams and their frequency
bigrams<-df%>%select(text)%>%unnest_tokens(bigram, text, token = "ngrams", n = 2)%>%count(bigram, sort = TRUE)
#renaming second column to frequency
names(bigrams)[2]<-"frequency"

bigrams<-bigrams%>%filter(!is.na(bigram))

bigrams_split<-bigrams%>%separate(bigram, c("word1", "word2"), sep = " ")
bigrams_clean<-bigrams_split %>%filter(!nchar(word1)<=2) %>%filter(!nchar(word2)<=2)
bigrams_merge <- bigrams_clean %>%unite(bigram, word1, word2, sep = " ")

clipr::write_clip(bigrams_merge) 




#library(tidyr)
#bigrams_separated <- bigrams%>%separate(bigram, c("word1", "word2"), sep = " ")
#bigrams_filtered <- bigrams_separated %>%filter(!word1 %in% stop_words$word) %>%filter(!word2 %in% stop_words$word)

#bigram_counts <- bigrams_filtered %>% count(word1, word2, sort = TRUE)
#bigrams_united <- bigrams_filtered %>%unite(bigram, word1, word2, sep = " ")

bigrams_filtered <- bigrams %>%filter(!bigram %in% stop_words$word)

#trigrams and their frequency
trigrams<-df%>%select(text)%>%unnest_tokens(trigram, text, token = "ngrams", n = 3)%>%count(trigram, sort = TRUE)
#renaming second column to frequency
names(trigrams)[2]<-"frequency"

trigrams<-trigrams%>%filter(!is.na(trigram))
trigrams_split<-trigrams%>%separate(trigram, c("word1", "word2","word3"), sep = " ")
trigrams_clean<-trigrams_split %>%filter(!nchar(word1)<=2) %>%filter(!nchar(word2)<=2)%>%filter(!nchar(word3)<=2)
trigrams_merge <- trigrams_clean %>%unite(trigram, word1, word2, word3, sep = " ")

clipr::write_clip(trigrams_merge) 

