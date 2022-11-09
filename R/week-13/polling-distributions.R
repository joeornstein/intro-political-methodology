
library(tidyverse)

# create a dataset with the actual vote numbers
truth <- tibble(vote = 
                  c(
                    rep('Democratic', 1941499),
                    rep('Republican', 1906246),
                    rep('Libertarian', 81175)
                  ))


# before the election, we did not know The Truth. We could only *glimpse* 
# The Truth

# let's focus on one source of error: sampling error
# Before the election, we didn't have access to all 3.9 million voters
# we just had access to 500 or 1,000 at a time.
# so that gives us an incomplete picture of what's going on in the race



# let's simulate that process:

poll_size <- 500

poll <- truth |> 
  slice_sample(n = poll_size)

poll |> 
  count(vote) |> 
  mutate(pct = n / poll_size * 100)


# If you run this a *bunch* of times, you start to get a sense of the 
# *sampling distribution*, the distribution of outcomes you expect
# from sampling error alone.

# here's a function to take a poll and return the Democrat's vote margin
democratic_poll_margin <- function(poll_size = 500){
  
  # take the poll
  poll <- truth |> 
    slice_sample(n = poll_size)
  
  # return the Democratic vote margin
  dem_pct <- poll |> 
    filter(vote == 'Democratic') |> 
    nrow() / poll_size * 100
  
  rep_pct <- poll |> 
    filter(vote == 'Republican') |> 
    nrow() / poll_size * 100
  
  
  return(dem_pct - rep_pct)
  
}


democratic_poll_margin(poll_size = 500)


# default poll_size value is 500, so if I do this, it uses that default:
democratic_poll_margin()

# if I want something different than the default:
democratic_poll_margin(poll_size = 10)



# because I created this as a function, I can now call that function *a lot*

sampling_distribution <- replicate(100000,
                                   democratic_poll_margin())


hist(sampling_distribution)


## Expected Value -------------------

# on average, what should we expect the value of our sample statistic to be?
expected_value <- mean(sampling_distribution)
expected_value

# and whaddya know, the true Democratic margin is roughly the expected value
# of that sampling distribution
truth |> 
  count(vote) |> 
  mutate(pct = n / nrow(truth) * 100)

dem_pct <- truth |> 
  filter(vote == 'Democratic') |> 
  nrow() / nrow(truth) * 100

rep_pct <- truth |> 
  filter(vote == 'Republican') |> 
  nrow() / nrow(truth) * 100


true_margin <- dem_pct - rep_pct


# Unbiasedness:
# our sample statistic is an unbiased estimate of the truth
# if its expected value equals the truth

# Estimand = thing we're trying to estimate
true_margin

# Estimator = procedure we use to estimate
# democratic_vote_margin()

# Estimate = the value we get out of that estimator
democratic_poll_margin(poll_size = 500)

# Sampling Distribution = The distribution of estimates
# that we expect from sampling error alone



## Standard Error ------------------------

# variance is the average squared distance from the mean
distance <- sampling_distribution - expected_value
distance_squared <- distance ^ 2
variance <- mean(distance_squared)


var(sampling_distribution) # notice this value is *slightly* different
# than the value we computed manually

# variance is sum(distance^2) / (n - 1)
sum(distance^2) / 9999


# in practice, we typically take the square root of that variance
sqrt(var(sampling_distribution))

sd(sampling_distribution) # that's called the standard deviation


# THE STANDARD DEVIATION OF A SAMPLING DISTRIBUTION
# IS CALLED THE STANDARD ERROR


# What happens when we fiddle with the poll size?
sampling_distribution2 <- replicate(10000,
                                   democratic_poll_margin(poll_size = 2000))

sd(sampling_distribution2)


# standard error of a mean = standard deviation of the population / sqrt(n)


# THE CENTRAL LIMIT THEOREM

# The sampling distribution of a sample mean (or sample sum) is 
# approximately normally distributed

# Handy Rules:
# 68% of a normal distribution falls within 1 standard deviation of the mean
# 95% of a normal distribution falls within 2 standard deviations of the mean
# 99.7% falls within 3 standard deviations of the mean

sum(sampling_distribution > expected_value - 2 * sd(sampling_distribution) &
      sampling_distribution < expected_value + 2 * sd(sampling_distribution))

# This is called a *95% confidence interval*
# The expected value + or - 2 standard errors

# The margin of error = 2 * standard error

