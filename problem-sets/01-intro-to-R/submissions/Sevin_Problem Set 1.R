# Katie Sevin
# POLS 7012
# Problem Set 1 - Due Sept 2, 2020
# load the ANES data
load("C:/Users/Katie/Desktop/Fall 2020/POLS 7012/POLS 7012 Problem Sets/Sevin_Problem Set 1_Due Sept 2 2020/data/anes_pilot_2019.RData")
# Identify the number of rows/observations in this dataframe
nrow(data)
# Identify the number of columns/variables in this dataframe
ncol(data)
# Identify the names of the variables
names(data)
# Create a variable called "age", and set it to current year minus birth year
age <-(2020-data$birthyr)
# Identify the median age of survey respondents
median(age)
# Create a histogram of age
hist(age)
# Create a table of the variable vote16. How many respondents skipped this question? (Code= -1)
table(data$vote16)
# Represent these missing values with NA/Recode with the power of indexing
data$vote16[data$vote16 == -1] <- NA
# Create the table again. What happened?
table(data$vote16)
# The table removed the column representing the missing values
# Create a table of the variable liveurban. Where are our respondents most likely to live?
table(data$liveurban)
# 1=rural, 2=small town, 3=suburb, 4=city
# Our respondents are most likely to live in the suburbs.
# Create a two-table with liveurban and vote20jb.
table(data$liveurban, data$vote20jb)
# liveurban is displayed on the rows
# vote20jb is displayed on the columns, and 1=Donald Trump, 2=Joe Biden, 3=someone else, and 4=probably won't vote
# Who are the rural respondents in our sample most likely to vote for?
# Donald Trump
# Who are the urban respondents most likely to vote for? Joe Biden
# Skim the codebook and find three variables that you think are interesting. Summarize each one, either with a table for categorical values or the mean for continuous values.
# Variable 1 is "follow", which asks whether the respondent follows along with what's going on in the government/public affairs
table(data$follow)
# In this table, 1=most of the time, 2=some of the time, 3=only now and then, and 4=hardly at all
# It appears that the vast majority of people claim to at least some of the time, with the greatest number stating that they follow governmental affairs most of the time.
#Variable 2 is "tsplit1", which asks whether the respondent thinks they will vote down party lines or split their ballot
table(data$tsplit1)
# In this table, -7 means there is no answer, 1=vote straight Republican, 2=vote straight Democrat, 3=split the ballot depending on the office, and 4=something else
# It appears most of the respondents have the intention to vote down party lines, with nearly 2,000 responding that they would either vote straight Democrat or straight Republican.
# Variable 3 is "electable", which asks the respondent what was the most important to their primary/caucus vote (out of a list of choices)
table(data$electable)
# In this table, -1 means that it was N/A or a "legitimate skip", 1=shares my positions, 2=can defeat Trump, 3=neither, and 4=don't know
# Based off the results, the greatest return was the "NA/legitimate skip" result, but the second greatest group stated that they would vote the way that they did in order to beat the other side (in this case, Trump)
