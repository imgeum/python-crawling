# install.packages("wordcloud2")
# install.packages("rJava")
# install.packages('tidyverse')


library(tidyverse)
library(rJava)
library(wordcloud2)
library(RColorBrewer)
library(KoNLP)
library(stringr)
library(data.table)
library(reshape2)
library(data.table)

useSejongDic()
# useNIADic()

# csv to str

Sys.setlocale("LC_ALL", "C")
comment_datas <- read.csv("data/movie_comment.csv", header = T, encoding = "UTF-8", nrows=200)
comment_df <- comment_datas %>% select('cmt')

comment_str <- toString(comment_df)
comment_list <- as.list(comment_df)
comment_str <- paste(unlist(comment_list), collapse='')

# 
words <- sapply(comment_str, extractNoun, USE.NAMES = F)
words_filtered <- Filter(function(x) {nchar(x) <= 15}, words)
words_filtered

# write.table(unlist(words_filtered), "data/comment_aft_proc.txt", fileEncoding="UTF-8")
# re_words <- fread("data/comment_aft_proc.txt", encoding="UTF-8")
# 
# wordcount <- table(re_words)
# head(sort(wordcount, decreasing=T), 30)





SimplePos09("최대한 친절하게 쓴 R")














# nrow(data4)
# wordcount <- table(data4)
# head(sort(wordcount, decreasing=T), 30)
# 
# palete <- brewer.pal(9, "Set3")
# 
# wordcloud2(wordcount, size=0.5, col=random)