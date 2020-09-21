# Problem Set 2 (ANES data)
# Author: Bruno Ubiali
# Version: 1.0
# Date: September 9, 2020

library(tidyverse)

# Load Data
load('C:/Users/bgubi/Desktop/UGA/Courses/2020/2020_Fall/POLS_7012-Intro_Pol_Meth/Class2/.RData')

# Create a ggplot() object called fig1, add a histogram layer with
# the variable 'fttrump'
fig1 <- ggplot(data = data) + geom_histogram(mapping = aes(x = fttrump))

fig1


# Filter out the invalid fttrump values
fig1_data <- filter(data, fttrump >= 0 & fttrump <= 100)


# Recreate Figure 1
fig1 <- ggplot(data = fig1_data) + geom_histogram(mapping = aes(x = fttrump))

fig1


# In the filtered data, the mean is more sensible
mean(fig1_data$fttrump)


# Repeating process for Joe Biden
fig2 <- ggplot(data = data) + geom_histogram(mapping = aes(x = ftbiden))

fig2


# Filter out the invalid ftbiden values
fig2_data <- filter(data, ftbiden >= 0 & ftbiden <= 100)


# Recreate Figure 2
fig2 <- ggplot(data = fig2_data) + geom_histogram(mapping = aes(x = ftbiden))

fig2


# How do Democracts feel about Donald Trump? 
# vote20dem is a categorical variable denoting partisanship
table(data$vote20dem)


# Facet Figure 1 by partisanship to create Figure 3, a small multiples plot
fig2 <- fig1 + facet_wrap(~vote20dem)

fig2


# Recode vote20dem to make it easier to understand (1=Democrat, 2=Republian, 3=Neither)
fig1_data$vote20dem[fig1_data$vote20dem == 1] <- "Democrat"
fig1_data$vote20dem[fig1_data$vote20dem == 2] <- "Republican"
fig1_data$vote20dem[fig1_data$vote20dem == 3] <- "Neither"
fig1_data$vote20dem[fig1_data$vote20dem == -7] <- NA


# Redraw Figure 1, with new labels on the x and y axis, and a classic theme
fig3 <- ggplot(data = fig1_data) +
  geom_histogram(mapping = aes(x = fttrump)) +
  facet_wrap(~vote20dem) +
  xlab('Feeling thermometer (Donal Trump)') +
  ylab('Count') + 
  theme_classic()

fig3


# How do Democracts feel about Joe Biden? 
# vote20dem is a categorical variable denoting partisanship
table(data$vote20dem)


# Facet Figure 1 by partisanship to create Figure 3, a small multiples plot
fig4 <- fig2 + facet_wrap(~vote20dem)

fig4


# Recode vote20dem to make it easier to understand (1=Democrat, 2=Republian, 3=Neither)
fig2_data$vote20dem[fig2_data$vote20dem == 1] <- "Democrat"
fig2_data$vote20dem[fig2_data$vote20dem == 2] <- "Republican"
fig2_data$vote20dem[fig2_data$vote20dem == 3] <- "Neither"
fig2_data$vote20dem[fig2_data$vote20dem == -7] <- NA


# Redraw Figure 2, with new labels on the x and y axis, and a minimal theme
fig4 <- ggplot(data = fig2_data) +
  geom_histogram(mapping = aes(x = ftbiden)) +
  facet_wrap(~vote20dem) +
  xlab('Feeling thermometer (Joe Biden)') +
  ylab('Count') + 
  theme_minimal()

fig4


## Boxplot ---------------

# Use geom_boxplot() to create a boxplot
# Boxplots show the median, 25th and 75th percentiles, 
# and the minimum/maximum values of a distribution

boxfig <- ggplot(data = fig1_data) +
  geom_boxplot(mapping = aes(x=fttrump, y = vote20dem)) +
  xlab('Feeling thermoteter (Donald Trump)') +
  ylab('Party') +
  theme_gray()

boxfig



## Save Plots Using the ggsave() function --------------------

# Save Figures 1-4

ggsave(filename = 'Figure1.png', plot = fig3,
       height = 5, width = 8)
ggsave(filename = 'Figure2.png', plot = fig4,
       height = 5, width = 8)
ggsave(filename = 'Figure3.png', plot = boxfig,
       height = 5, width = 8)























