# 24% of Members of 118th Congress are women


# 50% of Americans are women


# What is the probability that you'd end up with 24% purely by chance?


# What I'm setting up here is a classical *Hypothesis Test*


# I have some hypothesis: let's call it the *null hypothesis*. 
# I believe that women are equally likely to be elected to Congress as men.
# Sorry, I Joe don't believe that. But I the unreliable narrator believe that
# This is the Null Hypothesis. 

# If I believe the Null Hypothesis (H0), then what's the chance that I 
# would observe the result that I did?

# create America - which is 300 million people, about half men, half women
america <- tibble(male = sample(c(0,1), size = 3e8, replace = TRUE))


sample_congress <- function(){
  
  congress <- america |> 
    slice_sample(n = 535)
  
  return(mean(congress$male))
  
}

# create 10,000 randomly selected congresses
sampling_distribution <- replicate(100000, sample_congress())

# what's the share of women look like in those hypothetical congresses?
ggplot(mapping = aes(x=sampling_distribution)) +
  geom_histogram(color = 'black') +
  labs(x = 'Percent Men in Sample Congress')


# what's the probability we end up with more than 55% men?
sum(sampling_distribution > 0.55)
88 / 10000

# what's the probability of getting a congress with less than 45% men?
sum(sampling_distribution < 0.45) / length(sampling_distribution)

# what's the probability of getting a Congress with more than 76% men?
sum(sampling_distribution > 0.76)

# the *p-value* associated with the actual number of men in Congress = 0

# p-value is the probability of observing the statistic you did, if the
# null hypothesis is true.

# the probability that your result was due to sampling error alone.


## ALL Classical Hypothesis Tests follow these three steps:

# 1. Compute a test statistic (76% of Congress is men)

# 2. Generate a sampling distribution under the Null Hypothesis

# 3. Compute the probability of your test statistic, conditional on the 
#    null hypothesis (p-value = 0)








