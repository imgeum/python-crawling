# install.packages("wordcloud2")
# install.packages("data.table")

library(rJava)
library(wordcloud2)
library(data.table)
library(RColorBrewer)
library(KoNLP)

useSejongDic()

getwd()
comment <- read.csv("data/movie_comment.csv", header = T, encoding = "UTF-8")

