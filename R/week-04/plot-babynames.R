# ---
# Plot babynames
# ---

library(tidyverse)
library(babynames)

jakes <- babynames |> 
  filter(name == 'Jake' |
           name == 'Jacob',
         sex == 'M')

p <- ggplot(data = jakes,
            mapping = aes(x=year,
                          y=prop,
                          color = name)) +
  geom_line()

p

p + facet_wrap(~name)



# plot all the Jakes together

jakes <- jakes |> 
  group_by(year) |> 
  summarize(total_jakes = sum(n))

p <- ggplot(data = jakes,
            mapping = aes(x=year,
                          y=total_jakes)) +
  #geom_line(color = 'blue', size = 1.5)
  geom_point(shape = 'star') +
  labs(title = 'Jakes Over Time, As Stars',
       caption = 'These are all the Jakes there are. In the United States. Born before 2016.')

p

