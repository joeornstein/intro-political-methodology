# Load and Clean The ANES data
# Author: Joe Ornstein
# Date: November 4, 2020
# Version: 1.0

library(tidyverse)

# load the ANES pilot study
load('data/anes_pilot_2019.RData')

# recode some variables
data <- data %>% 
  mutate(age = 2019 - birthyr,
         female = as.numeric(gender == 2),
         race = case_when(race == 1 ~ 'White',
                          race == 2 ~ 'Black',
                          race == 3 ~ 'Hispanic',
                          TRUE ~ 'Other'),
         educ = case_when(educ == 1 ~ 'No HS',
                          educ == 2 ~ 'High school graduate',
                          educ == 3 ~ 'Some college',
                          educ == 4 ~ '2-year',
                          educ == 5 ~ '4-year',
                          educ == 6 ~ 'Post-grad'),
         vote20jb = case_when(vote20jb == 1 ~ 'Trump',
                              vote20jb == 2 ~ 'Biden',
                              vote20jb == 3 ~ 'Other',
                              vote20jb == 4 ~ 'Non-voter'),
         ideo5 = case_when(ideo5 == 1 ~ 'Very liberal',
                           ideo5 == 2 ~ 'Liberal',
                           ideo5 == 3 ~ 'Moderate',
                           ideo5 == 4 ~ 'Conservative',
                           ideo5 == 5 ~ 'Very conservative',
                           ideo5 == 6 ~ 'Not sure'),
         liveurban = case_when(liveurban == 1 ~ 'Rural',
                               liveurban == 2 ~ 'Small town',
                               liveurban == 3 ~ 'Suburban',
                               liveurban == 4 ~ 'City')) %>% 
  filter(ftbiden %in% 0:100)

lm_fit <- lm(ftjournal ~ age + female + liveurban + ftbiden + educ, data = data)
summary(lm_fit)

# Create predictions from the model
data <- data %>% 
  mutate(ftjournal_predicted = predict(lm_fit, data))

# Visualize predictions
ggplot(data) +
  geom_point(mapping = aes(x=ftjournal_predicted, y=ftjournal),
             alpha = 0.2) +
  labs(x = 'Predicted Feeling Thermometer (Journalists)',
       y = 'Actual Feeling Thermometer (Journalists)') +
  theme_bw() +
  geom_abline(intercept=0, slope = 1, linetype = 'dashed')
