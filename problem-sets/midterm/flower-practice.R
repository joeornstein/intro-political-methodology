## Practice with FLOWERS!!!
## Author: Joe Ornstein
## Date: October 21, 2020

library(tidyverse)

## Question 1: Are sepals bigger or smaller for some species?

iris %>% 
  group_by(Species) %>% 
  summarize(mean_sepal_width = mean(Sepal.Width),
            mean_sepal_length = mean(Sepal.Length))

# visualize it
ggplot(data = iris) +
  geom_point(aes(x = Sepal.Length, y = Sepal.Width)) +
  facet_wrap(~Species)

# visualize it with COLOR
ggplot(data = iris) +
  geom_point(aes(x = Sepal.Length, y = Sepal.Width, color = Species))


# sepal length statistically bigger for virginicas?
iris %>% 
  filter(Species != 'versicolor') %>% 
  t.test(Sepal.Length ~ Species, data = .)


## Question 2: Sepal Width and Petal Length ---------------

cor(iris$Sepal.Width, iris$Petal.Length)

linear_model_fit <- lm(Petal.Length ~ Sepal.Width, data = iris)

coef(linear_model_fit)

# what if we switched the Y and X variables?
linear_model_fit <- lm(Sepal.Width ~ Petal.Length, data = iris)

coef(linear_model_fit)


## Question 3: Variance in Petal Length by species -----------------

iris %>% 
  group_by(Species) %>% 
  summarize(var_petal_length = var(Petal.Length))

## Question 4: Correlation grouped by species --------------------

iris %>% 
  group_by(Species) %>% 
  summarize(length_correlation = cor(Petal.Length, Sepal.Length))

## Question 5: Standardized Petal Width ------------------

iris <- iris %>% 
  mutate(standardized_petal_width = (Petal.Width - mean(Petal.Width)) / 
           sd(Petal.Width))

mean(iris$standardized_petal_width)
sd(iris$standardized_petal_width)

cor(iris$standardized_petal_width, iris$Petal.Width)

ggplot(iris) + 
  geom_point(aes(x=Petal.Width, y = standardized_petal_width))
