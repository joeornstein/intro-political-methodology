#Haley Howell
#Pols7012 Problem Set 1
#8/31/2020

#Loading the Data
load ("data/anes_pilot_2019.RData")

#Summarizing the Data

#counting the observations
nrow(data)
##There are 3165 observations 

#counting the columns
ncol(data)
##there are 900 columns

#names of the variables 
names(data)

#creating variable for age
age <- (2020 - data$birthyr)

#taking the median
median(age)
##median age is 56

#creating histogram
hist(age)

#creating the table
table(data$vote16)

#How many respondents skipped this question (code = -1)
tablev16 <- rbind(table(data$vote16))
tablev16
tablev16[1,1]
##603

#recode the values by indexing
data$vote16[data$vote16 == -1] <- NA 
tablev16[1,1]
##1172

#live urban table 
table(data$liveurban)
## 643 rural areas, 589 small town, 1117 suburb, and 816 city 

#creating two way table 
table(data$liveurban,data$vote20jb)
##rural areas = Trump 
##small town = Trump
##suburb = Trump
##city = Biden


#How would you rate Barack Obama?
table(data$ftobama)

#How would you rate Bernie Sanders?
mean(data$ftsanders)
##55.09

#mean of How would you rate blacks?
mean(data$ftblack)
##70.73 