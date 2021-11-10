# Regression Discontinuity Designs
# Replicating the Klasjna & Titiunik (2017) paper


## Step 1: Load and clean the data ----------------------

library(tidyverse)

raw <- read_csv('data/klasnja-titiunik-2017/KlasnjaTitiunik-LAcountries-data.csv')

# keep the Brazilian elections only
brazil <- ???

## Step 2: Recreate Figure 1 -----------------------

# attempt 1: plot the raw data
ggplot(data = brazil, 
       mapping = aes(x = mv_incumbent,
                     y = post_winning_incumbent_unc)) +
  geom_point(alpha = 0.4) +
  geom_vline(xintercept = 0, color = 'red') +
  theme_classic() +
  labs(x = 'Incumbent Party Vote Margin at t',
       y = 'Probability of Unconditional Victory t+1')

# attempt 2: bin the data
p <- ggplot(data = filter(brazil, abs(mv_incumbent) < 30), 
       mapping = aes(x = mv_incumbent,
                     y = post_winning_incumbent_unc)) +
  stat_summary_bin(fun = 'mean', breaks = -100:100,
                   geom = 'point', shape = 'square') +
  geom_vline(xintercept = 0, color = 'red') +
  theme_classic() +
  labs(x = 'Incumbent Party Vote Margin at t',
       y = 'Probability of Unconditional Victory t+1')

p

## Step 3: Fit a linear model on either side ---------

lm_left <- ???
lm_right <- ???
  
# subtract the predicted value from lm_right and the predicted value from lm_left
left_prediction <- predict(lm_left,
                           data.frame(mv_incumbent=0))
right_prediction <- predict(lm_right,
                            data.frame(mv_incumbent=0))

right_prediction - left_prediction

## Step 4: Try the rdrobust package instead --------------

library(rdrobust)

rdfit <- rdrobust(y = brazil$post_winning_incumbent_unc,
                  x = brazil$mv_incumbent,
                  c = 0)

summary(rdfit)
