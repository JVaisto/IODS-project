#Juuso Väistö, 4.12.2019, RStudio Exercise 6, Analysis of longitudinal data, Data wrangling
#Data source: https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt
#             https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt

# Loading the data 
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", header = TRUE, sep = " ")
BPRS <- as.data.frame(BPRS)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep ="\t")
RATS <- as.data.frame(RATS)

# Look at the data in wide format
names(BPRS)
str(BPRS)
head(BPRS)
str(RATS)
names(RATS)
head(RATS)

# BPRS includes 40 obs. of  11 variables in wide format
# RATS includes 16 obs. of  13 variables in wide format

# Categorical variables to factor
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

# Converting data sets to from wide format to long format and mutate 'weeks' variable to BPRSL and 'Time' to RATSL
library(dplyr)
library(tidyr)
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks, 5, 5)))
RATSL <- RATS %>% gather(key = WD, value = Weight, -ID, -Group) %>% mutate(Time = as.integer(substr(WD, 3, 4)))

# Look at the data in long format
names(BPRSL)
str(BPRSL)
head(BPRSL)
str(RATSL)
names(RATSL)
head(RATSL)

# Now in LONG format BRPRSL includes 360 obs. of  5 variables and RATSL in LONG format includes 176 obs. of  5 variables


# Saving the data
write.csv(BPRS, file = "C:/Users/juusov/Documents/IODS-project/Data/BPRS.csv")
write.csv(BPRSL, file = "C:/Users/juusov/Documents/IODS-project/Data/BPRSL.csv")
write.csv(RATS, file = "C:/Users/juusov/Documents/IODS-project/Data/RATS.csv")
write.csv(RATSL, file = "C:/Users/juusov/Documents/IODS-project/Data/RATSL.csv")

