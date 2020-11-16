## Linear Models
## Author: Joe Ornstein (jornstein@uga.edu)
## Date: November 14, 2020
## Version: 1.0

## In this script, we discuss lm() as a tool for estimating causal effects
## from observational data.

library(tidyverse)
set.seed(42)

# ---------------- Part 1: Generate Some Fake Data ------------------

## Just like we did in 01-experiments.R, we'll generate some fake data,
## but this time the treatment variable (Tr) won't be assigned at random!

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


'****************************************************************************
  EXERCISE: Estimate an lm() model with both X and Z as covariates.
    - What is the new coefficient on X?
******************************************************************************'




# ------------------- Part 2: What is lm() doing? ---------------------------

## First, the geometric intuition:

## 3D plots help with my intuition. 
## If they help with yours too, here's how to build one:
library(plotly)
plot_ly(x = X, y = Y, z = Z, type = 'scatter3d', mode = 'markers',
                     marker = list(size = 5, color = "black", symbol = 104))
## Notice how, ignoring Z, it looks like X and Y are inversely correlated. 
## That's because X is strongly correlated with Z, which is strongly negatively
## correlated with Y.


## Second, the calculus-style intuition:

## Once you have a linear model, you can "hold Z constant" by taking a partial derivative.

'****************************************************************************
  EXERCISE: If Y = b1*X + b2*Z + alpha, then what is dY/dX?
******************************************************************************'


# ----------------- Part 3: A More Complicated DAG  ------------------------------

# the true causal effect; this is what we want to estimate.
beta <- 3

# sample size
n <- 3000

# Z1 is standard normal
Z1 <- rnorm(n,0,1)

# Z2 is caused by Z1 plus some noise
Z2 <- 4*Z1 + rnorm(n,0,2)

# Z3 is caused by Z1 plus some noise
Z3 <- 5*Z1 + rnorm(n,0,1)

# X is caused by Z1 plus some noise
X <- 3*Z1 + rnorm(n,0,3)

# Y is caused by X, Z2, Z3, and some noise
Y <- beta*X - 5*Z2 - 6*Z3 + rnorm(n,0,2)

# Put it together in a dataframe
data <- tibble(X,Y,Z1,Z2,Z3)

'****************************************************************************
  EXERCISE: Estimate the linear effect of X on Y without adding covariates.
    - Does the coefficient recover the true effect?
******************************************************************************'



'****************************************************************************
  EXERCISE: Draw a DAG of the data we just created.
    - Which set of variables should we condition on to close the backdoor paths?
    - Re-estimate the lm() with the correct set of variables.
******************************************************************************'



# ----------------- Part 4: Conditioning on a Collider  ------------------------------

# true causal effect; this is what we want to estimate!
beta <- 3

# sample size
n <- 1000

# Z1 is distributed standard normal
Z1 <- rnorm(n,0,1)

# Z1 causes X (plus some noise)
X <- 2*Z1 + rnorm(n,0,1)

# X and Z1 cause Y (plus some noise)
Y <- beta*X - 2*Z1 + rnorm(n,0,2)

# X and Y cause Z2 (plus some noise)
Z2 <- 4*X + 3*Y + rnorm(n,0,1)

# put it together in a dataframe
data <- tibble(index = 1:n,
               X,Y,Z1,Z2)

'****************************************************************************
  EXERCISE: Draw a DAG representing the data we created above.
    - What should we condition on to close the backdoor paths?
    - Fit the correctly specified model *and* a kitchen sink model. Compare.
******************************************************************************'



'****************************************************************************
  EXERCISE: Is conditioning on a collider bad for predictive accuracy?
    - Split the data into train and test sets
    - Fit the "correct" model and the kitchen sink model on the train set.
    - Compare the predictions on the test set.
******************************************************************************'


train <- data %>% 
  sample_frac(0.7)

test <- data %>% 
  anti_join(train)


# ----------------- Part 5: An Empirical Example  ------------------------------

## Let's load and clean the ANES pilot data. For old times sake.
load('data/anes_pilot_2019.RData')

data <- data %>% 
  mutate(pro_impeachment = impeach1 %in% c(1,2),
         age = 2019 - birthyr,
         vote16 = case_when(vote16 == 1 ~ 'Trump',
                            vote16 == 2 ~ 'Clinton',
                            vote16 == 3 ~ 'Other')) %>% 
  filter(fttrump %in% 0:100,
         !is.na(vote16))

'****************************************************************************
  EXERCISE: Which of these models is likely to yield a better estimate of 
  the effect of age on Trump support? Why?
******************************************************************************'

# Model 1
model1 <- lm(fttrump ~ age, data = data)
# Model 2
model2 <- lm(fttrump ~ age + pro_impeachment + vote16, data = data)

summary(model1)
summary(model2)


# ----------------- Part 6: Mediators  ------------------------------

# sample size
n <- 3000

# X is Bernoulli random
X <- sample(c(0,1), size = n, replace = TRUE)

# X causes Z plus some noise
Z <- 2*X + rnorm(n,0,1)

# Z causes Y plus some noise
Y <- 2*Z + rnorm(n,0,1)

# put it together in a dataframe
data <- tibble(X,Y,Z)

'****************************************************************************
  EXERCISE: Draw the DAG. What is the true causal effect of X on Y? 
    - (Hint: If you increase X by 1, what happens to Y?)
    - What specification of lm() recovers the true causal effect?
******************************************************************************'
