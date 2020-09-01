# Evan Statile 
# Spetember 2, 2020
# POLS 7012
# Dr. Ornstein
# Problem Set 1

# Loading in the data set
#load("/Users/evanstatile/Desktop/anes_pilot_2019.RData")

# Narrowing down the data set 
nrow(data)
## There are 3165 observations in this data set 

# Counting the number of columns in the data set 
ncol(data)
## There are 900 columns in this data set 

# Finding the names of the variables 
names(data)
## First five are "version", "caseid", "weight", "weight_spss", and "form"

# Creating a variable for age by subtracting 2020 by birthyr
x = 2020
birthyr = data$birthyr
age = x - birthyr

# Finding the median age of survey respondents 
median(age)
## 56 years old

# Creating a histogram of age 
hist(age)

# Finding missing values in variable vote16
table(data$vote16)
## There were 603 missing values 

# Hiding the missing values from our table 
data$vote16[data$vote16 == -1] = NA
table (data$vote16)
## Only 1, 2, and 3 show up. The missing values are no longer present 

# Creating a table for the variable liveurban
table(data$liveurban)
## 643 live in rural areas, 589 live in small town, 1117 live in suburb, 816 live in city 

# Creating a two way table for variables liveurban and vote20jb
table(data$liveurban, data$vote20jb)
## Rural areas vote for Donald Trump 
## Small towns vote for Donald Trump 
## Suburbs vote for Donald Trump 
## Cities vote for Joe Biden 

# Looking at the mean value of people's self reported political leanings on a scale of 1 (very liberal) to 7 (very conservative)
mean(data$lcself)
## the mean is 4.11, people surveyed are slightly more conservative 

# Looking at a table of people's responses on proposals to combat climate change
table(data$gw1)
## Most people strongly support legislation to combat climate change 

# A table to look at what respondants thought the federal government spent the most on
table(data$pk_spend)
## Most people think we spend the most on foreign aid (1) and social security (4). 
## Fewest people think we spend the most on national defense (3)