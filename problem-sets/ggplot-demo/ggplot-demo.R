# This script visualizes ANES data
# Author: Joe Ornstein
# Version: 1.0
# Date: September 2, 2020

library(tidyverse)

# Load Data
load('data/anes_pilot_2019.RData')


## What's Up With the Feeling Thermometers?? ------------

mean(data$ftbiden)
mean(data$ftharris)
mean(data$ftbuttigieg) # Pete is literally off the charts!

# Create a ggplot() object called fig1, add a histogram layer with
# the Pete Buttigieg feeling thermometer 
fig1 <- ggplot(data = data) + geom_histogram(mapping = aes(x = ftbuttigieg))

fig1

# Filter out the invalid ftbuttigieg values
fig1_data <- filter(data, ftbuttigieg >= 0 & ftbuttigieg <= 100)

# Recreate Figure 1
fig1 <- ggplot(data = fig1_data) + geom_histogram(mapping = aes(x = ftbuttigieg))

fig1

# In the filtered data, the mean is more sensible
mean(fig1_data$ftbuttigieg)

# Now repeat the process for Kamala Harris
fig2_data <- filter(data, ftharris >= 0 & ftharris <= 100)
fig2 <- ggplot(data = fig2_data) + geom_histogram(mapping = aes(x = ftharris))
fig2

# uncomment line 41 to install the cowplot package
# install.packages('cowplot')
cowplot::plot_grid(fig1, fig2) # plot a grid of multiple plots
# (Note: use the double colon after a package name to use a function from a package without loading it)

## How do *Democrats* feel about Pete Buttigieg? -----------

# vote20dem is a categorical variable denoting partisanship
table(data$vote20dem)

# Facet Figure 1 by partisanship to create Figure 3, a small multiples plot
fig3 <- fig1 + 
  facet_wrap(~vote20dem)

fig3

# Recode vote20dem to make it easier to understand (1=Democrat, 2=Republian, 3=Neither)
fig1_data$vote20dem[fig1_data$vote20dem == 1] <- "Democrat"
fig1_data$vote20dem[fig1_data$vote20dem == 2] <- "Republican"
fig1_data$vote20dem[fig1_data$vote20dem == 3] <- "Neither"
fig1_data$vote20dem[fig1_data$vote20dem == -7] <- NA

# Filter out the missing values (NA)
fig1_data <- filter(fig1_data, !is.na(vote20dem))

# Now redraw Figure 3, with new labels on the x and y axis, and a fancy theme
fig3 <- ggplot(data = fig1_data) +
  geom_histogram(mapping = aes(x = ftbuttigieg)) + 
  facet_wrap(~vote20dem) +
  xlab('Feeling Thermometer (Pete Buttigieg)') +
  ylab('Count') +
  theme_classic()

fig3


## Scatter Plots ------------------------

# Filter out the invalid ftbiden values 
# (Note: we already filtered out the invalid ftbuttigieg values in the fig1_data dataframe)
fig4_data <- filter(fig1_data, ftbiden >= 0 & ftbiden <= 100)

# Use geom_point() to create a scatter plot of ftbiden versus ftbuttigieg
# Use geom_smooth() to fit a trend through the data (technically a LOESS curve)
# Use facet_wrap() to create three small multiples by partisanship
fig4 <- ggplot(data = fig4_data) +
  geom_point(mapping = aes(x = ftbiden, y = ftbuttigieg)) +
  geom_smooth(mapping = aes(x = ftbiden, y = ftbuttigieg), se = FALSE) +
  facet_wrap(~vote20dem) +
  xlab('Feeling Thermometer (Joe Biden)') +
  ylab('Feeling Thermometer (Pete Buttigieg)') +
  theme_dark()

fig4

## Boxplot ---------------

# Use geom_boxplot() to create a boxplot
# Boxplots show the median, 25th and 75th percentiles, 
# and the minimum/maximum values of a distribution
boxfig <- ggplot(data = fig4_data) +
  geom_boxplot(mapping = aes(x = ftbiden, y = vote20dem)) +
  xlab('Feeling Thermometer (Joe Biden)') +
  ylab('Party')

# NOTE: In class I used facet_wrap(~vote20dem) to make several box plots, but
# using vote20dem as the y-axis variable is much prettier

boxfig

## Violin Plot ------------------------

# A violin plot is a newfangled boxplot; another way to visualize a distribution
violin_fig <- ggplot(data = fig4_data) +
  geom_violin(mapping = aes(x = ftbiden, y = vote20dem)) +
  xlab('Feeling Thermometer (Joe Biden)') +
  ylab('Party') +
  theme_minimal()

violin_fig

## Bar Plots --------------------------

table(data$liveurban)

# Recode liveurban (where do you live now?)
data$liveurban[data$liveurban == 1] <- 'Rural'
data$liveurban[data$liveurban == 2] <- 'Small Town'
data$liveurban[data$liveurban == 3] <- 'Suburb'
data$liveurban[data$liveurban == 4] <- 'City'

# Recode youthurban (where did you live as a child?)
data$youthurban[data$youthurban == 1] <- 'Rural Youth'
data$youthurban[data$youthurban == 2] <- 'Small Town Youth'
data$youthurban[data$youthurban == 3] <- 'Suburban Youth'
data$youthurban[data$youthurban == 4] <- 'City Youth'

# Recode vote20dem (we never recoded it in the original dataframe!)
data$vote20dem[data$vote20dem == 1] <- "Democrat"
data$vote20dem[data$vote20dem == 2] <- "Republican"
data$vote20dem[data$vote20dem == 3] <- "Neither"
data$vote20dem[data$vote20dem == -7] <- NA

# Filter out the missing values (NA) for vote20dem
data <- filter(data, !is.na(vote20dem))


bar_fig <- ggplot(data = data) +
  geom_bar(mapping = aes(x = liveurban)) +
  facet_wrap(~youthurban) + 
  xlab('Where Do You Live?') +
  ylab('Count') +
  theme_bw()

bar_fig



## Save Plots Using the ggsave() function --------------------

# The 'scale' argument

# Save Figures 1-4
ggsave(filename = 'Figure1.png', plot = fig1, 
       height = 5, width = 8)
ggsave(filename = 'Figure2.png', plot = fig2, 
       height = 5, width = 8)
ggsave(filename = 'Figure3.png', plot = fig3, 
       height = 5, width = 8)
ggsave(filename = 'Figure4.png', plot = fig4, 
       height = 5, width = 8)

# Save the boxplot, violin plot, and barplot
ggsave(filename = 'Figure5.png', plot = boxfig, 
       height = 5, width = 8)
ggsave(filename = 'Figure6.png', plot = violin_fig, 
       height = 5, width = 8)
ggsave(filename = 'Figure7.png', plot = bar_fig, 
       height = 5, width = 8)