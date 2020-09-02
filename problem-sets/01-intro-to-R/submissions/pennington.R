load("data/anes_pilot_2019.RData")
#number of observations
nrow(data)
  #3165 observations
#number of variables
ncol(data)
  #901 variables
#names of variables
names(data)
#creating a variable for age
data$age <- 2020-data$birthyr
#age
data$age
#Computing the median age
median(data$age)
  #median age is 56
#Creating a histogram of age
hist(data$age)
#table of variable vote16
table(data$vote16)
#skipped the question aka code=-1
tablevote16<-rbind(table(data$vote16))
tablevote16
tablevote16[1,1]
  #603 skipped the question
#recoding NA to those who skipped the question
data$vote16[data$vote16 == -1] <- NA
tablevote16
  #I got the same results as before, not sure if this is correct.
#table of liveurban
table(data$liveurban)
  #most live in the suburbs
#two-way table
table(data$liveurban, data$vote20jb)
  #rural respondents likely to vote for Trump, urban for Biden.
#Playing with other variables
#contact2b
data$contact2b
mean(data$contact2b)
#econnow
data$econnow
mean(data$econnow)
#billtax
data$billtax
table(data$billtax)
