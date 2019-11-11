# read the data into memory 
std14 <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/learning2014.txt", sep=",", header=TRUE)

#Explore structure and dimensions of the dataset
str(std14)
dim(std14)
summary(std14)

#The dataset include 7 variables (gender (factor), age (int), attitude (num), deep (num), stra(num), surf(num), and point(int)) and 166 observations. 

# Access the tidyverse libraries tidyr, dplyr, ggplot2
library(tidyr); library(dplyr); library(ggplot2); library(corrplot)

glimpse(std14)
gather(std14) %>% glimpse

# draw a bar plot of each variable and add frequency count labels above the bars
gather(std14) %>% ggplot(aes(value)) + facet_wrap("key", scales = "free") + geom_bar()+ geom_text(stat='count', aes(label=..count..), vjust=-1)

# convert gender as integer
std14$gender <- as.integer(std14$gender)

# calculate the correlation matrix and round it
cor.matrix <- cor(std14)
head(round(cor.matrix,2))
cor.matrix

# visualize the correlation matrix
corrplot(cor.matrix, method = "number")

# create a regression model with multiple explanatory variables
my_model1 <- lm(points ~ attitude + age + gender, data = std14)

# print out a summary of the model
summary(my_model1)

# draw diagnostic plots using the plot() function. Choose the plots Residuals vs Fitted values = 1, Normal QQ-plot = 2 and Residuals vs Leverage = 5
par(mfrow = c(2,2))
plot(my_model1, which = c(1,2,5))