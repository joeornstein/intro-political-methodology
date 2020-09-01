#Elise Blasingame Problem Set 1
load("data/anes_pilot_2019.Rdata")
nrow(data)
#There are 3165 rows
ncol(data)
#There are 900 columns
names(data)
#the code below are my mistakes/what I tried first to create the age variable
age<-2020-"birthyr"
"age"<-c(2020-"birthyr")
age <- (2020-"birthyr")
"age" <- (2020-"birthyr")
"birthyr"
list("birthyr")
typeof(2020)
typeof("birthyr")
#Figured out that I need to use $ to call the data to the code
birth_year <- data$birthyr
age <- 2020-birth_year
median(age)
#The median age is 56
hist(age)
#Have to run for the image
table(data$vote16)
#There are 603 respondents who skipped this question.
data$vote16[data$vote16== -1] <-NA
table(data$vote16)
#The table now runs with only the 1, 2, and 3 coded responses.
table(data$liveurban)
#Most respondents live in a suburban area.
table(data$liveurban,data$vote20jb)
#The rural respondents are most likely to vote for someone else.
#The urban respondents probably did not vote.
table(data$religpew,data$particip_2)
#I was interested in the contributions of different religious groups to political campaigns. I wanted to answer how many Muslim respondents gave to political campaigns. Only n=6 respondents who identified as Muslim also provided to a political cause or campaign.
table(data$religpew,data$particip_2,)
#Then went back to look at the mean of our variable, age. The mean is 52.03349.
mean(age)
summary(age)
