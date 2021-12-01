


library(tidyverse)

load('data/ces-2020/cleaned-CES.RData')

# clean it up so variables are 0-1
ces <- ces %>% 
  select(gender, china_tariffs) %>% 
  # remove the missing values
  na.omit %>% 
  mutate(female = as.numeric(gender == 'Female'),
         support_tariffs = as.numeric(china_tariffs == 'Support'))

# in the population, do men support tariffs more than women?
ces %>% 
  group_by(female) %>% 
  summarize(mean_tariff_support = mean(support_tariffs))

# 200 teams of researchers
# survey 100 Americans at random

sample_data <- ces %>% 
  slice_sample(n = 100)

lm1 <- lm(support_tariffs ~ female, data = sample_data)

summary(lm1)
