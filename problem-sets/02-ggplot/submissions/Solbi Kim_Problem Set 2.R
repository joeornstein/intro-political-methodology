#Propblem Set2: Visualization using ggplot2
#Author: Solbi Kim
#Using ANES Pilot dataset

library(tidyverse)

# Load Data

load('data/anes_pilot_2019.RData')

# Feeling Thermometers about China, North Korea, and Iran.
mean(data$ftchina) #37.93397
mean(data$ftnkorea) #20.75482
mean(data$ftiran) #26.51564

# Create a ggplot() object called fig1, add a histogram layer with
# the China feeling thermometer
fig1 <- ggplot(data = data) + geom_histogram(mapping = aes(x = ftchina))

fig1

# Create a ggplot() object called fig2, add a histogram layer with
# the North Korea feeling thermometer
fig2<- ggplot(data = data) + geom_histogram(mapping = aes(x = ftnkorea))

fig2

# Filter out the invalid ftnkorea values
fig2_data <- filter(data, ftnkorea >= 0 & ftnkorea <= 100)

# Recreate Figure 2
fig2 <- ggplot(data = fig2_data) + geom_histogram(mapping = aes(x = ftnkorea))

fig2

# In the filtered data, the mean is more sensible
mean(fig2_data$ftnkorea) #20.78115

# Create a ggplot() object called fig2, add a histogram layer with
# the Iran feeling thermometer
fig3 <- ggplot(data = data) + geom_histogram(mapping = aes(x = ftiran))

fig3

# Filter out the invalid ftiran values
fig3_data <- filter(data, ftiran >= 0 & ftiran <= 100)

# Recreate Figure 3
fig3 <- ggplot(data = fig3_data) + geom_histogram(mapping = aes(x = ftiran))

fig3

# In the filtered data, the mean is more sensible
mean(fig3_data$ftiran) #26.55805


#How do people who likely to vote for "Democrat" in the election for the U.S. House of Representatives feel about China?---
 
  #load cvote2020 (voting preference in the election for the U.S. House of Representatives were being held today)

  table(data$cvote2020)
 
  
  # Facet Figure 1 by preference of voting to create Figure 4, a small multiples plot
  fig4 <- fig1 + 
    facet_wrap(~cvote2020)
  
  fig4
  
  # Recode cvote2020 to make it easier to understand (1=Democrat, 2=Republican, 3=Neither)
  fig1_data$cvote2020[fig1_data$cvote2020 == 1] <- "Democrat"
  fig1_data$cvote2020[fig1_data$cvote2020 == 2] <- "Republican"
  fig1_data$cvote2020[fig1_data$cvote2020 == 3] <- "Neither"
  fig1_data$cvote2020[fig1_data$cvote2020 == 4] <- NA
  fig1_data$cvote2020[fig1_data$cvote2020 == 5] <- NA
  
  # Filter out the missing values (NA)
  fig1_data<-filter(fig1_data, !is.na(cvote2020))
  
  # Redraw Figure 4, with new labels on the x and y axis
  fig4 <- ggplot(data = fig1_data) +
    geom_histogram(mapping = aes(x = ftchina)) + 
    facet_wrap(~cvote2020) +
    xlab('Feeling Thermometer (China)') +
    ylab('Count') 
  
  fig4
  #People who likely to vote for Democrat in the election for the U.S. House of Representatives how more plausible feeling to China than preference on Republican. 
  
  #How do people who likely to vote for "Democrat" in the election for the U.S. House of Representatives feel about North Korea? ---
  #Using theme_minimal
  
  #Load data of cvote2020.
  table(data$cvote2020)
  
  # Facet Figure 2 by preference of voting to create Figure 5, a small multiples plot
  fig5 <- fig1 + 
    facet_wrap(~cvote2020)
  
  fig5
  
  # Recode cvote2020 to make it easier to understand (1=Democrat, 2=Republican, 3=Neither)
  fig2_data$cvote2020[fig2_data$cvote2020 == 1] <- "Democrat"
  fig2_data$cvote2020[fig2_data$cvote2020 == 2] <- "Republican"
  fig2_data$cvote2020[fig2_data$cvote2020 == 3] <- "Neither"
  fig2_data$cvote2020[fig2_data$cvote2020 == 4] <- NA
  fig2_data$cvote2020[fig2_data$cvote2020 == 5] <- NA
  
  # Filter out the missing values (NA)
  fig2_data<-filter(fig2_data, !is.na(cvote2020))
  
  # Redraw Figure 5, with new labels on the x and y axis, and a fancy theme
  fig2_data <- fig2_data %>% 
    mutate(cvote2020 = factor(cvote2020, 
                              levels = c('Democrat', 'Republican', 'Neither')))
  
  fig5 <- ggplot(data = fig2_data) +
    geom_histogram(mapping = aes(x = ftnkorea)) + 
    facet_wrap(~cvote2020) +
    xlab('Feeling Thermometer (North Korea)') +
    ylab('Count') +
    theme_minimal()
  
  fig5
  
  #How do people who likely to vote for "Democrat" in the election for the U.S. House of Representatives feel about China and Iran? ---
  #Using Scatter plot

  # Filter out the invalid ftiran values 
  
  fig6_data<-filter(fig1_data, ftiran >= 0 & ftiran <= 100)
  
# Use geom_point() to create a scatter plot of ftchina versus ftnkorea
  # Use geom_smooth() to fit a trend through the data (technically a LOESS curve)
  # Use facet_wrap() to create three small multiples by partisanship
  fig6 <- ggplot(data = fig6_data) +
    geom_point(mapping = aes(x = ftchina, y = ftiran)) +
    geom_smooth(mapping = aes(x = ftchina, y = ftiran), se = FALSE) +
    facet_wrap(~cvote2020) +
    xlab('Feeling Thermometer (China)') +
    ylab('Feeling Thermometer (Iran)')
 
  fig6
#People who have plausible feeling to China are also likely to have good feeling to Iran, regardless their party preferences. 
#However, people who prefer Democrat are more likely show directly proportion than who prefer Republican.

# Save Figures 4-6 ---
# Using the 'scale' argument

ggsave(filename = 'Figure4.png', plot = fig4, 
       height = 5, width = 8)
ggsave(filename = 'Figure5.png', plot = fig5, 
       height = 5, width = 8)
ggsave(filename = 'Figure6.png', plot = fig6, 
       height = 5, width = 8)
