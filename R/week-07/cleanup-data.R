# ---
# title: Clean up Chapel Hill Expert Survey for slides
# author: Joe Ornstein
# date: 2021-09-27
# ---

library(tidyverse)

# dataset downloaded from https://www.chesdata.eu/1999-2019chestrend
ches <- read_csv('data/ches/1999-2019_CHES_dataset_means(v2).csv')


d <- ches %>% 
  # keep the most recent year
  filter(year == 2019) %>% 
  # demean the social and economic position variables
  mutate(social = galtan - mean(galtan),
         economic = lrecon - mean(lrecon)) %>% 
  select(country, party, party_id, social, economic)


ggplot(data = d,
       mapping = aes(x = social, y = economic)) +
  geom_point() +
  geom_smooth(method = 'lm', se = FALSE) +
  theme_bw() +
  scale_y_continuous(limits = c(-5, 5)) +
  coord_equal() +
  labs(title = 'European Political Parties (2019)',
       caption = 'Measures from the Chapel Hill Expert Survey (Bakker et al., 2019)',
       x = 'Position on Social Issues',
       y = 'Position on Economic Issues')
