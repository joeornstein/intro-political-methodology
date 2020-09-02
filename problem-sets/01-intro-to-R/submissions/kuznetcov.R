# Load R.data file
load("data/anes_pilot_2019.RData")

# Count the the number of rows (i.e. observations)
nrow(data)

# Count the the number of of columns (i.e. variables)
ncol(data)

# Names of the variables
names(data)

# Creating variable for age
age <- 2020 - data$birthyr

# Median age of respondents
median(age)

# histogram of age
hist(age)

# table of the variable vote16
table(data$vote16)

# How many respondents skipped the question vote16 (-1 code)
tablev16 <- rbind(table(data$vote16))
tablev16
tablev16[1,1]

# Assign NA to those who skipped the question vote16
data$vote16[data$vote16 == -1] <- NA

# Create the table again
table(data$vote16)

# -1 disappeared from the table

# Create a table of the variable liveurban
table(data$liveurban)

# Where respondents most likely to live?
data$liveurban[data$liveurban == 1] <- "rural area"
data$liveurban[data$liveurban == 2] <- "small town"
data$liveurban[data$liveurban == 3] <- "suburb"
data$liveurban[data$liveurban == 4] <- "city"
table(data$liveurban)
which.max(table(data$liveurban))

# Create a two-way table
data$vote20jb[data$vote20jb == 1] <- "Donald Trump"
data$vote20jb[data$vote20jb == 2] <- "Elizabeth Warren"
data$vote20jb[data$vote20jb == 3] <- "someone else"
data$vote20jb[data$vote20jb == 4] <- "probably not vote"
table(data$liveurban, data$vote20jb)

# Who are the rural respondents most likely to vote for? 
rural_respondents <- c(((table(data$liveurban, data$vote20jb))[2,]))
which.max(rural_respondents)

# The urban respondents?
urban_respondents <- c(((table(data$liveurban, data$vote20jb))[1,]))
which.max(urban_respondents)

# unemp Which of  these two   statements do  you   think is  most likely to  be  true?
data$unemp[data$unemp == -7] <- "No Answer"
data$unemp[data$unemp == 1] <- "Unemployment is now higher than when Trump took office"
data$unemp[data$unemp == 2] <- "Unemployment is now lower than when Trump took office"
table(data$unemp)

# instagram3 Whenusing Instagram, how often do  you post information about political issues?
data$instagram3[data$instagram3 == -1] <- "Inapplicable, legitimate skip"
data$instagram3[data$instagram3 == 1] <- "Always"
data$instagram3[data$instagram3 == 2] <- "Most of the time"
data$instagram3[data$instagram3 == 3] <- "About half of the time"
data$instagram3[data$instagram3 == 4] <- "Sometimes"
data$instagram3[data$instagram3 == 5] <- "Never"
table(data$instagram3)

# relig3b Do  you   consider yourself Protestant, RomanCatholic, Jewish, or something else?
data$relig3b[data$relig3b == -1] <- "Inapplicable, legitimate skip"
data$relig3b[data$relig3b == 1] <- "Protestant"
data$relig3b[data$relig3b == 2] <- "Catholic"
data$relig3b[data$relig3b == 3] <- "Jewish"
data$relig3b[data$relig3b == 4] <- "Something else"
table(data$relig3b)

