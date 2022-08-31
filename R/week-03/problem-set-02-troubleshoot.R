# some problem set troubleshooting


library(tidyverse)
library(here)

# load the CES data (using the relative path)
load( here('data/ces-2020/cleaned-CES.RData') )


# alternatively (but badly) we can use the absolute file path
load('C:/Users/jo22058/Documents/intro-political-methodology/data/ces-2020/cleaned-CES.RData')


## average age by race
ces |> 
  group_by(race) |> 
  summarize(avg_age = mean(age))


# assault rifle ban by Trump approval
ces |> 
  filter(!is.na(assault_rifle_ban)) |> 
  filter(trump_approval == 'Strongly disapprove') |> 
  summarize(support_ban = sum(assault_rifle_ban == "Support"))
  


# what percent supported the assault rifle ban?

# one way to compute it: counting and dividing by n
ces |> 
  filter(!is.na(assault_rifle_ban)) |> 
  summarize(support_ban = sum(assault_rifle_ban == "Support"),
            pct_support_ban = support_ban / n() * 100)

# convert to 0-1 variable and take the mean
ces1 <- ces |> 
  filter(!is.na(assault_rifle_ban)) |> 
  mutate(supported_rifle_ban = if_else(assault_rifle_ban == 'Support', 1, 0))

ces1 |> 
  summarize(pct_support_ban = mean(supported_rifle_ban) * 100)

