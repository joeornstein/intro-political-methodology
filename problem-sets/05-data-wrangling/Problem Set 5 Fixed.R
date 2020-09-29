library(readstata13)
library(tidyverse)
library(tidyr)
library(knitr)
library(ggplot2)
library(readxl)
library(dplyr)

#Read and write csv files for datasets

NMC_5_0 <- read.dta13('data/NMC_5_0.dta')

write_csv(NMC_5_0, 'data/NMC_5_0.csv')

Polity_5 <- read_excel('data/p5v2018.xls')

write_csv(Polity_5, 'data/p5v2018.csv')

#filter variables and combine datasets

polity.data <- Polity_5 %>% 
  select(year, ccode, country, polity2)

NMC_data <- NMC_5_0 %>% 
  select(year, ccode, tpop, milper)

combined_data <- left_join(NMC_data, polity.data,
                           by = c('ccode', 'year'))

#All variables needed for later: democ, autoc, ccode, year, tpop, milper 

#create variable for military personnel per 1000 people and variable for regime type

combined_data <- filter(combined_data, !is.na(milper))

combined_data <- filter(combined_data, !is.na(tpop))

combined_data1<- combined_data %>% 
  mutate(combined_data, milper1 = (milper / tpop) * 1000) %>% 
  mutate(combined_data, regime = case_when(polity2 %in% 6:10 ~ 'Democracy',
                            polity2 %in% -10:5 ~ 'Autocracy')) %>%
  na.omit()


#Compute the average share of the population in the military for autocracies and democracies over
#time (group_by regime type and year), as well as the number of countries in each category (summarize function). 
#Assign this new grouped dataframe to an object


compute_milper <- combined_data1 %>% 
  group_by(regime, year) 

  summarize("Military Personnel"= mean(milper1), 
            'Number of Observations'= n())



count(compute_milper, regime)


#filter out NAs and set max and minium averages

compute_milper <- filter(compute_milper,milper1 >= 0 & milper1 <= 225)

#graph the results

figA <- ggplot(data = compute_milper, aes(x= year)) +
  geom_line(aes(y= milper1), color= 'darkred')+
  facet_wrap(~regime)+
  xlab('Year') +
  ylab('Military Personell per 1,000 People')+
  labs(title= 'Autocracies vs. Democracies')+
  labs(subtitle= 'Average Share of Population in Military over Time')+
  theme_dark()


figA

fig1 <- compute_milper %>%
  ggplot(aes(x=year,y= 'Military Personnel'))+
  geom_line(color= 'darkred')+
  facet_wrap(~regime)+
  xlab('Year') +
  ylab('Military Personnel per 1,000 People')+
  labs(title= 'Autocracies vs. Democracies')+
  labs(subtitle= 'Average Share of Population in Military over Time')+
  theme_dark()

fig1

ggsave('fig1.png')

ggsave('figA.png')
