# ---
# title: Clean up CPI, GDP per capita, and democracy score data
# date: 2021-10-12
# ---

library(tidyverse)
library(janitor)
library(readxl) # for reading Excel files
library(countrycode) # this package provides standardized country codes. 
# Very nice for joining together country-level datasets 

# load Corruption Perceptions Index; keep the 2020 score
# from: https://www.transparency.org/en/cpi/2020/
cpi <- read_xlsx('data/week-09/CPI2020_GlobalTablesTS_210125.xlsx', skip = 1) %>% 
  clean_names() %>% 
  select(country, iso3, cpi_score = cpi_score_2020)

# load gdp per capita dataset; keep the year 2019
# from: https://data.worldbank.org/indicator/NY.GDP.PCAP.PP.CD
gdp <- read_csv('data/week-09/API_NY.GDP.PCAP.PP.CD_DS2_en_csv_v2_2357064.csv', 
                skip = 4) %>% 
  clean_names() %>% 
  select(iso3 = country_code,
         gdp_per_capita = x2019)

# load Polity V dataset
# from: http://www.systemicpeace.org/inscrdata.html
polity <- read_csv('data/week-09/p5v2018.csv') %>% 
  # keep most recent scores (2018)
  filter(year == 2018) %>% 
  # add an iso3 country code for merging %>% 
  mutate(iso3 = countrycode(country, 
                            origin = 'country.name',
                            destination = 'iso3c')) %>% 
  # keep the country code and the 2018 polity score
  select(iso3, polity2)

# merge
d <- cpi %>% 
  left_join(gdp, by = 'iso3') %>% 
  left_join(polity, by = 'iso3')

# write to file
write_csv(d, 'data/week-09/clean-data.csv')
