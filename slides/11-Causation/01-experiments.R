##
## Analyzing Experimental Data
## Author: Joe Ornstein (jornstein@uga.edu)
## Date: November 16, 2020
## Version: 1.0
##

## The nice thing about experimental data is that we already have the
## tools we need to estimate causal effects! Come with me on a journey!

library(tidyverse)
set.seed(42)


# ----------------- Part 1: Generate Some Random Data ---------------------

# sample size
n <- 3000

# true treatment effect (this is what we want to estimate!)
beta <- 3

# the treatment (Tr) is assigned randomly
Tr <- sample(c(0,1), size = n, replace = TRUE)

# X1 is a random variable
X1 <- rnorm(n,0,1)

# X2 is caused by X1 plus some noise
X2 <- 0.5*X1 + rnorm(n,0,1)

# Y (the outcome) is caused by the treatment, X1, and X2
Y <- beta*Tr + X1 - 2*X2 + rnorm(n,0,1) 

# X3 is caused by Tr (the treatment) and Y (the outcome)
X3 <- 2*Tr - 3*Y + rnorm(n,0,1)

# Put it all together in a dataframe
data <- tibble(Y,Tr,X1,X2,X3)


'****************************************************************************
  EXERCISE: Draw a DAG representing our data. Are there any backdoor paths?
******************************************************************************'


## If there are no backdoor paths between treatment and outcome, then the 
## observed correlation is an unbiased estimate of the true causal effect.
t.test(Y ~ Tr, data = data)

lm1 <- lm(Y~Tr,data=data)
summary(lm1)

## That's it!

'****************************************************************************
  EXERCISE: Estimate a kitchen sink linear model. 
  - What happens to the coefficient on Tr?
******************************************************************************'



# --------------------- Part 2: An Empirical Example -----------------------

'****************************************************************************
  EXERCISE: Summarize and visualize the built-in ToothGrowth dataset.
  - Does 2 mg/day of vitamin C significantly increase the tooth length of guinea pigs?
******************************************************************************'