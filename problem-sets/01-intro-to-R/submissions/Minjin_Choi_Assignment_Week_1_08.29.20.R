# # 0. To Make Sure the Working Directory
# getwd()
# setwd("C:/Users/LG/Desktop/POLS7012/Week 1")
# 

# 1. Load the Data
load("data/anes_pilot_2019.RData")


# 2. Summarize the Data
#Q1. How many observations are in this data set? A. 3165
nrow(data)

#Q2. How many variables are in this dataset? A. 900
ncol(data)

#Q3. What are the names of the variables?
names(data)


# 3. Clean Up the Data
#Creating "Age" Variable
age<-2020-data$birthyr

#Check the "Age" Variable
age

#Q1. What is the median age of our survey respondents? A. 56
median(age)

#Q2. Creating a Histogram.
hist(age)

#Finding Missing Values
vote16<-data$vote16

#Q1. Creating a table of the variable vote16. 
#How many respondents skipped this question? A. 603
table(vote16)

#Q2. Recoding missing values with the power of indexing,
#and create the table again.
#What happened? A. The "-1" column was missed.
data$vote16[data$vote16 == -1] <- NA
vote16<-data$vote16
table(vote16)


# 4. Explore the Data
#Q1. Create a table of the variable liveurban. 
#Where are our respondents most likely to live? 
#A. Suburban(1,117 respondents, numeric code "3")
liveurban<-data$liveurban
table(liveurban)

#Q2. Create a two-way table with liveurban and vote20jb.
#Who are the rural respondents in our sample most likely to vote for?
#The urban respondents?
#A.The rural respondents are most likely to vote for Donald Trump(314 respondents).
#The urban respondents are most likely to vote for Joe Biden(401 respondents).
vote20jb<-data$vote20jb
table(liveurban, vote20jb)

#Q3. Skim the codebook and find three variables that you think are interesting.
#A1. particip_6
#Among the respondents, 413 people answered that they participated in the Button-Worn Campaign,
#but 2752 answered that they didn't.
particip_6<-data$particip_6
table(particip_6)

#A2. fttrump
#I am not sure whether this variable is categorical or continuous. 
#Therefore, I tried to make a table and find the mean.
#The results of the mean is 49.35071.
fttrump<-data$fttrump
table(fttrump)
mean(fttrump)

#A3. pk_germ_correct
#1232 respondents answered not correctly on the question asking the job of Angela Merkel,
#but 1933 people answered correctly.
pk_germ_correct<-data$pk_germ_correct
table(pk_germ_correct)
