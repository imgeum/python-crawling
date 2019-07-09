# install.packages("wordcloud2")
# install.packages("rJava")
# install.packages('tidyverse')


library(tidyverse)

# install.packages("installr")
# library(installr)
# installr::install.java()
library(rJava)

# htmlwidgets, htmltools, jsonlite, yaml, base64enc
# # for img wordcloud2
# library(htmlwidgets)
# library(htmltools)
# library(jsonlite)
# library(yaml)
# library(base64enc)

require(devtools)
install_github("lchiffon/wordcloud2")
library(wordcloud2)

library(RColorBrewer)
library(KoNLP)
library(stringr)
library(dplyr)

library(reshape2)
library(data.table)


useSejongDic()
# useNIADic()

# csv to str
#Sys.setlocale("LC_ALL", "C")
comment_datas <- read.csv("data/movie_comment.csv", header = T, fileEncoding="UTF-8")
comment_df <- comment_datas %>% select('cmt')

comment_str <- toString(comment_df)
comment_list <- as.list(comment_df)
# head(comment_list$cmt)
comment_str <- paste(unlist(comment_list$cmt), collapse='')

#########
### data processing
#########

# extract Noun
words <- sapply(comment_str, extractNoun, USE.NAMES = F)
# filter over 15
words_filtered <- Filter(function(x) {nchar(x) <= 15}, words)
words_filtered <- Filter(function(x) {nchar(x) >= 2}, words)
words_filtered <- str_replace_all(words_filtered, "[^[:alpha:]]", "")  # 한글, 영어외는 삭제

words_filtered <- gsub("영화", "", words_filtered)
words_filtered <- gsub("관람객", "", words_filtered) #17087 -> 16730
words_filtered <- gsub("점", "", words_filtered)
words_filtered <- gsub("것", "", words_filtered)
words_filtered <- gsub("이", "", words_filtered)
words_filtered <- gsub("점", "", words_filtered)
words_filtered <- gsub("들", "", words_filtered)
words_filtered <- gsub("듯", "", words_filtered)
words_filtered <- gsub("평", "", words_filtered)
words_filtered <- gsub("한", "", words_filtered)
words_filtered <- gsub("수", "", words_filtered)
words_filtered <- gsub("중", "", words_filtered)
words_filtered <- gsub("만", "", words_filtered)
words_filtered <- gsub("나", "", words_filtered) #15975
words_filtered <- gsub("별", "", words_filtered) 
words_filtered <- gsub("데", "", words_filtered) 
words_filtered <- gsub("뭐", "", words_filtered) 
words_filtered <- gsub("", "", words_filtered) 


write(unlist(words_filtered),"data/filtered_comment.txt") 

read_filtered_words <- read.table("data/filtered_comment.txt")

# filtering words
table_words <- table(read_filtered_words)
# show word numbers : 17087
nrow(table_words)

head(sort(table_words, decreasing=T), 50)
# top 200 words 

wordcount <- head(sort(table_words,decreasing=T), 50)

#default wordcloud
wordcloud2(wordcount)

# wordcloud2(demoFreq, figPath = "./img/cpt1.png", size = 1.5, color = "skyblue")


wordcloud2(wordcount, figPath = "./img/twitter.png", size = 1.5, color = "skyblue")
#

# SimplePos09("최대한 친절하게 쓴 R")

# nrow(data4)
# wordcount <- table(data4)
# head(sort(wordcount, decreasing=T), 30)
# 
# palete <- brewer.pal(9, "Set3")
# 
# wordcloud2(wordcount, size=0.5, col=random)