## This script examines self-reported turnout from ANES
## Author: Joe Ornstein
## Date: April 25, 2021


# First, load the data
d <- read.csv( file = 'data/turnout.csv' )


# Describe the dataset
dim(d) # dimensions
nrow(d) # observations
d$year # the years covered by the dataset range from 1980 to 2008

# Compute turnout according to various methods
d$turnout_VAP <- d$total / (d$VAP + d$overseas) * 100
d$turnout_VEP <- d$total / (d$VEP + d$overseas) * 100

# what's the difference between the computed turnout and self-reported turnout?
d$bias <- d$ANES - d$turnout_VAP

d$bias

plot(bias ~ year, data = d)
