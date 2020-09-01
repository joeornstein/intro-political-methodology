#load("/Users/asiaparker/Desktop/7012/anes_pilot_2019 (1).RData")
#How many observations are in the dataset?
nrow(data) 
#How many variables are in this dataset?
ncol(data) 
#What are the names of the variables?
names(data)
#Create a variable for age
age<-2020-data$birthyr
#What is the Median age of our survey respondents?
median(age)
#Create a histogram of age with the function. 
hist(age) 
#Create a table of the variable vote16. How many respondents skipped this question (code = -1)?
table(data$vote16)
data$vote16[data$vote16 == -1] <- NA
table(data$vote16)
#New table does not include -1 data
table(data$liveurban) 
#Respondents will most likely live in the suburbs
table(data$liveurban,data$vote20jb)
#Summarize 3 codebooks
table(data$liveurban,data$youthurban,data$placeid1a)
