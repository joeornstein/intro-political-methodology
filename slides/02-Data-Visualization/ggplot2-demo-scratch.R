# Clean and visualize ANES pilot data
# Author: Joe Ornstein
# Date: August 28, 2020

library(tidyverse)

# Load Data
load('data/anes_pilot_2019.RData')


# Feeling Thermometers -------------------------

# Something weird is going on with the feeling thermometers
mean(data$ftharris)
mean(data$ftbiden)
mean(data$ftbuttigieg)

ggplot(data = data) +
  geom_histogram(mapping = aes(x = ftharris))

fig1_data <- filter(data, ftharris >= 0 & ftharris <=100)

ggplot(data = fig1_data) +
  geom_histogram(mapping = aes(x = ftharris))

mean(fig1_data$ftharris)


# How do DEMORATS feel about Harris?

fig2_data <- filter(fig1_data, vote20dem %in% c(1,2,3))

ggplot(data = fig2_data) +
  geom_histogram(mapping = aes(x = ftharris)) +
  facet_wrap(facets = ~ vote20dem)

# Clean up the vote20dem variable
fig2_data$vote20dem[fig2_data$vote20dem == 1] <- 'Democrat'
fig2_data$vote20dem[fig2_data$vote20dem == 2] <- 'Republican'
fig2_data$vote20dem[fig2_data$vote20dem == 3] <- 'Neither'

# Plot the figure again
fig2 <- ggplot(data = fig2_data) +
  geom_histogram(mapping = aes(x = ftharris)) +
  facet_wrap(facets = ~ vote20dem)

fig2

# Clean it up
fig2 <- fig2 + 
  xlab('Feeling Thermometer (Kamala Harris)') +
  ylab('Count')

fig2 +
  theme_classic()

# Note: This only recodes it in the fig2_data dataframe. If you go back to `data` you won't see the change
table(data$vote20dem)


# Figure 3: Biden (Do it yourself!)

# Other Options For Plotting Distributions ---------------------

# Boxplots

fig4 <- ggplot(data = fig2_data) +
  geom_boxplot(mapping = aes(x = ftharris, y = vote20dem)) +
  xlab('Feeling Thermometer (Kamala Harris)') +
  ylab('Party') + 
  theme_bw()

fig4

# Jitter Plots
jitter_fig <- ggplot(data = fig2_data) +
  geom_jitter(mapping = aes(x = ftharris, y = vote20dem, color = vote20dem),
              size = 0.1) +
  xlab('Feeling Thermometer (Kamala Harris)') +
  ylab('Party') + 
  theme_bw()

jitter_fig

# Talk here about color / alpha / shape

# Violin plots
violin_fig <- ggplot(data = fig2_data) +
  geom_violin(mapping = aes(x = ftharris, y = vote20dem, color = vote20dem)) +
  xlab('Feeling Thermometer (Kamala Harris)') +
  ylab('Party') + 
  theme_bw()

violin_fig

# Plotting Relationships: Scatter Plots ---------------------

fig5_data <- filter(fig2_data,
                    ftharris >= 0,
                    ftharris <= 100,
                    ftbiden >= 0,
                    ftbiden <= 100)

scatter_plot <- ggplot(data = fig5_data) +
  geom_jitter(mapping = aes(x = ftbiden, y = ftharris)) + 
  geom_smooth(mapping = aes(x = ftbiden, y = ftharris)) +
  xlab('Feeling Thermometer (Kamala Harris)') +
  ylab('Feeling Thermometer (Joe Bien)') +
  theme_classic()
  
scatter_plot

scatter_plot +
  facet_wrap(~ vote20dem)

# Categorical Data: Where Do You Live? -----------------------------

# Clean Up Some Categorical Data

# Where did you live in your youth?
data$youthurban[data$youthurban == 1] <- 'Rural'
data$youthurban[data$youthurban == 2] <- 'Small Town'
data$youthurban[data$youthurban == 3] <- 'Suburb'
data$youthurban[data$youthurban == 4] <- 'City'

# Where do you live now?
data$liveurban[data$liveurban == 1] <- 'Rural'
data$liveurban[data$liveurban == 2] <- 'Small Town'
data$liveurban[data$liveurban == 3] <- 'Suburb'
data$liveurban[data$liveurban == 4] <- 'City'

## Plot youthurban vs. liveurban -----------------------

# Option 1
ggplot(data = data) + 
  geom_jitter(mapping = aes(x = youthurban, y = liveurban), size = 0.5)

# Option 2
ggplot(data = data) +
  geom_bar(mapping = aes(x=liveurban)) +
  facet_wrap(~ youthurban)

## Maps --------

# install.packages('maps')
library(maps)

us_states <- map_data("state")

# I promise we'll learn how to do this later!
map_data <- fig2_data %>% 
  group_by(inputstate) %>% 
  summarise(mean_ft_harris = mean(ftharris))
