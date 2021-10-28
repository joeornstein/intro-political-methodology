# ---
# DAG exercise
# ---

library(tidyverse)

# load the DAG exercise data
d <- read_csv('data/causal-inference/dag-data.csv')


ggplot(data = d,
       mapping = aes(x=X, y=Y, color = factor(U))) +
  geom_point()

lm(Y~X, data = d)

lm(Y~ X + Q + U, data = d)



## Front Door Path

# P is an instrument, because it causes X, 
# but does not cause Y except through X


# This estimation proceeds in two stages.
# (It's called two-stage least squares - 2SLS)


# Stage 1: Find the causal relationship between P and X,
# and get the values you would predict for X based on that relationship

stage1 <- lm(X ~ P, data = d)

stage1

d <- mutate(d,
            predicted_x = stage1$fitted.values)

ggplot(data = d,
       mapping = aes(x=P, y=X)) + 
  geom_point() +
  geom_smooth(method = 'lm', se = FALSE)

# Stage 2: Find the correlation between those *predicted*
# values for X and the outcome Y

lm(Y ~ predicted_x, data = d)
