2 + 2

2 + 2 / 3



## Load Packages

## packages are bits of code that other people made for you

library(babynames)
library(tidyverse)



babynames

View(babynames)


# filter just the rows in the dataset where the name is Fiona, sex is female, and year is 2016
filter(babynames, name == 'Fiona', sex == 'F', year == 2016)


# you can do that, but with pipes!
babynames |>
  filter(name == 'Fiona', sex == 'F', year == 2016)


# what were the five most common names for men in 1987?
babynames |>
  filter(year == 1987, sex == 'M') |>
  slice_max(prop, n = 5)

