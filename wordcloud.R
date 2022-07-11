#Load packages
library(tm)
library(wordcloud)
library(wordcloud2)

# https://www.kaggle.com/datasets/kabirnagpal/flipkart-customer-review-and-rating

#check current working directory
getwd()

#set working directory
setwd("D:/R Scripts/")

# 1. Import & Load data as a corpus 
data<-read.csv("data.csv",stringsAsFactors = FALSE)
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
textdata <- tm_map(textdata, stemDocument)

# Make term-document matrix

#A Term Document Matrix (tdm), which lists each term in a row, each document in a column, and the frequency of each term in each document in the cells, is then created. 
tdm <- TermDocumentMatrix(textdata)
matrix <- as.matrix(tdm)

# get Keywords count in decreasing order
keyword_freq = sort(rowSums(matrix), decreasing=TRUE) 
# create a data frame with keywords and their frequencies
df = data.frame(keyword=names(keyword_freq), freq=keyword_freq)

### 3. Create WordCloud 

wordcloud(words = df$keyword, freq = df$freq, min.freq = 10,
          max.words=200, random.order=FALSE, 
          colors="black")


wordcloud2(df, color = "random-light", backgroundColor = "white")

wordcloud2(df[1:150,], color = "random-dark", backgroundColor = "white")

wordcloud2(df[5:150,], shape = 'diamond', size = 0.5, color="#B20000")

wordcloud2(df[2:500,], fontFamily = 'Tahoma', size = 0.5, color = "random-light", backgroundColor = "white",fontWeight = "normal")

set.seed(123)
wordcloud2(df[5:500,], shape="star", fontFamily = 'franklin gothic', size = 0.5, color = "random-light", backgroundColor = "white",fontWeight = "normal")










#Error in if (grepl(tails, words[i])) ht <- ht + ht * 0.2 : argument is of length zero
#ans: check the column name


