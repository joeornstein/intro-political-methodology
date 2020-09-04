load(data)
#1 Summarize The Data
# How many observations? 3165
nrow(data)
# How many variables? 900
ncol(data)
# Names of variables? See Console
names(data)

#2 Clean Up The Data
# Make "age" variable
data$birthyr
birthyr=c(data$birthyr)
currentyr=2020
age=(currentyr-birthyr)
summary(age)
# What is the median age? 56
median(age)
# Create Histogram
hist(age)
# How many skipped respondents? 603
table(data$vote16)
# Power of Indexing. What happened? Table removed all the -1 observations
data$vote16[data$vote16 == -1] <- NA
table(data$vote16)

#3 Explore The Data
# Where are respondents most likely to live? Suburbs (3)
table(data$liveurban)
# Create two-way table.  
table(data$liveurban,data$vote20jb)
# Rural people (Column 1) = More likely to vote for Trump, Urban People (Column 2) = More likely to vote for Biden
# Interesting Variables: 2018 voter turnout, Bernie Sanders rating, NATO rating
table(data$turnout18a)

summary(data$ftsanders)

summary(data$ftnato)


