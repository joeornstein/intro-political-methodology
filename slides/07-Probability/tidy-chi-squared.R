## Tidy Chi-Squared Tests
## Author: Joe Ornstein
## Date: October 7, 2020

## Inspiration: http://ritsokiguess.site/docs/2018/04/12/tidy-chi-squared-testing/
## And: https://richpauloo.github.io/2018-02-03-Tidy-Chi-Squared-stats-in-infer/
## And: https://github.com/andrewpbray/talks/blob/master/2018/infer-rstudioconf-2018.pdf


library(tidyverse)
library(broom)



## First, the example from Kellstedt & Whitten (Table 8.7) --------------------------

table_8_7 <- tibble(male = c(170, 204),
                    female = c(229, 208))

chisq.test(table_8_7, correct = FALSE) # replicated!

chisq.test(table_8_7, correct = FALSE) %>% 
  tidy

## Suppose we had that table in a tidy tibble ------------------------------------------

data <- tibble(sex = c(rep('male', 170), rep('female', 229), rep('male', 204),  rep('female', 208)),
               vote = c(rep('Kerry', 170+229), c(rep('Bush', 204+208))),
               random_nonsense = rnorm(811, 0, 1))

data %>%
  select(sex, vote) %>%
  table

data %>% 
  select(sex, vote) %>% 
  table %>% 
  chisq.test(correct = FALSE)


data %>% 
  select(sex, vote) %>% 
  table %>% 
  chisq.test(correct = FALSE) %>% 
  tidy


## Monte Carlo ------------------------------------

# Load CCES
CCES <- read_rds('slides/07-Probability/data/CCES_2018.RDS') %>% 
  mutate(gender = if_else(gender == 1, 'Male', 'Female'),
         age = 2018 - birthyr,
         party = case_when(pid3 == 1 ~ 'Democrat',
                           pid3 == 2 ~ 'Republican',
                           pid3 == 3 ~ 'Independent')) %>% 
  filter(!is.na(party))

CCES %>% 
  select(gender, party) %>% 
  table

CCES %>% 
  ggplot() +
  geom_bar(mapping = aes(x=gender,fill=party), position = 'fill')


# Draw a sample
n <- 1000

CCES_sample <- CCES %>% 
  sample_n(size = n)

CCES_sample %>% 
  ggplot() +
  geom_bar(mapping = aes(x=gender,fill=party), position = 'fill')

CCES_sample %>% 
  select(gender, party) %>% 
  table %>% 
  chisq.test

observed_table <- CCES_sample %>% 
  select(gender, party) %>% 
  table

observed_table

## Expected Table --------------------------------

# This is a nice three-line, but only if they know about outer products? And they don't have matrix algebra or anything
gender_marginal_distribution <- table(CCES_sample$gender) / nrow(CCES_sample)
party_marginal_distribution <- table(CCES_sample$party) / nrow(CCES_sample)
expected_table <- outer(gender_marginal_distribution, party_marginal_distribution) * nrow(CCES_sample)

# Try this instead
gender_breakdown <- CCES_sample %>% 
  select(gender) %>% 
  table
party_breakdown <- CCES_sample %>% 
  select(party) %>% 
  table # these are the 'marginal' distributions

party_distribution <- party_breakdown / nrow(CCES_sample)

expected_table <- outer(gender_breakdown, party_distribution)

expected_table

observed_table - expected_table

observed_chi_squared_statistic <- sum((observed_table - expected_table)^2 / expected_table)


## Null Distribution -----------------------------------------

# party unrelated to gender
num_female <- CCES_sample %>% 
  filter(gender == 'Female') %>% 
  nrow

num_male <- CCES_sample %>% 
  filter(gender == 'Male') %>% 
  nrow


null_female_sample <- CCES %>% 
  select(party) %>% 
  sample_n(size = num_female) %>% 
  mutate(gender = 'Female')

null_male_sample <- CCES %>% 
  select(party) %>% 
  sample_n(size = num_male) %>% 
  mutate(gender = 'Male')

null_sample <- bind_rows(null_female_sample, null_male_sample)

null_table <- null_sample %>% 
  select(gender, party) %>% 
  table

null_table - expected_table

null_chi_squared <- sum((null_table - expected_table)^2 / expected_table)


get_null_chi_squared <- function(data, n){
  
  # get a random sample of the party variable
  party <- data %>% 
    pull(party) %>% 
    sample(size = n)
  
  # get a random sample of the gender variable
  gender <- data %>% 
    pull(gender) %>% 
    sample(size = n)
  
  # create the table
  null_table <- table(gender, party)
  
  # return the chi-squared statistic
  sum((null_table - expected_table)^2 / expected_table)
}

get_null_chi_squared(data = CCES_sample, n = 1000) # note: using the CCES sample here so it's a permutation test

sampling_distribution <- replicate(10000, get_null_chi_squared(data = CCES_sample, n = 1000))

tibble(sampling_distribution) %>% 
  ggplot() +
  geom_histogram(aes(x=sampling_distribution), color = 'black') +
  theme_bw() +
  geom_vline(xintercept = observed_chi_squared_statistic, linetype = 'dashed', color = 'red')

sum(sampling_distribution > observed_chi_squared_statistic) / length(sampling_distribution)

observed_chi_squared_statistic

chisq.test(observed_table)

# TODO: Why is the result so off when I draw from the population? Check out 1977 Monte Carlo paper.