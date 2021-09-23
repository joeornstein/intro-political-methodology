load('data/ces-2020/cleaned-CES.RData')
#loaded data from Project-set-01 folder

library(tidyverse)
library(gapminder)


ces%>%
  count(educ) %>%
  mutate(probability = n / sum(n))

ces%>%
  count(increase_border_patrols) %>%
  mutate(probability = n / sum(n))

#look at the correlation between education level and views on border patrols

ces %>% 
  filter(!is.na(increase_border_patrols)) %>%
  count(increase_border_patrols, abb) %>%
  mutate(probability = n / sum(n)) %>% 
  ggplot(mapping = aes(x = increase_border_patrols, y = probability)) + 
  geom_col() + facet_wrap(~abb) + labs(x = "Increase Funding on Border Patrol", y = "Probability", title = "A states view on Increasing Border Patrol Spending", caption = "Source: Cooperative Election Study 2020." ) + theme_classic()



ces %>% 
  filter(!is.na(increase_border_patrols)) %>%
  count(increase_border_patrols, educ) %>%
  mutate(probability = n / sum(n)) %>% 
  ggplot(mapping = aes(x = increase_border_patrols, y = probability)) + 
  geom_col() + facet_wrap(~educ) + labs(x = "Increase on Border Patrol", y = "Probability", title = "Level of Education and Probability of Support for Increase of Border Patrol", caption = "Source: Cooperative Election Study 2020." ) + theme_classic()
#look at the states that support border patrol increases, also look

ces %>%
  select(caseid, educ, abb, increase_border_patrols)
#graph with only caseid, education level, state of residence, 

summary(ces)
#here I am able to see a summary of the entire data set, but I still need to condense a suummary of the data I need

ces %>%
  group_by(educ) %>%
  summarize(
    increase_border_patrols
  )

ces %>%
  group_by(abb) %>%
  summarize(
    increase_border_patrols
  )
#the two codes above give me a summarized view of the results of my two variables being observed.



# This looks like some leftover code from mtcars?
# ggplot(data = ces) + 
#   geom_bar(mapping = aes(x = displ, y = hwy)) + 
#   facet_grid(drv ~ cyl)

library(table1)

# note: these lines were swapped, but you need to specify the label first, then create the table
label(ces$educ) <- "Education"
table1::table1(~educ| increase_border_patrols, data = ces) 

label(ces$abb) <- "State of Residence"
table1::table1(~abb| increase_border_patrols, data = ces)



