## Matching Estimators
## Author: Joe Ornstein (jornstein@uga.edu)
## Date: November 14, 2020
## Version: 1.0

## In this script, we'll explore what happens if the data-generating process is nonlinear.
## Do linear models still produce good causal estimates?

library(tidyverse)
set.seed(42)


## Generate some random data -----------------------------------------------

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


## Try to estimate beta (the average treatment effect) ----------------------------

'****************************************************************************
  EXERCISE: Compute the difference in means. Is the Y value for the 
  treatment group significantly larger than the Y value for the control group?
******************************************************************************'



'****************************************************************************
  EXERCISE: The problem is that the covariates (X1 and X2) are imbalanced! 
  - What is the average X1 and X2 in the control group? The treatment group?
  - Visualize the distributions of X1 and X2 by treatment status.
******************************************************************************'

data %>% 
  group_by(Tr) %>% 
  summarize(mean_X1 = mean(X1),
            mean_X2 = mean(X2))

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

lm2 <- lm(Y~Tr+X1+X2,data=data)
summary(lm2) # but oh no, conditioning with lm() makes it worse!



## Introducing: Matching Estimators --------------------------------------------

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

matched_data %>% 
  group_by(Tr) %>% 
  summarize(mean_X1 = mean(X1),
            mean_X2 = mean(X2),
            mean_Y = mean(Y))

ggplot(data = matched_data) +
  geom_histogram(aes(x=X1,fill=factor(Tr)), 
                 alpha = 0.5, position = 'identity') +
  labs(fill = 'Treated')

ggplot(data = matched_data) +
  geom_histogram(aes(x=X2,fill=factor(Tr)), 
                 alpha = 0.5, position = 'identity') +
  labs(fill = 'Treated')


# NOTE: Matching estimators recover the true causal effect under two conditions:
# 1. You can assume "selection on observables" (i.e. you know the true DAG and 
#     can close all the backdoor paths)
# 2. There is enough overlap on covariates that you can to find matches for 
#     everyone in the treatment group.

'****************************************************************************
  EXERCISE: Using the following dataset, show that you cannot recover the true 
  causal effect using lm() or Match(). What went wrong? 
  (Hint: visualize your covariate imbalance.)
******************************************************************************'

# true effect
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


lm(Y~Tr,data=data)
lm(Y~Tr+Z,data=data)
Match(Y=Y, Tr=Tr, X=Z) %>% summary

ggplot(data = data) +
  geom_histogram(aes(x=Z,fill=factor(Tr)), 
                 alpha = 0.5, position = 'identity') +
  labs(fill = 'Treated')
