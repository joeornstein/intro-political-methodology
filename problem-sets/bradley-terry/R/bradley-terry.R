##############################################################################
# Algorithm to estimate the parameters of the Bradley-Terry model (1952)
# Author: Joe Ornstein
# Version: 1.0
# Date: June 1, 2020
##############################################################################

# This is great! Combines functions, log-likelihoods, matrices, loops. This would be a 
# good (but hard) culminating problem set / class activity

# Bradley-Terry model assumes that in a paired comparison between objects i and j, 
# the respondent will pick object i with probability pi_i / (pi_i + pi_j), where the 
# pi parameters are scores between 0 and 1 that sum to 1.

# See https://en.wikipedia.org/wiki/Bradley%E2%80%93Terry_model

library(tidyverse)

## Functions ----

# p is the vector of estimates
# W is a matrix where entry w_ij is the number of times i "beat" j

get_log_likelihood <- function(p, W){
  
  # Start at zero and add up
  ll <- 0
  
  # For 
  for(i in 1:length(p)){
    
    for(j in 1:length(p)){
      
      ll <- ll + W[i,j] * log(p[i]) - W[i,j] * log(p[i] + p[j])
      
    }
  }
  return(ll)
}

update_scores <- function(p, W){
  
  new_p <- p
  
  # For each i, update according to equation
  for(i in 1:length(p)){
    
    # Compute numerator
    numerator <- sum(W[i,])
    
    # Compute denominator
    denominator <- 0

    for(j in setdiff(1:length(p), i)){
      
      denominator <- denominator + 
        (W[i,j] + W[j,i]) / (p[i] + p[j])
      
    }
    
    new_p[i] <- numerator / denominator
    
  }
  
  # Renormalize
  new_p <- new_p / sum(new_p)
  
  return(new_p)
  
}


# Test with example p and w -----

n <- 10
p <- rep(1/n,n)
W <- matrix(data = round(runif(n*n, 0, 10)),
            nrow = n,
            ncol = n)
diag(W) <- 0

get_log_likelihood(p, W)
update_scores(p, W)

num_iterations <- 100
ll_sequence <- rep(0,num_iterations)

for(i in 1:num_iterations){
  
  p <- update_scores(p, W)
  ll_sequence[i] <- get_log_likelihood(p, W)
  
  
}

W
p
plot(ll_sequence, type = 'l')

## Make a function for that ----

bradley_terry <- function(W, num_iterations = 100){
  
  n <- nrow(W)
  
  # select a starting p
  p <- rep(1/n, n)
  
  ll_sequence <- rep(0,num_iterations)
  
  for(i in 1:num_iterations){
    
    p <- update_scores(p, W)
    ll_sequence[i] <- get_log_likelihood(p, W)
    
  }
  
  plot(ll_sequence, type = 'l', 
       xlab = 'Iteration', ylab = 'Log Likelihood')
  
  return(p)
}


## Try it out! ----
p <- bradley_terry(W)
p

n <- 3
W <- matrix(c(0,4,2,
              1,0,5,
              1,1,0),
            nrow = n,
            ncol = n)
W
p <- bradley_terry(W)
p

# Is this a good fit? Compare to log-likelihood of p'
p_prime <- p
p_prime[1] <- p_prime[1] + 0.00
p_prime[2] <- p_prime[2] - 0.001
p_prime[3] <- p_prime[3] + 0.001

sum(p_prime)

get_log_likelihood(p,W)
get_log_likelihood(p_prime, W)
