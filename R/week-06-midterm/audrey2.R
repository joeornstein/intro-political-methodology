library(tidyverse)
library(ggplot2)
library(dplyr)
library(readr)
library(gganimate)

popsincepan <- read.csv('~/Documents/R/Week Three/popsincepan.csv')

sg <- ggplot(data = popsincepan) + 
  geom_line(mapping = aes(x=week.of, y=anxpop, group = 1, color='blue')) + 
  transition_reveal(week.of) +
  geom_line(mapping = aes(x=week.of, y=suipop, group = 1, color='red')) + 
  transition_reveal(week.of) +
  geom_vline(xintercept = 1, size = .5, linetype = 'dashed') +
  geom_vline(xintercept = 7, size = .5, linetype = 'dashed') + 
  geom_vline(xintercept = 17, size = .5, linetype = 'dashed') +
  geom_vline(xintercept = 37, size = .5, linetype = 'dashed') +
  geom_vline(xintercept = 40, size = .5, linetype = 'dashed') +
  geom_vline(xintercept = 45, size = .5, linetype = 'dashed') +
  geom_vline(xintercept = 47, size = .5, linetype = 'dashed') +
  geom_vline(xintercept = 54, size = .5, linetype = 'dashed') +
  geom_label(x=1, y=80, label = 'Quarantine 
  Announced', size = 3) +
  geom_label(x=6, y=76, label="All 50 states Under 
  Disaster Declaration 
  for the First Time 
  in History", size = 2.5) +
  geom_label(x=17, y=100, label="Protests of the Murder of
  George Floyd Reach Their Peak", size = 2.5) +
  geom_label(x=37, y=99.5, label="Biden 
  Elected", size = 2.5) +
  geom_label(x=40, y=64, label="Vaccine Testing 
  and Distribution 
  Plans Begin", size = 2.5) +
  geom_label(x=44.5, y=99, label="2021 
  Begins", size = 2.5) +
  geom_label(x=47, y=61, label="Biden Inaugurated", size = 2.5) +
  geom_label(x=54, y=100, label="One Year Since 
  Beginning of Quarantine", size = 2.5) +
  labs(title="Popularity of the Terms 'Suicidal' and 'Anxiety' from March 1st, 2020 to April 25, 2021", 
       subtitle = 
         'With Major Events Noted',
       x ="Weeks Since Quarantine Began", y = "Relative Popularity of Search Term", 
       anxpop = 'blue', suipop = 'red') +
      theme_linedraw() + 
  theme(legend.position = "bottom", element_line('Anxiety')) +
  scale_fill_discrete(name = "Key", labels = c("Suicidal", "Anxiety")) +
  scale_color_identity(name = "Key",
                       breaks = c("red", "blue"),
                       labels = c("Search Term - 'Suicidal'", "Search Term - 'Anxiety'"),
                       guide = "legend") 

sg