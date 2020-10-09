# Confidence Intervals


library(tidyverse)


# load CCES
CCES <- read_rds('slides/07-Probability/data/CCES_2018.RDS') %>% 
  mutate(gender = if_else(gender == 1, 'Male', 'Female'),
         age = 2018 - birthyr,
         party = case_when(pid3 == 1 ~ 'Democrat',
                           pid3 == 2 ~ 'Republican',
                           pid3 == 3 ~ 'Independent')) %>% 
  filter(!is.na(party))


# Mean age in the population
mean(CCES$age)

# Standard Deviation (sigma)
sd(CCES$age)

# draw a sample of ages and take the mean
mean_age_of_sample <- function(data, n){
  data %>%
    pull(age) %>%
    sample(size = n) %>%
    mean
}

# function to draw a sample and create a confidence interval
create_confidence_interval <- function(data, n){
  age_sample <- data %>% 
    pull(age) %>% 
    sample(size = n)
  
  confidence_interval_lower <- mean(age_sample) - 2 * sd(age_sample) / sqrt(n)
  confidence_interval_upper <- mean(age_sample) + 2 * sd(age_sample) / sqrt(n)
  
  c(confidence_interval_lower, confidence_interval_upper)
  
}

# draw 10,000 samples and compute confidence intervals
sampling_distribution <- replicate(10000, create_confidence_interval(data = CCES, n = 100))

head(sampling_distribution)

mean(CCES$age)

# split into upper and lower
ci_lower <- sampling_distribution[1,]
ci_upper <- sampling_distribution[2,]

# what percent of confidence intervals contain the true value?
sum(ci_lower < mean(CCES$age) & ci_upper > mean(CCES$age)) / length(ci_lower)
