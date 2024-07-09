### Analyze Wallet Experiment

library(tidyverse)

wallets <- read_csv('data/cohn-2019/behavioral data (csv file).csv')

# keep only the conditions 0 and 1 (no money and money)
wallets <- filter(wallets, cond %in% c(0,1))

# what's the average difference in response rates between
# the wallets with money and those without money?

# one approach: find the difference in means
mean0 <- mean(wallets$response[wallets$cond == 0])
mean1 <- mean(wallets$response[wallets$cond == 1])

mean1 - mean0

# approach two: tidyverse style
mean0 <- wallets %>% 
  filter(cond == 0) %>% 
  pull(response) %>% 
  mean

mean1 <- wallets %>% 
  filter(cond == 1) %>% 
  pull(response) %>% 
  mean

mean1 - mean0

# easiest way: 
lm(response ~ cond, data = wallets)


wallets %>% 
  group_by(cond) %>% 
  summarise(mean_response_rate = mean(response))

## do we need to condition on anything else?

# (in principle, no, because the randomization closes off any back door paths)

# We can verify, in fact, that conditioning on other variables does not affect our estimated treatment effect

lm(response ~ cond, data = wallets)
lm(response ~ cond + male, data = wallets)

lm(response ~ cond + male + security_cam + coworkers, data = wallets)

# balance test (if randomization worked, then the money wallets shouldn't be more likely to end up in places with security cameras)
lm(security_cam ~ cond, data = wallets)

# could (and should) do this for everything you think might be a confounder
lm(no_english ~ cond, data = wallets)

## heterogeneous treatment effects?

# is the treatment effect of money higher in places with languages that drop pronouns?
lm(response ~ cond, data = filter(wallets, c_TAB_pronoun_drop == 1))
lm(response ~ cond, data = filter(wallets, c_TAB_pronoun_drop == 0))

# what about the average income of a place?
lm(response ~ cond, data = filter(wallets, c_log_gdp > 10))
lm(response ~ cond, data = filter(wallets, c_log_gdp < 9))
