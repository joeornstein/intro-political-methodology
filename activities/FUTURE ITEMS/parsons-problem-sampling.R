jar <- tibble(party = sample(c('Red', 'Blue'), size = 10000,
                             replace = TRUE, prob = c(0.48, 0.52)))
# NOTE: Import that. It's a secret

N <- 100
my_sample <- jar %>% sample_n(N)

pct_blue <- my_sample %>% 
  filter(party == 'Blue') %>%
  nrow / 
  N * 100


# Now do that a bunch! 

# Helps to have a function.

get_pct_blue <- function(jar, N = 100){
  jar %>% 
    sample_n(N) %>% 
    filter(party == 'Blue') %>% 
    nrow /
    N
}

get_pct_blue(jar, N = 100)

sampling_distribution <- replicate(5000, get_pct_blue(jar, N = 100))

hist(sampling_distribution)

# unbiased, consistent
mean(sampling_distribution)

# we call this the standard error
sd(sampling_distribution)
