load("data/anes_pilot_2019.RData")
# Observations
nrow(data)
#Variables
ncol(data)
#Name of Variables
names(data)
#Age
x <- 2020
age <- (x-data$birthyr)
median(age)
hist(age)
#Vote in 2016
table(data$vote16)
#Recoding the missing data
data$vote16[data$vote16 == 1] <- NA
table(data$vote16)
#We have gotten rid of 603 observations
#liveurban asks whether respondents live in a rural area, small town, suburb, city
table(data$liveurban)
# 1=rural, 2=small town, 3=suburb, 4=city
#vote20jb asks who respondents would vote for it the election were between Joe Biden and Donald Trump
table(data$votejb)
#crosstab between liveurban and vote20jb
table(data$liveurban, data$vote20jb)
#Need to figure out command for recoding the numbers to give them actual labels
# Variables of Interest
#1 Feeling Thermometer of Russia: Potential research paper is looking at the parellels of Trump and Nixon related to polarizing public opinion on two "enemies" being Russia in the present and China when Nixon opened economic relations
mean(data$ftrussia)
#2 Party ID is my second variable of interest. I choose this variable just to see the distribution of partisans within the respondents pool. 
#Recoding missing data
data$pid1r[data$pid1r == -1] <- NA
table(data$pid1r)
# 1=Dem, 2=GOP, 3=Ind, 4=Other
#Final variable is the feeling thermometer of Trump. He is such a polarizing figure and really is unlike any president we've had so it's just interesting to look at and study.
mean(data$fttrump)

