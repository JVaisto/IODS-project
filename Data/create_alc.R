# Juuso Väistö, 12.11.2019, RStudio Exercise 3: Logistic regression and data wrangling, Data source: UCI Machine Learning Repository, Student Performance Data https://archive.ics.uci.edu/ml/datasets/Student+Performance

# Data wrangling

# read the data into memory 
stu_por <- read.csv("C:/Users/juusov/Documents/IODS-project/Data/student-por.csv", header = TRUE, sep = ";")
stu_mat <- read.csv("C:/Users/juusov/Documents/IODS-project/Data/student-mat.csv", header = TRUE, sep = ";")

# Explore the dimensions of the data
dim(stu_por)
dim(stu_mat)

# Explore the structure of the data
str(stu_por)
str(stu_mat)

# access the dplyr library
library(dplyr)

# common columns to use as identifiers
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

# join the two datasets by the selected identifiers
math_por <- inner_join(stu_mat, stu_por, by = join_by, suffix = c(".math",".por"))

# Explore the dimensions of the joined data
dim(math_por)

# Explore the structure of the joined data
str(math_por)

# create a new data frame with only the joined columns
alc <- select(math_por, one_of(join_by))

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(stu_mat)[!colnames(stu_mat) %in% join_by]

# print out the columns not used for joining
notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)

# glimpse at the data (Observation: 382, Variables: 35)
glimpse(alc)

# Save the analysis dataset to the ‘Data’ folder
write.csv(alc, "C:/Users/juusov/Documents/IODS-project/Data/alc.csv", row.names = FALSE)
