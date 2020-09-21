# POLS 7012 - Problem Set 2
# Author: Molly Ahearne
# Due Date: September 9, 2020

library(tidyverse)

load('data/anes_pilot_2019.RData')

## How do people rate Canada? ----------

# Create a ggplot() called figCanada
# Use geom_histogram() to create a histogram of ftcanada
figCanada <- ggplot(data = data) + 
  geom_histogram(mapping = aes(x = ftcanada), color = "dark blue") +
  labs( x = "Feeling Thermometer (Canada)", y = "Count", title = "How Would You Rate Canada?", subtitle = "People's Opinions by Percentage") +
  theme(title=element_text(family="serif", color="dark blue"))

figCanada

## Overall, how worried are you about the national economy? -------

#Recode confecon
data$confecon[data$confecon == 1] <- 'Not at all worried'
data$confecon[data$confecon == 2] <- 'A little worried'
data$confecon[data$confecon == 3] <- 'Moderately worried'
data$confecon[data$confecon == 4] <- 'Very worried'
data$confecon[data$confecon == 5] <- 'Extremely worried'

#Create a ggplot() called figConfecon
# Use geom_bar() to create a bar chart of confecon
figConfecon <- ggplot(data = data) +
  geom_bar(mapping = aes(x = confecon), col = "light blue") +
  coord_cartesian(ylim=c(0, 1000)) +
  labs( x = "Opinions", y = "Count", title = "Overall, how worried are you about the national economy?") +
  theme(axis.line=element_line(color="light blue", size=2),
              panel.background=element_rect(fill="white", color="light blue"),
              title=element_text(family="serif", face="bold")) 

  
figConfecon


## What should happen to immigrants who were brought to the U.S. illegally as child? ------
# (See how responses differ by where people currently live)

#Recode dreamer
data$dreamer[data$dreamer == 1] <- "Stay"
data$dreamer[data$dreamer == 2] <- "Leave"
data$dreamer[data$dreamer == -7] <- NA

# Filter out the missing values (NA) for dreamer
data <- filter(data, !is.na(dreamer))

#Recode liveurban
data$liveurban[data$liveurban == 1] <- "Rural Area"
data$liveurban[data$liveurban == 2] <- "Small Town"
data$liveurban[data$liveurban == 3] <- "Suburb"
data$liveurban[data$liveurban == 4] <- "City"

#Create a ggplot() called figDreamer
# Use geom_bar() to create a bar chart of dreamer
# Use facet_wrap() to create four graphs showing how responses differ by where people currently live
figDreamer <- ggplot(data = data) +
  geom_bar(mapping = aes(x = dreamer)) +
  facet_wrap(~liveurban) + 
  coord_cartesian(ylim=c(0, 850)) +
  labs( x = "Opinions Based on Where People Live", y = "Count", title = "What should happen to immigrants who were brought to the U.S. illegally as child?", subtitle = "Based on where people currently live") +
  theme(panel.background = element_rect(fill="light pink"),
        panel.grid=element_line(color="light gray"),
        title=element_text(face="bold"),
        strip.text=element_text(face="bold"))

figDreamer




