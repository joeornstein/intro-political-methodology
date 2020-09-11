# Create a bar plot of political participation across each of eight categories
# Author: Joe Ornstein
# Version: 1.0
# Date: September 9, 2020

library(tidyverse)

# Load Data
load('data/anes_pilot_2019.RData')


# Create a function to count the number of 1's in a vector
count_ones <- function(x){
  sum(as.numeric(x == 1))
}

# there should be 377 ones in particip_1
count_ones(data$particip_1)

# now create a vector with the yes counts for each type of participation
yes_counts <- data %>% 
  select(particip_1,
         particip_2,
         particip_3,
         particip_4,
         particip_5,
         particip_6,
         particip_7,
         particip_8) %>% 
  apply(2, count_ones)

# Create a dataframe for the ggplot
fig1_data <- data.frame(
  participation_type = c('Meeting', 'Money', '3', '4', '5', '6', '7', '8'),
  yes_counts = yes_counts
)

# TODO: Fill out 'participation_type' with the correct labels.

# Create the plot (stat = 'identity' tells ggplot not to further summarize the data for the bar plot)
# https://stackoverflow.com/questions/10820728/producing-bar-charts-on-ggplot2-using-already-summarized-data
fig1 <- ggplot(data = fig1_data) +
  geom_bar(aes(x = participation_type, y = yes_counts), stat = 'identity')

fig1
