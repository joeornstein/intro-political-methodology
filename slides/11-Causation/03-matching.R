# Conditioning on a Collider
# Author: Joe Ornstein (jornstein@uga.edu)
# Date: November 8, 2020
# Version: 1.0

library(tidyverse)

# Specify Data-Generating Process (DGP) ------------------------

n <- 1000

# X ~ Std Normal
X <- rnorm(n, 0, 1)

# X causes Y
Y <- 3*X + rnorm(n, 0, 2)

# X and Y jointly cause Z
Z <- 4*X + 3*Y + rnorm(n, 0, 1)

# create training and testing datasets
data <- tibble(X,Y,Z)

train <- data %>% 
  sample_frac(0.7)

test <- data %>% 
  anti_join(train)


# Estimate models -------------------------------------

# unconfounded
lm1 <- lm(Y ~ X, data = train)

# confounded
lm2 <- lm(Y ~ X + Z, data = train)

summary(lm1)
summary(lm2) # Simpson's Paradox!

# Prediction ---------------------------------------

# Conditioning on collider bad for causal inference...
# But is it bad for prediction?

test <- test %>% 
  mutate(Yhat1 = predict(lm1, test),
         Yhat2 = predict(lm2, test))


ggplot(test) + 
  geom_point(aes(x=Yhat1,y=Y))

ggplot(test) + 
  geom_point(aes(x=Yhat2,y=Y)) # prediction is better!

sum((test$Yhat1 - test$Y)^2)
sum((test$Yhat2 - test$Y)^2) # sum of squared errors is ~40 times lower!


## Let's see if we can find an empirical collider ---------------------------

load('slides/10-Prediction/data/anes_pilot_2019.RData')

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
lm4 <- lm(fttrump ~ age + pro_impeachment + vote16, data = data)

summary(lm3)
summary(lm4)
