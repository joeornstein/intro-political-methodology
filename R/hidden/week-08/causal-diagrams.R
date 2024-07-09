
# Draw some causal diagrams

library(tidyverse)
library(dagitty)
library(ggdag)

fork <- dagify(Y ~ Gender,
               X ~ Gender)

ggdag_classic(fork) + theme_dag()

# simulate some data using that Fork data generating process

# number of observations
n <- 1000
# create a data frame of simulated data
simulated_data <- tibble(
  # randomly assign each observation as female or male
  female = sample(c(0,1) , size = n, replace = TRUE),
  # X is caused by gender + some random value (epsilon)
  X = 2 * female + rnorm(n, 0 , 1),
  # Y is caused by gender + some random value (epsilon)
  Y = 3 * female + rnorm(n, 0 , 1)
)

ggplot(data = simulated_data,
       mapping = aes(x = X, y = Y)) +
  geom_point() +
  geom_smooth(method = 'lm', se = FALSE)
