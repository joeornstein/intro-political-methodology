## Regression Discontinuity Designs
## Author: Joe Ornstein (jornstein@uga.edu)
## Date: November 16, 2020
## Version: 1.0

library(readstata13)
library(tidyverse)
set.seed(42)

# Load Hall & Thompson data 
ht <- read.dta13('data/rd_analysis_hs.dta')


# Visualize the relationship
# The running variable is rv
# the outcome variable is turnout_party_share

library(rdrobust)

ggplot(data = ht) +
  geom_point(aes(x=rv,y=turnout_party_share))

rdplot(y=ht$turnout_party_share, x=ht$rv)

rd1 <- rdrobust(y=ht$turnout_party_share, x=ht$rv)
summary(rd1)



# Load Klasjna-Titiunik
kt <- read.dta13('data/KlasnjaTitiunik-LAcountries-data.dta')

kt %>% 
  filter(country == 'Brazil') %>% 
  ggplot() +
  geom_point(aes(x=mv_incumbent, y = post_winning_incumbent_unc)) +
  geom_smooth(aes(x=mv_incumbent, y = post_winning_incumbent_unc))

rdplot(y = kt %>% filter(country == 'Brazil') %>% pull(post_winning_incumbent_unc),
       x = kt %>% filter(country == 'Brazil') %>% pull(mv_incumbent))

# data: https://github.com/jrnold/masteringmetrics/tree/master/masteringmetrics/data

load('data/mlda.rda')

mlda %>% 
  ggplot(aes(x = agecell, y = mva)) + 
  geom_point() +
  #geom_vline(xintercept = 21, linetype = 'dashed') + 
  labs(y = "Deaths in Moving Vehicle Accidents", x = "Age")

# placebo test
mlda %>% 
  ggplot(aes(x = agecell, y = drugs)) + 
  geom_point() +
  geom_vline(xintercept = 21, linetype = 'dashed') + 
  labs(y = "Drug-Related Deaths", x = "Age")

rdplot(y=mlda$mva,x=mlda$agecell, c=21)
rdrobust(y=mlda$mva,x=mlda$agecell, c=21) %>% summary


kt %>% 
  filter(country == 'Brazil') %>% 
  mutate(mv_bin = cut_number(mv_incumbent, 100)) %>% 
  group_by(mv_bin) %>% 
  summarize(pct_incumbent_win = mean(post_winning_incumbent_unc))

# ---------------- Part X: An Empirical Example ------------------------------

# Eggers & Spirling (2017) estimate incumbency effects in the UK with an RD design
# Compare districts where Conservatives barely won election to Parliament with those
# where they barely lost, and observe how Conservatives perform in the following election

## Load and clean up the Eggers & Spirling (2017) dataset
load('data/combined_data_to_2010_all_20150128.RData')
# Keep only the Conservative-Liberal contests from 1950-2010 (Figure 4b)
data <- x %>%
  filter(X.e.year. >= 1950,
         X.con.rv_counterparty_was_lib. == T)
rm(x)

ggplot(data) +
  geom_point(aes(x=X.con.rv.,y=X.con.vote_share.),
             alpha = 0.2) + 
  geom_smooth(data = data %>% filter(X.con.rv. < 0),
              aes(x=X.con.rv., y=X.con.vote_share.)) +
  geom_smooth(data = data %>% filter(X.con.rv. > 0),
              aes(x=X.con.rv., y=X.con.vote_share.)) +
  
rdplot(y=data$X.con.vote_share.,x=data$X.con.rv.)
rdrobust(y=data$X.con.vote_share.,x=data$X.con.rv.) %>% summary

ggplot()
