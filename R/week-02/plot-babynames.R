

# load the libraries
library(babynames)
library(tidyverse)

# get a subset of the data
my_babynames <- filter(babynames,
                       name == 'Joseph',
                       sex == 'M')

# create a plot of Joe popularity over time
p <- ggplot(data = my_babynames) +
  geom_point(mapping = aes(x=year, y=n))

p


