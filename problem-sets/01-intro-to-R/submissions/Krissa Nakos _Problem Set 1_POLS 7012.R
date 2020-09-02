# Title: POLS 7012 Problem Set 1
# Author: Krissa Nakos
# Due Date: 09/02/20

# Load the data
load("data/anes_pilot_2019.RData")

# Count the number of observations in this dataset
nrow(data)
# How many observations are in this dataset? Answer: 3165

# Count the number of variables in this dataset
ncol(data)
# How many variables are in this dataset? Answer: 900

# List the names of the variables
names(data)

# Compute age
age <- 2020 - data$birthyr

# Compute median age
median(age)
# What is the median age? Answer: 56

# Create a histogram of age
hist(age)

# Create a table showing responses for the variable "vote16"
table(data$vote16)
# How many respondents skipped this question? Answer: 603

# Assign missing values for the "vote16" variable the value "NA"
data$vote16[data$vote16 == -1] <- NA

# Create a table showing responses for the variable "vote16" again
table(data$vote16)
# What happened? Answer: The -1 column of the table disappeared.

# Create a table of the variable "liveurban"
table(data$liveurban)
# Where are respondents most likely to live? Answer: In a suburb

# Create a two-way table with the variable "liveurban" and "vote20jb"
# Note: the first variable will be the rows of the table and the second will be the columns
table(data$liveurban,data$vote20jb)
# Who are the rural respondents most likely to vote for? Answer: Donald Trump
# Who are the urban respondents most likely to vote for? Answer: Joe Biden

# Compute the mean of the variable "ftjournal"
# Note: this question asks respondents to rate journalists
mean(data$ftjournal)
# What is the mean? Answer: 49.86667

# Create a table of the variable "tiktok2"
# Note: this question asks respondents how often they come across information about political issues when using TikTok
table(data$tiktok2)

# Create a table of the variable "relig3b"
# Note: this question asks respondents whether they consider themselves to be Protestant, Roman Catholic, Jewish, or something else
table(data$relig3b)
