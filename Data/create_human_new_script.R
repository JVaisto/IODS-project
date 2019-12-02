#Juuso Väistö, 2.12.2019 "New script file for data wrangling exercise"
#Data source: http://hdr.undp.org/en/content/human-development-index-hdi

#Downloading the data
human <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt", header = TRUE, sep = ",")

#Inspecting structure and dimensions
str(human)
dim(human)

#195 observation (rows) and 19 variables (columns)

#Mutating variable "GNI" to numeric
library(stringr)
library(dplyr)
human$GNI <- str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric

#Selecting variables "Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F"
human <- dplyr::select(human, one_of(c("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")))

#Excluding missing cases
human <- filter(human, complete.cases(human) == TRUE)

#Removing observations which relate to regions instead of countries
human <- human[1:155, ]

#Defining row names of the data by the country names and removing the country name column from the data
rownames(human) <- human$Country
human <- human[ , 2:9]

#Saving the data
write.csv(human, file = "C:/Users/juusov/Documents/IODS-project/Data/human.csv")