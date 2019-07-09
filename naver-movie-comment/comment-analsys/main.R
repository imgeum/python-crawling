# install.packages("wordcloud2")
# install.packages("rJava")
# install.packages('tidyverse')


library(tidyverse)

library(rJava)
library(wordcloud2)
library(RColorBrewer)
library(KoNLP)
library(stringr)
library(dplyr)

library(data.table)
library(reshape2)
library(data.table)

useSejongDic()
# useNIADic()

# csv to str
comment_datas <- read.csv("data/movie_comment.csv", header = T, encoding = "UTF-8", nrows=4000)
comment_df <- comment_datas %>% select('cmt')

comment_str <- toString(comment_df)
comment_list <- as.list(comment_df)
# head(comment_list$cmt)
comment_str <- paste(unlist(comment_list$cmt), collapse='')

# 
words <- sapply(comment_str, extractNoun, USE.NAMES = F)
words_filtered <- Filter(function(x) {nchar(x) <= 15}, words)

table_words <- table(words_filtered)

# SimplePos09("최대한 친절하게 쓴 R")

# nrow(data4)
# wordcount <- table(data4)
# head(sort(wordcount, decreasing=T), 30)
# 
# palete <- brewer.pal(9, "Set3")
# 
# wordcloud2(wordcount, size=0.5, col=random)