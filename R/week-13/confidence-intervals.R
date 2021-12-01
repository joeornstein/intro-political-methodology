## confidence intervals

# suppose I have a random sample and I want to generate a 
# 95% confidence interval for average age


library(tidyverse)

load('data/ces-2020/cleaned-CES.RData')


truth <- mean(ces$age)

# draw sample
sample_data <- ces %>% 
  slice_sample(n = 10)

# estimate
estimate <- mean(sample_data$age)

# standard error
standard_error <- sd(sample_data$age) / sqrt(10)

# confidence interval
ci <- c(estimate - 1.96 * standard_error,
        estimate + 1.96 * standard_error)

ci
