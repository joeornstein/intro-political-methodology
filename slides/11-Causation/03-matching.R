# Matching Estimators
# Author: Joe Ornstein (jornstein@uga.edu)
# Date: November 14, 2020
# Version: 1.0

library(tidyverse)
set.seed(42)

# What if the data-generating process is nonlinear? Do linear models produce good estimates?

# sample size
n <- 5000

# the true causal effect; this is what we want to estimate!
beta <- 4

# X1 is distributed normally
X1 <- rnorm(n,0,1)

# X2 is distributed normally
X2 <- rnorm(n,0,2)

# Tr (the treatment) is caused by X1 and X2 in a weird nonlinear fashion
Tr <- if_else(X1 + X2^2 - rnorm(n,0,4) < 1, 1, 0)
# (more likely to be in the treatment group if X1 and X2 are both close to zero)

# Y is caused by Tr, X1, and X2 in a weird nonlinear fashion plus some noise
Y <- beta*Tr - 2*X1^3 + 3*X2^2 + rnorm(n,0,2)

data <- tibble(Y,Tr,X1,X2)


'****************************************************************************
  EXERCISE: Conduct a difference-in-means test. Is the Y value for the 
  treatment group larger than the Y value for the control group?
******************************************************************************'

lm1 <- lm(Y~Tr,data=data)
summary(lm1)

t.test(Y~Tr, data = data)

# The problem with just taking the raw difference in means: the covariates are imbalanced
ggplot(data = data) +
  geom_histogram(aes(x=X1,fill=factor(Tr)), 
                 alpha = 0.6, position = 'identity') +
  labs(fill = 'Treated')

ggplot(data = data) +
  geom_histogram(aes(x=X2,fill=factor(Tr)), 
                 alpha = 0.6, position = 'identity') +
  labs(fill = 'Treated')


'****************************************************************************
  EXERCISE: Condition on X1 and X2 using a linear model. Does that solve
  the problem?
******************************************************************************'

lm2 <- lm(Y~Tr+X1+X2,data=data)
summary(lm2) # but oh no, conditioning with lm() makes it worse!

## What in the holy heckfire do we do?
## Answer: condition on the confounders, but not with a linear model

## Matching Estimators: find a (possibly weighted) control group where the pretreatment covariates are 
## 'balanced' across groups (don't significantly differ). Then compare means as usual!

# library(ebal)
# X <- cbind(X1,X2)
# eb.out <- ebalance(Treatment=Tr,
#                    X=X)
# 
# apply(X[Tr==1,],2,mean)
# apply(X[Tr==0,],2,weighted.mean,w=eb.out$w)
# apply(X[Tr==0,],2,mean)
# 
# mean(Y[Tr==1])
# weighted.mean(Y[Tr==0], eb.out$w)


library(Matching)
m <- Match(Y = Y, Tr = Tr, X = cbind(X1,X2))
# summary(m)
#MatchBalance(Tr ~ X1 + X2, match.out = m)

matched_control_group <- data[m$index.control,]
treatment_group <- data[m$index.treated,]

# t.test(treatment_group$X1, matched_control_group$X1)
# t.test(treatment_group$X2, matched_control_group$X2)
# t.test(treatment_group$Y, matched_control_group$Y)

summary(m)

# notes: when does this work?
# only if you assume "selection on observables" (aka; believe the DAG)
# and you have enough overlap on those covariates to find matches for everyone in the treatment group.