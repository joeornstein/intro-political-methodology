# Flower Analysis
# Author: Joe Ornstein
# Date: November 4, 2020

library(tidyverse)


# Estimate linear model --------------



lm_fit <- lm(Petal.Length ~ Sepal.Length + Sepal.Width + Petal.Width,
             data = iris)

summary(lm_fit)

old_fit <- lm(Petal.Length ~ Petal.Width, data = iris)

summary(old_fit)

# Previously 2.22, now 1.45.
# Why? Because flowers.


# Explore the correlation between Sepal Length and Petal Length
cor(iris$Sepal.Length, iris$Petal.Width)

ggplot(iris) + 
  geom_point(aes(x=Sepal.Length, y=Petal.Width))


# Problem 2: t-test ------------------

iris %>% 
  filter(Species %in% c('setosa','versicolor')) %>% 
  t.test(Petal.Length ~ Species, data = .)

# Problem 3: lm() -------------

linear_model2 <- lm(Petal.Length ~ Species, data = iris)
summary(linear_model2)
