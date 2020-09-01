# This script is for Problem Set 1, POLS7012
# Author: Jeff Hannon
# Version: 1.0
# Date: August 30, 2020

#Load the ANES_pilot dataset
"data/anes_pilot_2019.RData"

#How many observations (rows) in the data? Answer: 3,165
nrow(data)

#How many variables (columns) in the dataset? Answer: 900
ncol(data)

#What are the names of the variables in the dataset? Answer: Run to see the list.
names(data)

#Create a variable for the current age for the respondents as of 2020.
age <- 2020-data$birthyr

#What is the median age of the respondents as of 2020? Answer: 56 years old.
median(age)

#Generate a histogram of the age of the respondents as of 2020.  Answer: Run to see the histogram.
hist(age)

#How many respondents skipped answering the question "vote16"?
table(data$vote16)
#The table result shows the number of respondents who voted for Trump, Clinton, or another candidate; it does not show null responses.

#Index the null responses (-1 in the AMES pilot)
data$vote16[data$vote16 == -1] = NA

#How many respondents skipped answering the question "vote16" with -1 indexed as 'NA?'
data$vote16[data$vote16 == -1] = NA
table(data$vote16)

#I developed a work around, subtracting the null responses (-1) from the total observations. The answer is 603 respondents skipped the question.
nrow(data)-table(data$vote16 == -1) 

#Where are the AMES respondents most likely to live? The answer is a suburb, 1117 responses.
table(data$liveurban)

#Who are the rural respondents in the AMES Sample most likely to vote for? Answer: Donald Trump, 314 responses out of 643.
table(data$liveurban,data$vote20jb)

#Who are the urban respondents in the AMES Sample most likely to vote for? Answer: Donald Trump, 465 responses out of 1117.
table(data$liveurban,data$vote20jb)

#Three variables I find interesting are:

#1 How the respondents approved of Trump (fttrump), continuous variable:
mean(data$fttrump)
median(data$fttrump)
#For the respondents, the mean was significantly higher (49) than the median (38), indicting right skewness of the sample,

#2 How did the respondents rate Russia (ftrussia_therm), continuous variable:
mean(data$ftrussia)
median (data$ftrussia)
#For the respondents, the median and the mean virtually coincided - no skewness.

#3 How the respondents indicated they would align their vote by party in the 2020 general election (tsplit1), categorical variable:
table(data$tsplit1)
#The responses indicate that the while the Democrats have an advantage over the Republicans with straight party votes, more respondents would split their vote or do 'something else', which could be a cause for concern for party strategsists.
