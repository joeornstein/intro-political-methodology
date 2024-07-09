

library(tidyverse)
library(readxl)
library(janitor)


wh <- read_xlsx('data/midterm/wh2020_public_release_crosstabs.xlsx',
                skip = 1) %>% 
  clean_names()


tidied_wh <- wh %>% 
  select(group, pres_2020:pres_2012)


data_to_plot <- tidied_wh %>% 
  filter(group %in% c('White Non-College', 'White College')) %>% 
  pivot_longer(cols = pres_2020:pres_2012,
               names_to = 'year',
               values_to = 'democratic_vote_share') %>% 
  # turn year into a number
  mutate(year = as.numeric(str_replace_all(year, 'pres_', '')))


ggplot(data = data_to_plot,
       mapping = aes(x=year, y=democratic_vote_share,
                     color = group, group = group)) +
  geom_line()
