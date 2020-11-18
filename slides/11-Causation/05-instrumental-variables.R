##### UNDER CONSTRUCTION #######

## Natural Experiments and Instrumental Variables
## Author: Joe Ornstein
## Date: November 18, 2020
## Version: 1.0

## The techniques from the last three scripts required some pretty strong assumptions.
## Either you (1) manipulate the treatment yourself or 
##            (2) you have God-like knowledge of the true causal structure.

## In the next two scripts, we'll look at techniques for causal inference on 
## observational data that require somewhat weaker assumptions.

## First, what if something random happened out in the world that caused your
## treatment to be assigned randomly? We can use the random thing as an
## **instrumental variable**. Let's see how.

library(tidyverse)
set.seed(42)

# ----------------------- Part 1: A Natural Experiment -------------------------

## The most common instrumental variable in political science
## (so common it's become a bit of a running joke)
## is rainfall. Rain happens at random, and so it ocassionally causes
## some things we care about to be assigned at-random.

## For Example! Suppose we want to know whether voter turnout favors Republicans
## or Democrats...

n <- 4000

# the true effect:
beta <- 0.1

# Rain falls in a random 20% of precincts on Election Day
rain <- sample(c(0,1), size = n, replace = TRUE, prob = c(0.8, 0.2))

# There are some unobserved variables that affect both turnout and Democratic vote share
Z1 <- rnorm(n,0,0.1)
Z2 <- rnorm(n,0,0.1)

# The percentage of senior citizens in a county is determined randomly
pct_seniors <- rbinom(n,size = 100,prob=0.3)/100

# Turnout is caused by rain, pct_seniors, and the unobserved factors
turnout <- -0.5*rain + Z1 - Z2 + 0.7*pct_seniors + rnorm(n,0,0.1) + 0.4

# Democratic vote share is caused by turnout, pct_seniors, and the unobserved factors
dem_share <- beta*turnout + Z1 + Z2 - 0.7*pct_seniors + rnorm(n,0,0.1) + 0.5

# Put it all together into a dataframe
data <- tibble(dem_share,turnout,rain,median_age,Z1,Z2)



# First Stage
lm1 <- lm(turnout ~ rain + pct_seniors, data)

# make predictions
data <- data %>% 
  mutate(turnout_hat = predict(lm1, data))

# Second Stage
lm2 <- lm(dem_share ~ turnout_hat + pct_seniors, data = data)
summary(lm2)

# ------------------------- Part 3: The ivreg function -----------------------

library(AER)

iv_model <- ivreg(formula = dem_share ~ turnout + pct_seniors | rain + pct_seniors,
                  data = data)

summary(iv_model)
summary(lm2) # the coefficients are correct, but the standard errors are off (degrees of freedom? because turnout hat is an estimate of itself...)
