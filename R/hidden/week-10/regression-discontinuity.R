
# replicate Figure 1 of "The Incumbency Curse"

library(tidyverse)

d <- read_csv('data/klasnja-titiunik-2017/KlasnjaTitiunik-LAcountries-data.csv')

ggplot(data = d, mapping = aes(x=mv_incumbent)) + geom_histogram()

d <- d |> 
  mutate(bin = cut(mv_incumbent, breaks = seq(-50, 50, by = 1)))


# attempt 1: looks...fine
d |> 
  group_by(bin) |> 
  summarize(pct_reelected = mean(post_winning_incumbent_unc, na.rm = TRUE)) |>
  mutate(bin = )
  ggplot(mapping = aes(x = bin, y = pct_reelected)) +
  geom_point()


p <- ggplot(data = d |> filter(country == 'Brazil'), 
              mapping = aes(x = mv_incumbent,
                            y = post_winning_incumbent_unc)) +
    stat_summary_bin(fun = 'mean', breaks = -100:100,
                     geom = 'point', shape = 'square') +
    geom_vline(xintercept = 0, color = 'red') +
    theme_classic() +
    labs(x = 'Incumbent Party Vote Margin at t',
         y = 'Probability of Unconditional Victory t+1')
  
p


# what about just the years 2004 and 2008?
p <- ggplot(data = d |> filter(country == 'Brazil',
                               year %in% c(2004, 2008)), 
            mapping = aes(x = mv_incumbent,
                          y = post_winning_incumbent_unc)) +
  stat_summary_bin(fun = 'mean', breaks = -100:100,
                   geom = 'point', shape = 'square') +
  geom_vline(xintercept = 0, color = 'red') +
  theme_classic() +
  labs(x = 'Incumbent Party Vote Margin at t',
       y = 'Probability of Unconditional Victory t+1')

p

### How do we estimate? Fit two linear models, one on the left and one on the right.
### Subtract the two intercepts.

brazil_data <- d |> 
  filter(country == 'Brazil')

# linear model where the incumbent barely lost
lm_left <- lm(post_winning_incumbent_unc ~ mv_incumbent,
              data = brazil_data |> filter(mv_incumbent > -3,
                                           mv_incumbent < 0))

# linear model where the incumbent barely won
lm_right <- lm(post_winning_incumbent_unc ~ mv_incumbent,
              data = brazil_data |> filter(mv_incumbent > 0,
                                           mv_incumbent < 3))

# the intercept terms tell us the predicted percent of incumbents who won 
# when vote share in the previous election was at the cutoff
lm_left
lm_right

# incumbency disadvatage is:
lm_right$coefficients['(Intercept)'] - lm_left$coefficients['(Intercept)']


library(rdrobust)

rd <- rdrobust(y = brazil_data$post_winning_incumbent_unc,
               x = brazil_data$mv_incumbent,
               c = 0)

summary(rd)
