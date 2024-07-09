##Midterm Project

library(tidyverse)

# note: these are superfluous if you've already loaded tidyverse!
# library(dplyr) 
#library(ggplot2)

load('data/raw/WVS_Cross-National_Wave_7_R_v2_0.rdata')
# View(`WVS_Cross-National_Wave_7_v2_0`)


# create a cleaned up version of the dataset
d <- `WVS_Cross-National_Wave_7_v2_0` %>%
  
  # keep the importance of university, country, and housewife variables
  select(country= C_COW_ALPHA, importance_of_university= Q30, housewife_value= Q32) %>%
  
  # filter out the missing value codes
  filter(importance_of_university>0, housewife_value >0) %>%
  
  # (JO: this line seemed unnecessary to me, so I commented it out)
  # group_by(country) %>% 
  
  # recode them as character variables
  mutate(importance_of_university= case_when ( importance_of_university == 1 ~ 'Agree Strongly',
                                               importance_of_university == 2 ~ 'Agree',
                                               importance_of_university == 3 ~ 'Disagree',
                                               importance_of_university == 4 ~ 'Strongly Disagree')) %>%
  
  mutate(housewife_value = case_when( housewife_value == 1 ~ 'Agree Strongly',
                                      housewife_value == 2 ~ 'Agree',
                                      housewife_value == 3 ~ 'Disagree',
                                      housewife_value == 4 ~ 'Strongly Disagree')) %>%
  
  # reorder the factor variables so they display in the right order on the chart
  mutate(importance_of_university = factor(importance_of_university,
                                           levels = c('Strongly Disagree', 'Disagree',
                                                      'Agree', 'Agree Strongly')),
         housewife_value = factor(housewife_value,
                                  levels = c('Strongly Disagree', 'Disagree',
                                             'Agree', 'Agree Strongly'))) %>% 

  # keep a subset of countries
 filter(country %in% c('GMY','LEB', 'THI', 'RUS', 'USA', 'CHN', 'ZIM', 'MEX', 'TUR', 'NIG'))

p <- ggplot(data = d,
            mapping = aes(x=importance_of_university, y=housewife_value)) +
  # added some transparency to the points here
  geom_jitter(alpha = 0.5) +
  theme_minimal() +
  facet_wrap(~country) +
  labs(x= 'Higher Importance of University for Boys', y = 'Perceived Equal Value of Being a Housewife')

p

# ggsave to file
ggsave(filename = 'R/week-06-midterm/alma.png', width = 18, height = 12)
