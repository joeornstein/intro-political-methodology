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
                               liveurban == 4 ~ 'City'),
         pew_religimp = case_when(pew_religimp == 1 ~ 'Very Important',
                                  pew_religimp == 2 ~ 'Somewhat Important',
                                  pew_religimp == 3 ~ 'Not too important',
                                  pew_religimp == 4 ~ 'Not at all important'),
         marstat = case_when(marstat == 1 ~ 'Married',
                             marstat == 2 ~ 'Separated',
                             marstat == 3 ~ 'Divorced',
                             marstat == 4 ~ 'Widowed',
                             marstat == 5 ~ 'Never Married',
                             marstat == 6 ~ 'Domestic Partnership'),
         child18 = if_else(child18 == 1, 'Yes', 'No'),
         facebook_user = if_else(socmed_1 == 1, 'Yes', 'No'),
         twitter_user = if_else(socmed_2 == 2, 'Yes', 'No'),
         instagram_user = if_else(socmed_3 == 2, 'Yes', 'No'),
         reddit_user = if_else(socmed_4 == 2, 'Yes', 'No'),
         youtube_user = if_else(socmed_5 == 2, 'Yes', 'No'),
         snapchat_user = if_else(socmed_6 == 2, 'Yes', 'No'),
         tiktok_user = if_else(socmed_7 == 2, 'Yes', 'No'),
         pro_dream = as.numeric(dreamer == 2)) %>% 
  filter(ftbiden %in% 0:100,
         fttrump %in% 0:100,
         !is.na(ideo5),
         !is.na(bmi))

