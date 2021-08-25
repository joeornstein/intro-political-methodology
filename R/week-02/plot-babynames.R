

# load the libraries
library(babynames)
library(tidyverse)

# get a subset of the data
my_babynames <- filter(babynames,
                       name == 'Maude',
                       sex == 'F')

# create a plot of Joe popularity over time
p <- ggplot(data = my_babynames) +
  geom_point(mapping = aes(x=year, y=n)) +
  geom_line(mapping = aes(x=year, y=n)) +
  theme_minimal() +
  labs(x = 'Year', y = 'Number of Babies',
       title = 'Maudes over time',
       caption = 'Data source: US Social Security Administration')

p

# create a bar plot of most popular names in 2017
names_2017 <- filter(babynames,
                     year == 2017)

most_popular_2017 <- slice_max(names_2017, n, n = 20)

ggplot(data = most_popular_2017,
       mapping = aes(x = n, y = name)) +
  geom_bar(stat = 'identity') +
  theme_minimal() +
  labs(x = 'Number of Babies', y = 'Baby Name',
       title = 'Most popular baby names in 2017')
