#' ---
#' title: Clean CES 2020
#' author: Joe Ornstein
#' date: 2021-08-09
#' version: 0.1
#' description: Import and clean up data from the 2020 Cooperative Election Study
#' ---

library(tidyverse)
library(janitor)

# load original data
ces_raw <- read_csv('data/raw/ces-2020/CES20_Common_OUTPUT_vv.csv') %>% 
  # clean up the names (janitor function)
  clean_names()

d <- ces_raw %>%
  # recode some variables
  mutate(gender = if_else(gender == 1, 'Male', 'Female'),
         educ = case_when(educ == 1 ~ 'No HS',
                          educ == 2 ~ 'High school graduate',
                          educ == 3 ~ 'Some college',
                          educ == 4 ~ '2-year',
                          educ == 5 ~ '4-year',
                          educ == 6 ~ 'Post-grad'),
         race = case_when(race == 1 ~ 'White',
                          race == 2 ~ 'Black',
                          race == 3 ~ 'Hispanic',
                          race == 4 ~ 'Asian',
                          TRUE ~ 'Other'),
         age = 2020 - birthyr, 
         national_economy = case_when(cc20_302 == 1 ~ 'Gotten much better',
                                      cc20_302 == 2 ~ 'Gotten somewhat better',
                                      cc20_302 == 3 ~ 'Stayed about the same',
                                      cc20_302 == 4 ~ 'Gotten somewhat worse',
                                      cc20_302 == 5 ~ 'Gotten much worse',
                                      cc20_302 == 6 ~ 'Not sure'),
         someone_diagnosed_with_covid = if_else(cc20_309a_5 == 2, 'Yes', 'No'),
         trump_approval = case_when(cc20_320a == 1 ~ 'Strongly approve',
                                    cc20_320a == 2 ~ 'Somewhat approve',
                                    cc20_320a == 3 ~ 'Somewhat disapprove',
                                    cc20_320a == 4 ~ 'Strongly disapprove',
                                    cc20_320a == 5 ~ 'Not sure'),
         lost_work_during_covid = if_else(cc20_309c_1 == 1 |
                                              cc20_309c_2 == 1 |
                                              cc20_309c_3 == 1 |
                                              cc20_309c_4 == 1 |
                                              cc20_309c_5 == 1 |
                                              cc20_309c_6 == 1, 
                                          'Yes', 'No'))

# inputstate is a fips code. merge with maps::state.fips to get state names
state_names <- maps::state.fips %>% 
  select(fips, abb) %>% 
  # missing alaska and hawaii
  bind_rows(
    tibble(
      fips = c(2, 15),
      abb = c('AK', 'HI'))) %>% 
  unique %>% 
  arrange(fips)

d <- d %>% 
  mutate(fips = inputstate) %>% 
  left_join(state_names, by = 'fips') %>% 
  # select the variables you want
  select(caseid, gender, educ, race, age, abb, national_economy,
         someone_diagnosed_with_covid, lost_work_during_covid,
         trump_approval) %>% 
  # order the factor variables
  mutate(national_economy = factor(national_economy,
                                   levels = c('Not sure', 'Gotten much worse',
                                              'Gotten somewhat worse', 'Stayed about the same',
                                              'Gotten somewhat better', 'Gotten much better')),
         trump_approval = factor(trump_approval,
                                 levels = c('Strongly disapprove', 'Somewhat disapprove',
                                            'Not sure', 'Somewhat approve', 'Strongly approve')))

# write cleaned dataset to file
save(d, file = 'data/ces-2020/cleaned-CES.RData')
