load("data/anes_pilot_2019.RData")
library(tidyverse)
libs <- c("foreign", "dplyr", "ggplot2")
sapply(libs, require, character.only=TRUE)

### Variables of interest
#ftjournal - feeling thermometer of journalists
#ftrussia - feeling thermometer of  Russia
#fttrump - feeling thermometer of Trump
#voted20dem - Whether a citizen votes in GOP or Dem caucus


#Recoding / Tidying Data
summary(data$ftjournal)
summary(data$ftrussia)
summary(data$fttrump)
table(data$trussia)
table(data$pid1d)
table(data$interfere)

# figure 1 FT Russia
#  I want to examine people's attitudes toward Russia through a partisan lenses. I have an inclination that Donald Trump has affected attitudes toward Russia
fig1 <- ggplot(data = data) + geom_histogram(mapping = aes(x = ftrussia))
fig1
fig1_data <-filter(data,ftrussia >=0 & ftrussia <=100)
fig1 <- ggplot(data = fig1_data) + geom_histogram(mapping = aes(x = ftrussia))
fig1
mean(fig1_data$ftrussia)
# How Party ID affects attitudes toward Russia
# Recode vote20dem categorical variable
fig1_data$vote20dem[fig1_data$vote20dem == 1] <-"Democrat"
fig1_data$vote20dem[fig1_data$vote20dem == 2] <-"Republican"
fig1_data$vote20dem[fig1_data$vote20dem == 3] <-"Neither"
fig1_data$vote20dem[fig1_data$vote20dem == -7] <-NA

fig1_data <- filter(fig1_data, !is.na(vote20dem))

# Figure 2, with new labels on the x and y axis.See whether Party ID affects the view of Russia
fig2 <- ggplot(data = fig1_data) +
  geom_histogram(mapping = aes(x = ftrussia)) + 
  facet_wrap(~vote20dem) +
  xlab('Feeling Thermometer (Russia)') +
  ylab('Count') +
  theme_classic()

fig2 

# figure 2 FT Journal
#  I want to examine people's attitudes toward journalists through a partisan lenses. I have an inclination that Party ID affects views of the press.
fig3 <- ggplot(data = data) + geom_histogram(mapping = aes(x = ftjournal))
fig3
fig3_data <-filter(data,ftjournal >=0 & ftjournal <=100)
fig3 <- ggplot(data = fig3_data) + geom_histogram(mapping = aes(x = ftjournal))
fig3
mean(fig3_data$ftrussia)

# Recode vote20dem categorical variable
fig3_data$vote20dem[fig3_data$vote20dem == 1] <-"Democrat"
fig3_data$vote20dem[fig3_data$vote20dem == 2] <-"Republican"
fig3_data$vote20dem[fig3_data$vote20dem == 3] <-"Neither"
fig3_data$vote20dem[fig3_data$vote20dem == -7] <-NA

fig3_data <- filter(fig3_data, !is.na(vote20dem))

fig4 <- ggplot(data = fig3_data) +
  geom_histogram(mapping = aes(x = ftjournal)) + 
  facet_wrap(~vote20dem) +
  xlab('Feeling Thermometer (Journalists)') +
  ylab('Count') +
  theme_classic()

fig4

# figure 3: Effect of Donald Trump on JournFT Russia
#  I want to examine how people's view of Donald Trump affect their view of journalists through a partisan lenses. 
fig5 <- ggplot(data = data) + geom_histogram(mapping = aes(x = fttrump))
fig5
fig5_data <-filter(data,fttrump >=0 & fttrump <=100)
fig5 <- ggplot(data = fig5_data) + geom_histogram(mapping = aes(x = fttrump))
fig5
mean(fig5_data$ftrussia)
fig5_data <- filter(fig5_data, fttrump >= 0 & fttrump <= 100)

# Recode vote20dem categorical variable
fig5_data$vote20dem[fig5_data$vote20dem == 1] <-"Democrat"
fig5_data$vote20dem[fig5_data$vote20dem == 2] <-"Republican"
fig5_data$vote20dem[fig5_data$vote20dem == 3] <-"Neither"
fig5_data$vote20dem[fig5_data$vote20dem == -7] <-NA

fig5_data <- filter(fig5_data, !is.na(vote20dem))

fig6 <- ggplot(data = fig5_data) +
  geom_point(mapping = aes(x = fttrump, y = ftjournal)) +
  geom_smooth(mapping = aes(x = fttrump, y = ftjournal), se = FALSE) +
  facet_wrap(~vote20dem) +
  xlab('Feeling Thermometer (Donald Trump)') +
  ylab('Feeling Thermometer (Journalists)') +
  theme_dark()

fig6

#########################################


