#7012 Problem Set 1
#Mallory Hoffman
#8.29.2020

#Imports data that I will be working with from my 'documents' folder#
load("Documents/7012/anes_pilot_2019.RData")

#Shows us that the total number of observations is 3165
nrow(data)

#Shows the total number of variables in the data set: 900
ncol(data)

#Shows us the names of the variables in the data set
names(data)

#Since there is no column for age, need to make one by selecting the data set, renaming it 'age' and subtracting the birthyear from 2020. 
age <- 2020-data$birthyr

#Find the median age from our newly made column: 56
median(age)

#Create a histogram of age values
hist(age)

#To find missing values in our variable list
table(data$vote16)
#Should show us that 603 values are missing

#Recode these values by indexing
data$vote16[data$vote16 == -1] <- NA

#Make a new histogram with missing values removed
hist(data$vote16)

#Create table of variable "liveurban" by accessing the column
table(data$liveurban)
#Our respondents are most likely to live in the suburbs, according to the guide on page 8

#Create a two-way table with liveurban and vote20jb
table(data$liveurban, data$vote20jb)
#According to page 8 and page 20 of the guide, rural respondents are more likely to vote for Trump. Urban voted for Joe Biden

#Interesting poll 1: Favor, oppose, or neither, allowing refugees to enter country
table(data$refugees)
#Shows not a lot of variance, but the highest answers were between neither favor nor oppose at choice 4, or favor a great deal

#Interesting poll 2: What should happen to immigrants who were brought to the US illegaly as a child?
table(data$dreamer)
#Most people responded that they should be allowed to live and work in the US (2287 responses)

#Interesting poll 3: How much is this country a threat to the security of the United States? (Iran)
table(data$tiran)
#Of those that answered, most say that it is a threat by a great deal, but there isn't a lot of variance between the answers (at least not what looks significant)


