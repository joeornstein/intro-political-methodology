#load the data
load("data/anes_pilot_2019.RData")
#compute the number of rows in the data
nrow(data)
#compute the number of columns in the data
ncol(data)
#list the names in the data
names(data)
#Create a variable called age, and set it equal to the current year minus birth year
age<-2019-data$birthyr
#Find the median age of the survey respondents
median(age)
#Create a histogram of the age of survey respondents
hist(age)
#Create a table of the variable vote16
table(data$vote16)
#recode missing value vote16 as -1
data$vote16[data$vote16 == -1] <- NA
#create a table of the variable vote16 again
table(data$vote16)
#Create a table() of the variable liveurban
table(data$liveurban)
#Create a two-way table with liveurban and vote20jb
table(data$liveurban, data$vote20jb)
#Summarize three variables you find interesting
mean(data$ftharris)
mean(data$ftnato)
table(data$youthurban)