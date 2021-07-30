## Visualize the gapminder data - Healy Chapter 3

library(tidyverse, ) # always load the tidyverse first. many useful functions.
library(gapminder) # next load the gapminder library for the data

gapminder # call the gapminder object to look at the dataset


# create a ggplot object
p <- ggplot(data = gapminder,
            mapping = aes(x = gdpPercap,
                          y = lifeExp))

p # no geoms!

p + geom_point() # that adds the points

# fancy time
p + geom_point(mapping = aes(color = continent),
               alpha = 0.3) +
  scale_x_log10(labels = scales::dollar) +
  geom_smooth(method = 'gam') +
  theme_light() +
  labs(title = 'Economic Growth and Life Expectancy',
       x = 'GDP Per Capita',
       y = 'Life Expectancy',
       color = 'Continent',
       caption = 'Source: Gapminder.')
