
library(tidyverse)

# load the CES dataset
load('data/ces-2020/cleaned-CES.RData')

# recode TV news viewership as a 0-1 variable
ces <- mutate(ces, tv_news_24h = as.numeric(tv_news_24h == 'Yes'))

# the population parameter (or the "truth")
mean(ces$tv_news_24h)


# suppose that we didn't know the truth, and we just had a small sample
sample_data <- slice_sample(ces, n = 100)

# what's my sample estimate?
mean(sample_data$tv_news_24h)

# if we want to keep the randomness the same across runs
set.seed(42)

# draw another sample estimate
sample_data <- slice_sample(ces, n = 100)
mean(sample_data$tv_news_24h)

# the sampling distribution takes that sampling process,
# but does it an enormous number of times

# first, I'm going to create a function that generates a sample estimate
get_sample_estimate <- function(sample_size = 100){
  sample_data <- slice_sample(ces, n = sample_size)
  mean(sample_data$tv_news_24h)
}

get_sample_estimate()

get_sample_estimate(sample_size = 10000)

get_sample_estimate(sample_size = 10)


# let's run that function 25,000 times
sampling_distribution <- replicate( 25000,
                                    get_sample_estimate() )


# let's plot that sampling distribution
ggplot(mapping = aes(x = sampling_distribution)) +
  geom_histogram(color = 'black', binwidth = 0.01)

max(sampling_distribution)
min(sampling_distribution)


# what's the average of our sampling distribution?
mean(sampling_distribution)

# this is called the Expected Value of our statistic
# what we would expect to happen on average across repeated samples

# we say that our estimator is *unbiased* if its expected value
# equals the true population parameter.

# the sample mean is an unbiased estimator of the population mean


# BUT

# the thing we're *really* interested in is sampling variability
# how far might our particular sample be from the truth?
var(sampling_distribution)

# variance is the average *squared* distance from the mean

# squared distances are difficult to interpret
# so typically we desquare them (square root)
sqrt(var(sampling_distribution))

# that's called the standard deviation
sd(sampling_distribution)

# the sd of the sampling distribution is called the *standard error*

## The shape of the sampling distribution ------------------

# It's normally distributed!!

# roughly 68% of samples will fall within 1 sd of the truth
expected_value <- mean(sampling_distribution)
standard_error <- sd(sampling_distribution)

sampling_distribution |> 
  tibble() |> 
  summarize(samples_within_1sd = sum(sampling_distribution < expected_value + standard_error &
                                       sampling_distribution > expected_value - standard_error),
            pct_within_1sd = samples_within_1sd / n() * 100)

# about 95% fall within 2 sd of the truth
sampling_distribution |> 
  tibble() |> 
  summarize(samples_within_1sd = sum(sampling_distribution < expected_value + 2*standard_error &
                                       sampling_distribution > expected_value - 2*standard_error),
            pct_within_1sd = samples_within_1sd / n() * 100)


# and about 99.7% fall within 3 standard deviations
sampling_distribution |> 
  tibble() |> 
  summarize(samples_within_1sd = sum(sampling_distribution < expected_value + 3 * standard_error &
                                       sampling_distribution > expected_value - 3 * standard_error),
            pct_within_1sd = samples_within_1sd / n() * 100)

