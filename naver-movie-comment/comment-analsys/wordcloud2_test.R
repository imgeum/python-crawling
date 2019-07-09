require(devtools)
install_github("lchiffon/wordcloud2")
library(wordcloud2)

library(htmlwidgets)
library(htmltools)
library(jsonlite)
library(yaml)
library(base64enc)


read_filtered_words <- read.table("data/filtered_comment.txt")
table_words <- table(read_filtered_words)
wordcount <- head(sort(table_words,decreasing=T), 50)

wordcloud2(wordcount, figPath = "img/cpt1.png", size = 1.5,color = "skyblue")

#wordcloud2(demoFreq, figPath = "img/twitter.png", size = 1.5,color = "skyblue")