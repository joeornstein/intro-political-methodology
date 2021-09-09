# ---
# title: Code we wrote in class (POLS 7012, Week 4)
# date: 2021-09-08
# ---

library(tidyverse)
library(here)


## 1. Perceptions About The Economy By Educational Attainment ----

# load data and clean up the education variable
load(here("data/ces-2020/cleaned-CES.RData"))
ces <- ces %>%
  filter(national_economy != "NA") %>%
  mutate(educ = factor(educ, 
                       levels = c("No HS", "High school graduate", "Some college",
                                  "2-year", "4-year", "Post-grad")))


# group by education level and compute percent who believe the economy has gotten much worse

# all respondents
ces %>% 
  group_by(educ) %>% 
  summarize(pct_much_worse = sum(national_economy == 'Gotten much worse') / n())

# can this be explained by partisanship? What if you just look at the Trump supporters?
ces %>% 
  filter(trump_approval == 'Strongly approve') %>% 
  group_by(educ) %>% 
  summarize(pct_much_worse = sum(national_economy == 'Gotten much worse') / n(),
            total_surveyed = n())

# just the Trump haters
ces %>% 
  filter(trump_approval == 'Strongly disapprove') %>% 
  group_by(educ) %>% 
  summarize(pct_much_worse = sum(national_economy == 'Gotten much worse') / n(),
            total_surveyed = n())

# condition on whether the respondent lost work during the pandemic
ces %>% 
  group_by(trump_approval, lost_work_during_covid, educ) %>% 
  summarize(pct_much_worse = sum(national_economy == 'Gotten much worse') / n(),
            total_surveyed = n()) %>% 
  View


## 2. Willingness to fight in a war, conditional on whether you vote or not ----

# load data
load(
  here('data', 'raw', 
       'WVS_Cross-National_Wave_7_R_v2_0.rdata')
  )

p <- `WVS_Cross-National_Wave_7_v2_0` %>%
  #selct specific data and rename it
  select(country = C_COW_ALPHA, 
         will_to_fight = Q151, 
         birth_year = Q261,
         vote_in_national_elections = Q222) %>%
  #get rid of the erroneous data input by no answers and lost answers
  filter(birth_year >= 1930, 
         will_to_fight >= 1,
         vote_in_national_elections >= 1) %>%
  #invert the will to fight catagory since 2 was a "no" and 1 was "yes"
  mutate(fight_for_country = if_else(will_to_fight == 2, 0, 1)) %>% 
  #group years into new variables of decades
  mutate(decade_of_birth = case_when(birth_year < 1940 ~ '1930s',
                                     birth_year < 1950 ~ '1940s',
                                     birth_year < 1960 ~ '1950s',
                                     birth_year < 1970 ~ '1960s',
                                     birth_year < 1980 ~ '1970s',
                                     birth_year < 1990 ~ '1980s',
                                     birth_year < 2000 ~ '1990s',
                                     birth_year < 2010 ~ "2000s")) %>% 
  # organize data set by decade, country, and voting
  group_by(decade_of_birth, country, vote_in_national_elections) %>% 
  # summarize compresses the data
  summarize(mean_will_to_fight = mean(fight_for_country), 
            count = n()) %>% 
  filter(country %in% c("USA", "AUL", "ROK", "CHN", "JPN") ) %>% 
  ggplot(mapping = aes(x= decade_of_birth , y= mean_will_to_fight, group = country, color = country)) +
  geom_line ()+ 
  scale_color_brewer(palette = "Set1")+
  theme_minimal() +
  theme(plot.title = element_text(face = "bold", hjust = 0.5))+
  labs (x = "Decade of Birth" , 
        y = "% of Respondants Willing to Fight", 
        title = "Pacific Coalition vs. China",
        colour = "Country") +
  facet_wrap(~vote_in_national_elections)
p

## 3. Do more unequal countries have greater class cleavages in opinions about personal responsibility? -------

# create a summary table
by_country <- `WVS_Cross-National_Wave_7_v2_0` %>%
  # keep and rename these variables
  select(
    country = C_COW_ALPHA,
    individual_responsibility = Q108,
    econ_class = Q287,
    gini = giniWB
  ) %>%
  # remove the missing values
  filter(individual_responsibility > 0, 
         econ_class > 0) %>%
  # group by self-reported economic class and country
  group_by(econ_class, country) %>%
  # for each country/class, compute the mean of the individual responsibility
  # score, and that country's Gini coefficient
  summarize(
    mean_individual_responsibility = mean(individual_responsibility) ,
    gini_country = mean(gini),
    count = n()
  ) %>%
  # remove the countries that are missing Gini coefficients
  filter(gini_country > 0) %>%
  # keep the self-reported middle and lower class respondents
  filter(econ_class %in% c(3, 5)) %>%
  # create two columns of personal responsibility score: one for the middle class and one for the lower class
  pivot_wider(
    id_cols = c('country', 'gini_country'),
    values_from = 'mean_individual_responsibility',
    names_from = 'econ_class'
  ) %>%
  # compute the difference between the average middle class response and the average lower class response
  mutate(difference_in_responsibility_score = `3` - `5`)

# plot income inequality against class cleavages
ggplot(
  data = by_country,
  mapping = aes(x = gini_country, 
                y = difference_in_responsibility_score,
                label = country)) +
  geom_text() +
  labs(x = 'Income Inequality (Gini)',
       y = 'Class Disagreement About Personal Responsibility') +
  theme_minimal()
