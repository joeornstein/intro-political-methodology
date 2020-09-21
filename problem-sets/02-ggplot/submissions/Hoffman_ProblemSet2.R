# Problem Set 2
# Mallory Hoffman
# 09.03.2020

#Data is already uploaded because I opened  
# another file within the same project

library(tidyverse)

## How do people feel about Donald Trump, and where do they live?--------

# What is the average rating?
mean(data$fttrump)
# Pretty neutral results...interesting.

# What is the distribution of his ratings?
fig1 <- ggplot(data = data) + 
  geom_histogram(mapping = aes(x = fttrump))

fig1

# Getting rid of the invalid responses:

fig1_data <- filter(data, fttrump >= 0 & fttrump <= 100))

# Recreating histogram with filtered results

fig1 <- ggplot(data = fig1_data) + 
  geom_histogram(mapping = aes(x = fttrump))

fig1

# Putting these ratings with the categorization of where they live
# Adding the second variable
fig3 <- fig1 + 
  facet_wrap(~liveurban)

fig3

#Changing the values 
fig1_data$liveurban[fig1_data$liveurban == 1] <- "Rural"
fig1_data$liveurban[fig1_data$liveurban == 2] <- "Small Town"
fig1_data$liveurban[fig1_data$liveurban == 3] <- "Suburb"
fig1_data$liveurban[fig1_data$liveurban == 4] <- "City"

#Making it pretty (i.e. adding x and y values and a theme)
fig3 <- ggplot(data = fig1_data) +
  geom_histogram(mapping = aes(x = )) + 
  facet_wrap(~liveurban) +
  xlab('Feeling Thermometer for Trump') +
  ylab('Count') +
  theme_light()

# Final Result:
fig3 



## What is the relationship between ratings of Palestine 
# and the ratings of Israel?-------------------------------------------------

# Initial boxplot of ratings of Palestine
bg_pales <- ggplot(data = data) + 
  geom_histogram(mapping = aes(x = ftpales)) 
bg_pales


# Average rating
mean(data$ftpales)

#Filter out the invalid data
figf_pales <- filter(data, ftpales >= 0 & ftpales <= 100)

#Recreating the boxplot of Pales. ratings
bp_pales <- ggplot(data = figf_pales) + 
  geom_boxplot(mapping = aes(x = ftpales)) +
  xlab('Feeling Termometer of Palestine')
bp_pales

#Initial boxplot of ratings of Israel
bp_israel <- ggplot(data = data) + 
  geom_boxplot(mapping = aes(x = ftisrael))
bp_israel

#Filter out the invalid data
figf_israel <- filter(data, ftisrael >= 0 & ftisrael <= 100)

#Recreating the bloxplot of Israel ratings
bp_israel <- ggplot(data = figf_israel) + 
  geom_boxplot(mapping = aes(x = ftisrael)) + 
  xlab('Feeling Thermometer of Palestine')
bp_israel

#Putting the two boxplots together for easier visualization, although I'll 
# try next time to put them on top of eachother. It took me hours and I couldn't 
# figure it out.
cowplot::plot_grid(bp_pales, bp_israel)




## What is the relationship between the ratings of Trump and the ability 
##  for the government to keep secrets?------------------------------------------------------
#My thinking for this one comes from his impeachment trial

# Initial boxplot of ratings of Palestine
trumpdata <- ggplot(data = data) + 
  geom_histogram(mapping = aes(x = fttrump)) 
trumpdata

# FIltering invalid entries
fig6_data <- filter(data, fttrump >= 0 & fttrump <= 100)

#Changing Labels
fig6_data$conspire2[fig1_data$conspire2 == 1] <- "Not at All"
fig6_data$conspire2[fig1_data$conspire2 == 2] <- "Not Very Well"
fig6_data$conspire2[fig1_data$conspire2 == 3] <- "Somewhat Well"
fig6_data$conspire2[fig1_data$conspire2 == 4] <- "Very Well"
fig6_data$conspire2[fig1_data$conspire2 == 5] <- "Extremely Well"

#Recreating the histogram of Trump ratings
trumpdata <- ggplot(data = fig6_data) + 
  geom_count(mapping = aes(x = fttrump, y = conspire2)) +
  xlab('Feeling Termometer of Trump') +
  ylab('Government Ability to Keep Secrets')
trumpdata



