## Tidy up the CES dataset

library(tidyverse)
library(here)

ces_raw <- read_csv( here('data/raw/CES20_Common_OUTPUT_vv.csv') )


## Age ---------------------

ces_clean <- ces_raw |> 
  # create a new variable called age
  mutate(age = 2020 - birthyr)


ces_clean <- ces_clean |> 
  # create a new variable called 'old', equal to TRUE if the respondent
  # is greater than or equal to 65 years old
  mutate(old = age >= 65)

# did we do that right?
ces_clean |> 
  select(birthyr, age)


## Labor Union Membership ----------------

ces_clean |> 
  count(union)

# clean up that union variable and make it readable
ces_clean <- ces_clean |> 
  mutate(union = case_when( union == 1 ~ 'Yes',
                            union == 2 ~ 'Former',
                            union == 3 ~ 'No' ) )

ces_clean |> 
  count(union)

# hmmm. the order is wrong. What if this was an ordinal variable
# and we cared about order?
ces_clean <- ces_clean |> 
  mutate(union = factor(union,
                        levels = c('Yes', 'Former', 'No')))

ces_clean |> 
  count(union)


# what's the average age of union members vs. non union members vs. 
# former union members?
ces_clean |> 
  group_by(union) |> 
  summarize(avg_age = mean(age))



## Clean up the state column ---------------

library(tidycensus)

fips_codes

# create my FIPS code lookup table
fips <- fips_codes |> 
  select(inputstate = state_code, state_name) |> 
  unique() |> 
  mutate(inputstate = as.numeric(inputstate))

# join that lookup table into the big CES dataset
ces_clean <- ces_clean |> 
  left_join(fips, by = 'inputstate')



## Take our clean dataset and save it ---------------

# just keep the variables you want
ces_clean <- ces_clean |> 
  select(gender, educ, union, state_name)

save(ces_clean, file = 'data/ces-2020-clean.RData')
