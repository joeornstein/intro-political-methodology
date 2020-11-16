## Linear Models
## Author: Joe Ornstein (jornstein@uga.edu)
## Date: November 14, 2020
## Version: 1.0

## In this script, we discuss lm() as a tool for estimating causal effects.

library(tidyverse)
set.seed(42)

# ---------------- Section 1: Generate Some Fake Data ------------------

## Just like we did in 01-experiments.R, we'll generate some fake data,
## but this time the treatment variable (Tr) won't be assigned randomly!

# the true causal effect; this is what we want to estimate.
beta <- 2

# sample size
n <- 1000

# Z is distributed normally
Z <- rnorm(n,0,1)

# X is caused by Z (plus some noise)
X <- 2*Z + rnorm(n,0,1)

# Y is caused by X and Z (plus some noise)
Y <- beta*X + -8*Z + rnorm(n,0,1)

# Put it together in a dataframe
data <- tibble(X,Y,Z)


'****************************************************************************
  EXERCISE: 
  1. Draw a DAG representing this data. Are there any backdoor paths?
  2. What is the bivariate relationship between X and Y?
******************************************************************************'



# ------------------- Section 2: What is lm() doing? --------------------------

## The 3D plots help with my intuition. Here's how to build one:
library(plotly)



# --------- Section New ---------


data <- tibble(Z1 = rnorm(n,0,1), # Z1 is distributed normally
               Z2 = rnorm(n,0,2), # Z2 is distributed normally
               X = Z1 + Z2 + rnorm(n,0,2), # Z1 and Z2 cause X (plus some noise)
               Y = beta*X + -5*Z1 + -6*Z2 + rnorm(n,0,1) # X, Z1, and Z2 cause Y (plus some noise)
               )


## Exercise 1: Estimate the linear effect of X on Y without adding covariates ----------------
## Does the coefficient recover the true effect?

ggplot(data,aes(x=X,y=Y)) + geom_point()
lm(Y~X, data=data) %>% summary()


## Exercise 2: Draw a DAG of the data we just created. What variables must we condition on to close the
## backdoor paths? Add them to the lm() ------------------------------------------------

lm(Y~X+Z1+Z2,data=data) %>% summary


## Conditioning on Colliders -----------------------

# true causal effect; this is what we want to estimate!
beta <- 3

# sample size
n <- 1000


data <- tibble(Z1 = rnorm(n,0,1), # Z1 is distributed standard normal
               X = 2*Z1 + rnorm(n, 0, 1), # Z1 causes X (plus some noise)
               Y = beta*X + -2*Z1 + rnorm(n, 0, 2), # X and Z1 cause Y (plus some noise)
               Z2 = 4*X + 3*Y + rnorm(n, 0, 1)# X and Y jointly cause Z2 (plus some noise)
)




# Exercise: Draw a DAG representing the data we created above; what should we condition on to close
# the backdoor paths? Try the correctly specified model *and* a kitchen sink model. Compare. -------------------------------------

# unconfounded
lm1 <- lm(Y ~ X + Z1, data = data)

# confounded
lm2 <- lm(Y ~ X + Z1 + Z2, data = data)

summary(lm1)
summary(lm2)

# Prediction ---------------------------------------

# Conditioning on collider bad for causal inference...
# But is it bad for prediction?

# create training and testing datasets
train <- data %>% 
  sample_frac(0.7)

test <- data %>% 
  anti_join(train)


lm1 <- lm(Y~X+Z1, data = train)
lm2 <- lm(Y~X + Z1 + Z2, data = train)

test <- test %>% 
  mutate(Yhat1 = predict(lm1, test),
         Yhat2 = predict(lm2, test))


ggplot(test) + 
  geom_point(aes(x=Yhat1,y=Y))

ggplot(test) + 
  geom_point(aes(x=Yhat2,y=Y)) # prediction is better!

sum((test$Yhat1 - test$Y)^2)
sum((test$Yhat2 - test$Y)^2) # sum of squared errors is ~40 times lower!


## Let's see if we can find some empirical colliders ---------------------------

load('../10-Prediction/data/anes_pilot_2019.RData')

data <- data %>% 
  mutate(pro_impeachment = impeach1 %in% c(1,2),
         age = 2019 - birthyr,
         vote16 = case_when(vote16 == 1 ~ 'Trump',
                            vote16 == 2 ~ 'Clinton',
                            vote16 == 3 ~ 'Other')) %>% 
  filter(fttrump %in% 0:100,
         !is.na(vote16))

# no collider
lm3 <- lm(fttrump ~ age, data = data)
# w/ collider
lm4 <- lm(fttrump ~ age + pro_impeachment, data = data)

summary(lm3)
summary(lm4)


## Mediators ---------------------------------------

data <- tibble(X = rnorm(n,0,1),
               Z = 2*X + rnorm(n,0,1),
               Y = 2*Z + rnorm(n,0,1))

# Exercise: Draw the DAG. What is the true causal effect of X on Y? 
# (If you increase X by 1, what happens to Y?)
# How do you specify an lm() model to recover that true causal effect?
# ----------------------

# confounded
lm(Y~X+Z, data=data) %>% summary

# unconfounded
lm(Y~X,data=data) %>% summary


## TODO: Add a binary treatment variable ---------------------
