## Matching Estimators
## Author: Joe Ornstein (jornstein@uga.edu)
## Date: November 16, 2020
## Version: 1.0

## In this script, we'll explore what happens if the data-generating process is nonlinear.
## Do linear models still produce good causal estimates?

library(tidyverse)
set.seed(42)


# ------------------- Part 1: Generate some random data -------------------------

# sample size
n <- 15000

# the true causal effect; this is what we want to estimate!
beta <- 4

# X1 is distributed normally
X1 <- rnorm(n,0,1)

# X2 is distributed normally
X2 <- rnorm(n,0,2)

# Tr (the treatment) is caused by X1 and X2 in a weird nonlinear fashion
Tr <- if_else(X1 + X2^2 - rnorm(n,0,2.5) < 1, 1, 0)
# (more likely to be in the treatment group if X1 is small and X2 is close to zero)

# Y is caused by Tr, X1, and X2 in a weird nonlinear fashion plus some noise
Y <- beta*Tr - 2*X1^3 + 3*X2^2 + rnorm(n,0,2)

# put it all into a data frame
data <- tibble(index = 1:n,
               Y,Tr,X1,X2)


# ------------------- Part 2: Estimating beta with lm() ---------------------

'****************************************************************************
  EXERCISE: Is the Y value for the treatment group significantly larger or smaller
  than the Y value for the control group? Compute the difference-in-means.
******************************************************************************'



'****************************************************************************
  EXERCISE: The problem is that the covariates (X1 and X2) are imbalanced! 
  - What is the average X1 and X2 in the control group? The treatment group?
******************************************************************************'

# Here's a visualization:
ggplot(data = data) +
  geom_histogram(aes(x=X1,fill=factor(Tr)), 
                 alpha = 0.5, position = 'identity') +
  labs(fill = 'Treated')

ggplot(data = data) +
  geom_histogram(aes(x=X2,fill=factor(Tr)), 
                 alpha = 0.5, position = 'identity') +
  labs(fill = 'Treated')


'****************************************************************************
  EXERCISE: Condition on X1 and X2 using a linear model. Does that solve
  the problem?
******************************************************************************'



# -------------- Part 3: Introducing the Matching Estimator -----------------

# Motivation: We still want to condition on confounding variables, 
# but the true relationships are not linear, so lm() performs poorly.

# The Matching Approach: 
# for each observation in the treatment group, match it with an observation in the
# control group, such that pretreatment covariates are 'balanced' across groups 
# (they don't significantly differ). Then compare means as usual!

# install and load the 'Matching' package
library(Matching)

# Use the Match() function to find a matched control group
# It takes three arguments:
# Y = the outcome variable
# Tr = the treatment group indicator (0 or 1)
# X = a matrix of covariates
m <- Match(Y = Y, Tr = Tr, X = cbind(X1,X2))

# Get the summary() of your match object for an estimate of the average treatment effect
summary(m)

# Witchcraft! How does it work??
# To see, let's look at the matched control group it created.
matched_control_group <- data[m$index.control,] # the matched control group
treatment_group <- data[m$index.treated,] # the treatment group
matched_data <- bind_rows(matched_control_group, treatment_group) # put them both together


'****************************************************************************
  EXERCISE: 
    1. Look at the matched_control_group dataframe. What do you notice?
    2. Are the covariates X1 and X2 balanced in the new matched_data?
    (Summarize and visualize)
******************************************************************************'




# --------------- Part 4: Where matching can go wrong ------------------------


# NOTE: Matching estimators recover the true causal effect under two conditions:
# 1. You can assume "selection on observables" (i.e. you know the true DAG and 
#     can close all the backdoor paths)
# 2. There is enough overlap on covariates that you can to find matches for 
#     everyone in the treatment group.

# Here's another set of random data where Match() doesn't perform so well.

# the true average treatment effect
beta <- 4

# sample size 
n <- 1500

# Z is distributed standard normal
Z <- rnorm(n,0,3)

# treatment is caused by Z
Tr <- if_else(Z > 0, 1, 0)

# Y is caused by Tr, Z, and some random noise
Y <- beta*Tr - Z^3 + Z^2 + rnorm(n,0,1)

# combine into a dataframe
data <- tibble(index = 1:n,
               Y,Tr,Z)

'****************************************************************************
  EXERCISE: Using this dataset, show that you cannot recover the true 
  causal effect using lm() or Match(). What went wrong? 
  (Hint: visualize your covariate imbalance.)
******************************************************************************'




# ------------------- Part 5: An Empirical Application ----------------------

# The GerberGreenImai dataset comes bundled with the Matching() package, from these papers:
#
# Gerber, Alan S. and Donald P. Green. 2000. "The Effects of Canvassing, Telephone Calls, and
# Direct Mail on Voter Turnout: A Field Experiment." American Political Science Review 94: 653-663.
#
# Imai, Kosuke. 2005. "Do Get-Out-The-Vote Calls Reduce Turnout? The Importance of 
# Statistical Methods for Field Experiments".  American Political Science Review 99: 283-300.
#

data("GerberGreenImai")

# Some respondents received Get Out The Vote phone calls.
# We want to know if they were more likely to turn out to vote.

Tr <- GerberGreenImai$PHN.C1 #treatment phone calls
Y <- GerberGreenImai$VOTED98 #outcome, turnout

# What was the turnout rate of people who answered the phone compared to the control group?
GerberGreenImai %>% 
  group_by(PHN.C1) %>% 
  summarize(turnout_rate = mean(VOTED98),
            num = n())
# Whoa. A lot fewer people answered the phone than Gerber & Green hoped...

'****************************************************************************
  EXERCISE: Are the people who answered the phone (Treated) similar on 
  pre-treatment covariates to those in the control group?
  - Some Covariates To Check: PERSONS, VOTE96.1, NEW, AGE, MAJORPTY
  - See ?GerberGreenImai for info on those covariates
******************************************************************************'


'****************************************************************************
  EXERCISE: Estimate the average treatment effect using lm()
******************************************************************************'


## With so many exact matches, matching gets a little weird, so here's how I would do it: 

## Create the pre-treatment covariate matrix
X <- GerberGreenImai %>% 
  model.matrix(~ PERSONS + VOTE96.1 + NEW + AGE + MAJORPTY + WARD - 1, data = .)
# the 'model.matrix' function is a handy way of separating that categorical variable (WARD)
# into a bunch of dummy variables. lm() does that automatically, but Match() doesn't.

m <- Match(Y = Y, Tr = Tr, X = X, M=5, ties = FALSE)
# M = 5 means we'll find five control observations for every treated observation. 
# We've got so many in the control group, we might as well!
# ties = FALSE means that Match() will randomly break ties when it sees 
# multiple exact matches

summary(m)

matched_data <- GerberGreenImai[c(m$index.treated, m$index.control),]

'****************************************************************************
  EXERCISE: Check the covariate balance in the matched_data. Did it work?
******************************************************************************'

