## Regression Discontinuity (RD)
## Author: Joe Ornstein (jornstein@uga.edu)
## Date: November 16, 2020
## Version: 1.0

library(readstata13)
library(tidyverse)
set.seed(42)

## The techniques from the last three scripts required some pretty strong assumptions.
## Either you (1) manipulate the treatment yourself or 
##            (2) you have God-like knowledge of the true causal structure.


## Now, let's introduce a method for causal inference on 
## observational data that requires somewhat weaker assumptions.

## Regression Discontinuity (RD) takes advantage of a sharp "cutoff" in
## treatment assignment. If the treatment suddenly changes but nothing else
## change, then we can confidently say that any difference in outcomes was
## caused by the treatment.

## Here's an example...


# -------------------- Part 1: A Morbid Empirical Example -----------------------

# Let's load a dataset about the causes of mortality among American youths
# I got it here: https://github.com/jrnold/masteringmetrics/tree/master/masteringmetrics/data
load('data/mlda.rda')


'****************************************************************************
  EXERCISE: Plot the relationship between age (agecell) and the death rate from
  motor vehicle accidents (mva). 
  - Save the plot as an object called p1.
  - What do you notice?
******************************************************************************'


## You may remember this as an example from our week on Data Visualization!


'****************************************************************************
  EXERCISE: Now plot the relationship between age (agecell) and drug-related 
  deaths (drugs).
******************************************************************************'

## You can think of this as a sort of "placebo test".



# ----------------------- Part 2: RD Estimation -----------------------------


## To estimate the causal effect, we'll follow a three step process:
##
## 1. Keep the data that is "close" to the cutoff.
## 2. Estimate two linear models: one on the left and one on the right.
## 3. Compare the difference in their predictions.
##
## It looks a little something...like this:

p1 + 
  geom_smooth(data = mlda %>% filter(agecell > 20.5, agecell < 21),
              mapping = aes(x=agecell, y=mva),
              method = 'lm', se = FALSE) + # linear model fit on the left
  geom_smooth(data = mlda %>% filter(agecell > 21, agecell < 21.5),
              mapping = aes(x=agecell, y=mva),
              method = 'lm', se = FALSE) # linear model fit on the right
  


## Naturally, there is a function that performs all of those steps for us.
## Install and load the rdrobust package
library(rdrobust)

## The rdrobust() function takes three inputs.
## y = the outcome variable
## x = the running variable
## c = the cutoff in treatment assignment
rd_fit <- rdrobust(y=mlda$mva,
                   x=mlda$agecell, 
                   c=21)

summary(rd_fit)


'****************************************************************************
  EXERCISE: Using rdrobust(), estimate the "placebo effect" of turning 21 on 
  drug-related deaths.
******************************************************************************'


# ------------------- Part 3: How It Works -------------------------------------


# the sample size
n <- 500

# the true treatment effect
beta <- 1.5

# Z1 is a sinister unobserved confounder
Z1 <- rnorm(n,0,1)

# Z2 is another sinister unobserved confounder. Egads they're everywhere!
Z2 <- rnorm(n,0,1)

# X is our running variable. It is caused by Z1 and Z2 plus some noise 
X <- 2*Z1 - 2*Z2 + rnorm(n,0,1)

# The treatment is assigned if and only if X is greater than 1
Tr <- as.numeric(X > 1)

# Y (the outcome) is caused by the treatment, Z1, Z2, and heck it's even caused by X, too!
Y <- beta * Tr + X - Z1  - Z2 + rnorm(n,0,3)

# put it all into a dataframe
data = tibble(X,Y,Tr,Z1,Z2)

plot(X,Y)
lm(Y~X+Tr,data=data) %>% summary
rdrobust(y=Y,x=X,c=1) %>% summary


# ---------------- Part 4: Another Empirical Example ------------------------------

# Eggers & Spirling (2017) estimate incumbency effects in the UK with an RD design
# comparing districts where Conservatives barely won election to Parliament with those
# where they barely lost, and observing how Conservatives perform in the following election

## Load and clean up the Eggers & Spirling (2017) dataset
load('data/combined_data_to_2010_all_20150128.RData')
# Keep only the Conservative-Liberal contests from 1950-2010 (Figure 4b)
data <- x %>%
  filter(X.e.year. >= 1950,
         X.con.rv_counterparty_was_lib. == T)
rm(x)

'****************************************************************************
  EXERCISE: 
  
  1. Plot the relationship between the Conservative margin of victory (X.con.rv.) 
  and Conservative vote share in the following election (X.con.vote_share.)
  
  2. What is the average vote share (X.con.vote_share.) for Conservative 
  candidates who *barely* won the previous election (X.con.rv. > 0, X.con.rv. < 1)? 
  What about Conservative candidates who barely *lost* the previous election?
  
  3. Estimate the "incumbency effect" -- the causal effect of winning office on 
  subsequent vote share -- using the rdrobust() function.
  
******************************************************************************'
