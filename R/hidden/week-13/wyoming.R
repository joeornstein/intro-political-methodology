library(tidyverse)
library(here)

load( here('data/ces-2020/cleaned-CES.RData') )


## Three steps to hypothesis testing:


## Step 1: Compute the test statistic

avg_wyoming_age <- ces |> 
  filter(abb == 'WY') |> 
  pull(age) |> 
  mean()

n <- ces |> 
  filter(abb == 'WY') |> 
  nrow()


## Step 2: Generate the sampling distribution under the Null Hypothesis

mean_sample_age <- function(){
  
  null_wyoming <- ces |> 
    slice_sample(n = 95)
  
  return(mean(null_wyoming$age))
  
  
}

sampling_distribution <- replicate(20000, mean_sample_age())

ggplot(mapping = aes(x = sampling_distribution)) +
  geom_histogram(color = 'black')

## Step 3: Compute a p-value

sum(sampling_distribution > avg_wyoming_age)

pval <- sum(sampling_distribution > avg_wyoming_age) / length(sampling_distribution)



## Here's the solution, but with math:

# I know that the sampling distribution will be normally distributed

# I know that it's unbiased (centered around the truth)
# I also know (for reasons you can look up in the footnotes on the website)
# that the standard error is equal to sigma / sqrt(n)

# So instead of sampling 20,000 times from the population,
# I'll just use what I know about the normal distribution

wyoming_sample <- ces |> 
  filter(abb == 'WY')

expected_value <- mean(ces$age)

# the move that we're gonna make for estimating the standard error
# is to plug in the standard deviation from the sample
standard_error <- sd(wyoming_sample$age) / sqrt(95)


# plot a normal distribution
x <- seq(40, 60, 0.001)
f <- dnorm(x, mean = expected_value, sd = standard_error)

ggplot(mapping = aes(x=x, y=f)) +
  geom_line()

ggplot() + 
  geom_histogram(mapping = 
                   aes(x=sampling_distribution, 
                       y = ..density..), 
                 color = 'black', fill = 'gray',
                 binwidth=0.5) + 
  geom_line(mapping = aes(x=x, y=f),
            color = 'red') +
  theme_minimal()



pnorm(avg_wyoming_age,
      mean = expected_value,
      sd = standard_error,
      lower.tail = FALSE)

1 - pnorm(avg_wyoming_age,
      mean = expected_value,
      sd = standard_error)

# What's the probability that we get a value between 
# 48.3 and 52.1 purely from sampling error?
# F(52.1) - F(48.3)

pnorm(52.1, 
      mean = expected_value,
      sd = standard_error) - 
  pnorm(48.3,
        mean = expected_value,
        sd = standard_error)
