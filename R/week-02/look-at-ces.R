
library(tidyverse) # always load tidyverse!

# this line loads the data from disk
load('data/ces-2020/cleaned-CES.RData')

# bar plot of trump approval by support for tariffs
p1 <- ggplot(data = ces) +
  # y-axis is level of trump approval (also color for fun)
  geom_bar(mapping = aes(y = trump_approval,
                         fill = trump_approval)) +
  # two separate charts, one for each level of tariff support
  facet_wrap(~race) +
  # change the theme
  theme_classic() +
  # remove the legend
  theme(legend.position = 'none')

p1
