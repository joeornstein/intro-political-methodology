# ---
# title: Find the line of best fit
# author: Joe Ornstein
# date: 2021-09-27
# ---

library(tidyverse)

# dataset downloaded from https://www.chesdata.eu/1999-2019chestrend 
# and cleaned up in R/week-07/cleanup-data.R
ches <- read_csv('data/ches/ches-cleaned.csv')


# create a scatter plot of the data
p <- ggplot(data = ches,
       mapping = aes(x = social, y = economic)) +
  geom_point(alpha = 0.6) +
  theme_bw() +
  scale_y_continuous(limits = c(-5, 5)) +
  scale_x_continuous(limits = c(-5, 5)) +
  labs(title = 'European Political Parties (2019)',
       caption = 'Measures from the Chapel Hill Expert Survey (Bakker et al., 2019)',
       x = 'Position on Social Issues',
       y = 'Position on Economic Issues')

p

# add the line of best fit
p +
  geom_smooth(method = 'lm', se = FALSE)

# the lm() function estimates the slope of the best fit line
lm(economic ~ social, data = ches)

# but where does that line come from???