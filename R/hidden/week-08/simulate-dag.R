# ---
# title: Simulate data for in-class exercise
# author: Joe Ornstein
# date: 2021-10-06
# ---

library(tidyverse)
library(dagitty)
library(ggdag)

set.seed(2)

dag <- dagify(Y ~ Z + Q + U + X,
              W ~ Y + P,
              D ~ X + Q + R,
              X ~ R + U + P,
              R ~ Q, 
              Z ~ U)

ggdag_classic(dag) +
  theme_dag()

isAcyclic(dag)

adjustmentSets(dag, exposure = 'X', outcome = 'Y')
instrumentalVariables(dag, exposure = 'X', outcome = 'Y')

## simulate data
n <- 3000

# exogenous
exogenousVariables(dag)
U <- sample(c(0,1), size = n, replace = TRUE)
Q <- sample(c(0,1), size = n, replace = TRUE)
P <- rnorm(n)

# endogenous
R <- as.numeric(Q + rnorm(n) > 0.5)
X <- R + U - P + rnorm(n)
Z <- as.numeric(U + rnorm(n) > 0.5)
D <- as.numeric(X + Q + R + rnorm(n) > 1)
Y <- 3*Z - 4*Q - 6*U + X + rnorm(n)
W <- as.numeric(Y + P + rnorm(n) > -2)

data <- tibble(D,P,Q,R,U,W,X,Y,Z)

write_csv(data, 'data/causal-inference/dag-data.csv')

## The confounded relationship -----------------

plot(X,Y)
lm(Y~X, data = data)

## Estimate by closing the back doors -----------

lm(Y~X + U + R)

lm(Y~X, data = filter(data, U == 1, R == 1))


## Estimate by finding a front door ------------------

# first stage: use P to predict X
lm1 <- lm(X ~ P, data = data)
data <- mutate(data, predicted_x = lm1$fitted.values)

# second stage: model the relationship between *predicted* X (the part of X explained by the instrument) and Y
lm2 <- lm(Y ~ predicted_x, data = data)
lm2
