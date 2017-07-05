###installing the required packages

Needed <- c("tm","ggplot2","tidytext")
install.packages("topicmodels")

install.packages(Needed, dependencies=TRUE)   

library("tm")
library("ggplot2")
library("tidytext")
library("topicmodels")


### Taking the text files as input


#get listing of .txt files in directory

filenames <- list.files(path = "T:\\plant",pattern="*.txt",all.files = TRUE,full.names = TRUE)


#Creating a character vector
files <- lapply(filenames,readLines)


#create corpus from vector
docs <- Corpus(VectorSource(files))   


### Removing unnecessary symbols

#Removing punctuation
docs <- tm_map(docs, removePunctuation)

#Removing Numbers
docs <- tm_map(docs, removeNumbers)

#Converting to lowercase
docs <- tm_map(docs, tolower)

#Removing system defined stopwords
docs <- tm_map(docs, removeWords, stopwords("english"))

#Removing custom key words
customwords <- c("report","event","description","type","occurrence","code","number","licensee","action","pdr","license","power","technical","nuclear","unit","office","director","plant","date","activity")
docs <- tm_map(docs, removeWords, customwords)

#stem document
docs <- tm_map(docs, stemDocument)

#Removing excess white spaces
docs <- tm_map(docs, stripWhitespace)

#Creating Document Term Matrix 
dtm <- DocumentTermMatrix(docs)


### Topic Modelling
library(topicmodels)
#Set parameters for Gibbs sampling
burnin <- 4000
iter <- 2000
thin <- 500
seed <-list(2003,5,63,100001,765)
nstart <- 5
best <- TRUE

#Number of topics
k <- 5
#Run LDA using Gibbs sampling
ldaOut <-LDA(dtm,k, method="Gibbs", control=list(nstart=nstart, seed = seed, best=best, burnin = burnin, iter = iter, thin=thin))



#write out results
#docs to topics
ldaOut.topics <- as.matrix(topics(ldaOut))
write.csv(ldaOut.topics,file=paste("LDAGibbs",k,"DocsToTopics.csv"))

#top 6 terms in each topic
ldaOut.terms <- as.matrix(terms(ldaOut,6))
write.csv(ldaOut.terms,file=paste("LDAGibbs",k,"TopicsToTerms.csv"))

#probabilities associated with each topic assignment
topicProbabilities <- as.data.frame(ldaOut@gamma)
write.csv(topicProbabilities,file=paste("LDAGibbs",k,"TopicProbabilities.csv"))

#Find relative importance of top 2 topics
topic1ToTopic2 <- lapply(1:nrow(dtm),function(x)
sort(topicProbabilities[x,])[k]/sort(topicProbabilities[x,])[k-1])

#Find relative importance of second and third most important topics
topic2ToTopic3 <- lapply(1:nrow(dtm),function(x)
  sort(topicProbabilities[x,])[k-1]/sort(topicProbabilities[x,])[k-2])

#write to file
write.csv(topic1ToTopic2,file=paste("LDAGibbs",k,"Topic1ToTopic2.csv"))
write.csv(topic2ToTopic3,file=paste("LDAGibbs",k,"Topic2ToTopic3.csv"))
