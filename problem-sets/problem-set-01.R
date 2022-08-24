#' ---
#' title: Problem Set 1
#' author: Joe Ornstein
#' date: 2022-08-09
#' version: 0.2
#' ---

# In this R script, we'll plot the number of babies born each
# year in the United States with the name "Joseph"

## Step 1: Load Packages --------------

library(tidyverse) # a package with lots of useful functions
library(babynames) # a package with the baby names data from US Census


## Step 2: Clean Up The Data -------------------

# here's what the dataset looks like
head(babynames)

# create an object called 'd' with just the male Andrew
d <- babynames |> 
  filter(name == 'Andrew',
         sex == 'M')

head(d)

## Step 3: Plot The Data ------------------

# create a ggplot object called p
p <- ggplot(data = d,
            mapping = aes(x=year, y=n)) +
  # add a line geometry
  geom_line()

# return the plot
p

# we'll learn how to make this prettier in the coming weeks :-)
