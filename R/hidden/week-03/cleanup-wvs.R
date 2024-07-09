# ---
# Clean and visualize the World Values Survey (Wave 7)
# date: 2021-09-01
# ---

library(tidyverse)

# load in the raw data
load('data/raw/WVS_Cross-National_Wave_7_R_v2_0.RData')


# importance of democracy: Q250
# year of birth: Q261
# country: C_COW_ALPHA

# start with the raw dataset 
# (surrounded with backticks because the name has that minus sign in it)
`WVS_Cross-National_Wave_7_v2_0` %>% 
  # select the three variables we want
  select(country = C_COW_ALPHA, 
         importance_of_democracy = Q250, 
         birthyear = Q261) %>% 
  # drop the missing data
  filter(birthyear >= 1930) %>% 
  # create the decade_of_birth variable with mutate() and case_when()
  mutate(decade_of_birth = case_when(birthyear < 1940 ~ '1930s',
                                     birthyear < 1950 ~ '1940s',
                                     birthyear < 1960 ~ '1950s',
                                     birthyear < 1970 ~ '1960s',
                                     birthyear < 1980 ~ '1970s',
                                     birthyear < 1990 ~ '1980s',
                                     birthyear < 2000 ~ '1990s',
                                     birthyear < 2010 ~ '2000s')) %>% 
  # compute the average importance of democracy by country and decade of birth
  group_by(decade_of_birth, country) %>% 
  summarize(mean_importance_of_democracy = mean(importance_of_democracy),
            count = n()) %>% 
  # keep only 5 countries to plot
  filter(country %in% c('USA', 'AUL', 'ROK', 'SRB', 'EGY')) %>% 
  # decade of birth on the x-axis, mean importance of democracy on the y-axis,
  # group by country
  ggplot(mapping = aes(x=decade_of_birth, y=mean_importance_of_democracy,
                       group = country)) +
  # add a line (geom_point() and geom_col() look nice too)
  geom_line() +
  # change the theme
  theme_minimal() +
  # separate each country into a different subplot
  facet_wrap(~country) + 
  # add labels
  labs(x = 'Decade of birth', y = 'Mean Importance of Democracy')


# bar chart
`WVS_Cross-National_Wave_7_v2_0` %>% 
  select(country = C_COW_ALPHA, 
         importance_of_democracy = Q250, 
         birthyear = Q261) %>% 
  filter(birthyear >= 1930) %>% 
  mutate(decade_of_birth = case_when(birthyear < 1940 ~ '1930s',
                                     birthyear < 1950 ~ '1940s',
                                     birthyear < 1960 ~ '1950s',
                                     birthyear < 1970 ~ '1960s',
                                     birthyear < 1980 ~ '1970s',
                                     birthyear < 1990 ~ '1980s',
                                     birthyear < 2000 ~ '1990s',
                                     birthyear < 2010 ~ '2000s')) %>% 
  filter(country == 'USA',
         importance_of_democracy > 0) %>% 
  ggplot(mapping = aes(x=importance_of_democracy)) +
  geom_bar() +
  theme_minimal() +
  facet_wrap(~decade_of_birth) +
  scale_x_continuous(breaks = 1:10) +
  labs(x = 'How important is it for you to live in a democracy?', y = 'Count',
       title = 'Importance of Democracy by Decade of Birth',
       subtitle = 'United States',
       caption = 'Data source: World Values Survey, Wave 7')

# save bar chart to the figures/ folder
ggsave(filename = 'figures/importance_of_democracy.png',
       height = 5, width = 8)
