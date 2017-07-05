install.packages("gplots")    #Installing and importing the necessary packages
library("gplots")
install.packages("RColorBrewer")
library("RColorBrewer")
install.packages("rje")
library("rje")
install.packages("pals")
library("pals")
install.packages("ooursa")
library("ursa")

data <- read.csv("T:\\sam\\Final_transposed.csv", header = TRUE)   # Reading the input into a dataframe


row.names(data) <- data$Topics   #Getting the row labels

data <- data[,2:63] #Getting the numerical data to generate heatmap
data_matrix <- as.matrix(data)

# Generating the heatmap
heatmap.2(data_matrix,Colv=NA, col = rev(helix) ,main = "Topic Modelling",scale = "column",density.info="none",margins=c(10,5),dendrogram = "row", trace="none")  #, scale="column"

#Customizing the heatmap with additional features
my_palette <- colorRampPalette(c("white", "blue4", "cyan"))(n=256)
hmcol<-brewer.pal(4,"RdBu")
helix <- cubeHelix(n=7, start= 0.0, r=0.4, gamma=1.0, hue=0.8)  #, light=0.85, dark=0.15, reverse=FALSE, as_cmap=FALSE
cm.colors(256)
dev.off()
