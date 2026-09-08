
library(tidyverse)

# visualize the resume dataset
d <- read.csv('CAUSALITY/resume.csv')


summary_d <- d |> 
  group_by(firstname, race, sex) |> 
  summarize(callback_rate = mean(call))


ggplot(data = summary_d) +
  geom_col(mapping = aes(x=callback_rate, y = fct_reorder(firstname, callback_rate), fill = race)) +
  theme_bw() +
  labs(x = 'Callback Rate', y = 'Name', fill = NULL) +
  scale_x_continuous(labels = scales::percent_format()) + 
  scale_fill_manual(values = c('steelblue', '#BA0C2F'))



## Minimum Wage Dataset ------------------

d <- read.csv('CAUSALITY/minwage.csv')


# histogram of wages before and after by location

ggplot(data = d) +
  geom_histogram(mapping = aes(x = wageBefore, y = after_stat(count / sum(count))),
                 color = 'black', fill = 'red') +
  scale_x_continuous(limits = c(4,6)) +
  scale_y_continuous(labels = scales::percent_format()) +
  labs(y = 'Percent')

# try it with a boxplot instead
ggplot(data = d, mapping = aes(x = wageAfter, y = location)) +
  geom_boxplot() +
  theme_bw()

# compare wageBefore and wageAfter within each location
d |>
  pivot_longer(c(wageBefore, wageAfter),
               names_to = 'period', values_to = 'wage') |>
  mutate(period = factor(period, levels = c('wageBefore', 'wageAfter'),
                         labels = c('Before', 'After'))) |>
  ggplot(mapping = aes(x = wage, y = location, fill = period)) +
  geom_boxplot() +
  theme_bw() +
  labs(x = 'Wage', y = 'Location', fill = NULL)

