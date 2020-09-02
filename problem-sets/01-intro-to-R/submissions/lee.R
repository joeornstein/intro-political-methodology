# To make sure whether the working directory is correctly set
getwd()
# load the data and save it to the object called "data"
load("data/anes_pilot_2019.RData")
# To count the number of rows (i.e. observations)
nrow(data)  # answer: 3165
# To count the number of columns (i.e. variables)
ncol(data)  # answer: 900
# to figure out the names of the variables
names(data)
# to extract the data of birth year 
data$birthyr
# to create a function to calculate the age
age_function <- function(x){
  return (2020-x)
}
# To put the age data into the data frame with creating a column named "age"
data$age <- age_function(data$birthyr)
# to check whether the column named "age" was created well
data$age
# to calculate the median of age 
median(data$age)    # answer: 56
# to create a histogram of "age"
hist(data$age)
# to create a table of the variable "vote16"
table(data$vote16)   # answer: the number of "code=-1" is 603
# to replace the missing value, code=-1, with "NA"
data$vote16[data$vote16 == -1] <- NA
# to check what happened after "indexing"
table(data$vote16)  # answer: the column of "code == -1" disappeared. 
# to create a table of the variable "liveurban"
table(data$liveurban)  # answer: The respondents most likely live in suburb area
# to create a two-way table with "liveurban" and "vote20jb"
table(data$liveurban, data$vote20jb)  # Answer: If we look at the row 1 (rural area), the residents mostly likely to vote for "1 (314)," which is "Donald Trump."
table(data$pk_germ_correct)   # I was a bit surprised by how much Americans could be somewhat ignorant about basic facts concerning foreign affairs. 
table(data$pk_cjus_correct)   # More Americans than those I expected also do not know domestic politics that much.
table(data$inputstate)
median(data$duration)    # Answer: the average of time spent for interview per person is 2049 (seconds)
