# Juuso Väistö, 11.11.2019, Exercise 2. Data wrangling exercises and 2) data analysis exercises on the full learning2014 data

#Data wrangling

# read the data into memory 
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# Explore the dimensions of the data
dim(lrn14)

# Explore the structure of the data
str(lrn14)

# The data frame is used for storing data tables. This table consist from 60 variables and 183 observations.  

# Create an analysis dataset with the variables gender, age, attitude, deep, stra, surf and points by combining questions in the learning2014 data.

# Access the dplyr library
library(dplyr)

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)

# choose a handful of columns to keep
keep_columns <- c("gender","Age","Attitude", "deep", "stra", "surf", "Points")

# select the 'keep_columns' to create a new dataset
analysis_dataset <- select(lrn14, one_of(keep_columns))

# select rows where points is greater than zero
analysis_dataset <- filter(analysis_dataset, Points > 0)

#Now data.frame analysis_dataset includes 166 obs. of  7 variables

# Save the analysis dataset to the ‘Data’ folder
write.csv(analysis_dataset, 'C:/Users/juusov/Documents/IODS-project/Data/analysis_dataset.csv')
