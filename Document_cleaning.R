###Installing and importing the necessary packages
install.packages("tidytext")   
library("tidytext")


### Reading all the text files in a folder, cleaning and concatenating them into a single text file

cname <- file.path("S:\\NEPTUNE\\cleaned\\wolf-creek")
docs <- Corpus(DirSource(cname))
docs <- tm_map(docs, removePunctuation)
docs <- tm_map(docs, removeNumbers)
docs <- tm_map(docs, tolower)
docs <- tm_map(docs, removeWords, stopwords("english"))
docs <- tm_map(docs, removeWords,c("i","me","my","myself","we","our","ours","ourselves","you","your","yours","yourself","yourselves","he","him","his","himself","she","her","hers","herself","it","its","itself","they","them","their","themselves","what","which","who","whom","this","that","these","those","am","don","ll","ain","aren","couldn","didn","doesn","hadn","hasn","haven","isn","david","texas","arlington","johnson","washington","norman","haller","victor","stello","richard","seyfrit","ili","jjj","itij","illjg","ail","vie","lfg","lulll","llj","lli","lij","ttl","rpnr","ltt","ilij","scr","rio","nof","npf","nos","january","february","march","april","may","june","july","august","september","october","november","december","russellville","tty","arkansas","uuina","olzlslolg","loiiolslslolg","ucdj","jad","cqii","ina","bll","ijna","toi","lqdj","ijng","ing","uiioooe","llij","llu","iti","urer","ajw","lui","ioo","igt","litile","ucnse","dear","sir","aiia","oaviia","aiii","sincerely","ijna","tty","ijjil","zjlzl","iiljj","phew","comm","pone","arkansas","beaver","braidwood","brunswick","byron","callaway","calvert","cliffs","catawba","clinton","comanche","cook","cooper","diablo","dresden","arnold","farley","fermi","fitzpatrick","calhoun","fort","ginna","gulf","hatch","hopecreek","indian","lasalle","limerick","mcguire","millstone","monticello","nine","mile","north","oconee","oyster","creek","palisedes","palo","verde","peachbottom","perry","pilgrim","riverbend","robinson","lucie","saintlucie","salem","seabrook","sequoyah","shoreham","southtexas","summer","surry","susquehanna","three","vermont","yankee","vogtle","waterford","wattsbar","wolfcreek"))
docs <- tm_map(docs, stripWhitespace)
writeLines(as.character(docs),con = "wolf - creek.txt")

###Implementing aggressive stop word list on all the combined Nuclear Power Plant text files

filenames <- list.files(path = "S:\\Topicmodelling\\Cleaned-aggressive-1",pattern="*.txt",all.files = TRUE,full.names = TRUE)

for (j in 1:length(filenames))
{
  files <- readLines(filenames[j])
  filename <- toString(filenames[j])
  filename_s <- gsub("[^a-zA-Z0-9\\s]", " ",filename)
  filename_t <- gsub("\\\\","",filename_s)
  filename_x <- gsub("S TopicmodellingCleaned aggressive 1 ","",filename_t)
  filename_y <- gsub("  txt","",filename_x)
  docs <- Corpus(VectorSource(files))
  docs <- tm_map(docs, removeWords,c("report","event","description","type","occurrence","code","number","licensee","action","pdr","license","power","technical","nuclear","unit","office","director","plant","date","activity","quadcities","quad","cities","quad cities"))
  docs <- tm_map(docs, stripWhitespace)
  writeLines(as.character(docs),con = paste("S:\\Topicmodelling\\cleaned-aggressive-final\\",filename_y,".txt"))
}