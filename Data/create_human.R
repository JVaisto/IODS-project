# Juuso Väistö, 25.11.2019, RStudio exercise 5: Dimensionality reduction techniques

# Data wrangling for the exercise

# Meta file for these datasets can be seen from here (http://hdr.undp.org/en/content/human-development-index-hdi) and here (http://hdr.undp.org/sites/default/files/hdr2015_technical_notes.pdf) are some technical notes

# Read the Human Development Index (hd) data into memory
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)

# Read the Gender Inequality (gii) data into memory
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# Explore the dimensions of the data
dim(hd)
dim(gii)

# Explore the structure of the data
str(hd)
str(gii)

# Summaries of the datasets
summary(hd)
summary(gii)

# access into libraries
library(dplyr)
library(stringr)

# Rename hd dataset long variable names 
hd <- rename(hd, HDI =  Human.Development.Index..HDI.,
             LEB = Life.Expectancy.at.Birth,
             EYE = Expected.Years.of.Education,
             MYE = Mean.Years.of.Education,
             GNI_per_Cap = Gross.National.Income..GNI..per.Capita,
             GNI_minus_HDI = GNI.per.Capita.Rank.Minus.HDI.Rank)

# Rename gii dataset long variable names 
gii <- rename(gii, GII = Gender.Inequality.Index..GII.,
              MMR = Maternal.Mortality.Ratio,
              ABR = Adolescent.Birth.Rate,
              PRP = Percent.Representation.in.Parliament,
              PSE_female = Population.with.Secondary.Education..Female.,
              PSE_male = Population.with.Secondary.Education..Male.,
              LFPR_female = Labour.Force.Participation.Rate..Female.,
              LFPR_male = Labour.Force.Participation.Rate..Male.)

# Ratio of Female and Male populations with secondary education in each country
gii <- mutate(gii, PSE_fm_ratio = PSE_female / PSE_male)

# Ratio of labour force participation of females and males in each country
gii <- mutate(gii, LFPR_fm_ratio = LFPR_female /  LFPR_male)

# Join the datasets
human <- inner_join(gii, hd, by = c("Country"))

# remove the commas from GNI and print out a numeric version of it
str_replace(human$GNI_per_Cap, pattern=",", replace ="") %>% as.numeric(human$GNI_per_Cap) 

#Selecting variables 
human <- dplyr::select(human, one_of(c("Country", "PSE_fm_ratio", "LFPR_fm_ratio", "LEB", "EYE", "GNI_per_Cap", "MMR", "ABR", "PRP")))

#Excluding missing cases
human <- filter(human, complete.cases(human) == TRUE)

#Removing observations which relate to regions instead of countries
human <- human[1:155, ]

#Defining row names of the data by the country names and removing the country name column from the data
rownames(human) <- human$Country
human <- human[ , 2:9]

#Saving the new data
write.csv(human, file = "C:/Users/juusov/Documents/IODS-project/Data/human.csv")
