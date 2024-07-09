## In this script, we will look at US Census data on
## baby names from the past century and a half,
## and explore the most popular names over time.


# this line of code loads the babyname package
library(babynames)

# this line of code creates an object called baby_data,
# which contains the baby data
baby_data <- babynames

# let me introduce a few functions that are useful
# for dealing with these really large datasets

# what were the 10 most popular boy names in the year
# 1940?

# we need to proceed in a few steps

# first, just keep the babies born male
library(tidyverse)
male_babies <- filter(baby_data, sex == "M")

# next, just keep the male babies born in 1940
male_babies_1940 <- filter(male_babies, year == 1940)

# by the way, you can do this faster
male_babies_1940 <- filter(baby_data, sex == "M",
                           year == 1940)

# only keep the rows with the 10 largest values of n
top_male_babies_1940 <- slice_max(male_babies_1940,
                                  n, 
                                  n = 10)

least_popular <- slice_min(male_babies_1940,
                           n,
                           n = 10)

