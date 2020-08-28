# Clean and visualize ANES pilot data
# Author: Joe Ornstein
# Date: August 28, 2020

library(tidyverse)

# Load Data
load('data/anes_pilot_2019.RData')

# Clean Up Some Categorical Data

# Where did you live in your youth?
data$youthurban[data$youthurban == 1] <- 'Rural'
data$youthurban[data$youthurban == 2] <- 'Small Town'
data$youthurban[data$youthurban == 3] <- 'Suburb'
data$youthurban[data$youthurban == 4] <- 'City'

# Where do you live now?
data$liveurban[data$liveurban == 1] <- 'Rural'
data$liveurban[data$liveurban == 2] <- 'Small Town'
data$liveurban[data$liveurban == 3] <- 'Suburb'
data$liveurban[data$liveurban == 4] <- 'City'

## Plot youthurban vs. liveurban -----------------------

# Option 1
ggplot(data = data) + 
  geom_jitter(mapping = aes(x = youthurban, y = liveurban), size = 0.5)

# Option 2
ggplot(data = data) +
  geom_bar(mapping = aes(x=liveurban)) +
  facet_wrap(~ youthurban)