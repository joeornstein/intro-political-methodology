

library(tidyverse)

load('data/ces-2020/cleaned-CES.RData')

# the true average age in the population
mu <- mean(ces$age)

# this function draws a sample of ages and computes the t statistic (how many standard errors away from the truth is the sample mean?)
get_t_statistic <- function(n = 10){
  
  # draw the sample
  sample_ages <- ces$age[ sample(1:nrow(ces), size = n) ]
  
  # xbar is the sample mean
  xbar <- mean(sample_ages)
  
  # s is the sample standard deviation
  s <- sd(sample_ages)
  
  # return the t statistic
  (xbar - mu) / (s / sqrt(n))
  
}

get_t_statistic()

sample_size <- 200

# do that a bunch of times
sampling_distribution <- replicate(100000,
                                   get_t_statistic(n = sample_size))

p <- ggplot() +
  geom_histogram(mapping = aes(x=sampling_distribution,
                               y=..density..),
                 binwidth = 0.15,
                 color = 'black')
p

# overlay a normal distribution
expected_value <- mean(sampling_distribution)
standard_error <- sd(sampling_distribution)

x <- seq(min(sampling_distribution),
         max(sampling_distribution),
         0.01)
f_norm <- dnorm(x, mean = expected_value,
                sd = standard_error)

p <- p +
  geom_line(mapping = aes(x=x, y=f_norm),
            color = 'red')

p

# overlay a Student's t distribution
x <- seq(min(sampling_distribution),
         max(sampling_distribution),
         0.01)
f_t <- dt(x, df = sample_size - 1)

p <- p +
  geom_line(mapping = aes(x=x, y=f_t),
            color = 'blue')

p


## T-tests the easy way......


# compute a 95% confidence interval around the sample mean
# (one sample t-test)
t.test(sample_data$age)

t.test(ces %>% slice_sample(n = 100) %>% pull(age))

t.test(ces %>% slice_sample(n = 1000) %>% pull(age))

# difference-in-means test

# clean it up so variables are 0-1
ces <- ces %>% 
  select(gender, china_tariffs) %>% 
  # remove the missing values
  na.omit %>% 
  mutate(female = as.numeric(gender == 'Female'),
         support_tariffs = as.numeric(china_tariffs == 'Support'))


sample_data <- ces %>% 
  slice_sample(n = 100)

# the t test
t.test(support_tariffs ~ female, data = sample_data)
