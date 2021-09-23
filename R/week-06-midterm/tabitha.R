library(tidyverse)
library(janitor)
library(dplyr)
library(ggplot2)
library(knitr)

# load original data
ces_raw <- read_csv('data/raw/ces-2020/CES20_Common_OUTPUT_vv.csv') %>% 
  # clean up the names (janitor function)
  clean_names()

midterm_ces <- ces_raw %>%
  # recode some variables
  mutate(gender = if_else(gender == 1, 'Male', 'Female'),
         educ = case_when(educ == 1 ~ 'No HS',
                          educ == 2 ~ 'High school graduate',
                          educ == 3 ~ 'Some college',
                          educ == 4 ~ '2-year',
                          educ == 5 ~ '4-year',
                          educ == 6 ~ 'Post-grad'),
         race = case_when(race == 1 ~ 'White',
                          race == 2 ~ 'Black',
                          race == 3 ~ 'Hispanic',
                          race == 4 ~ 'Asian',
                          TRUE ~ 'Other'),
         age = 2020 - birthyr, 
         Self_identified_affiliation = case_when(pid3 == 1 ~ 'Democrat',
                                                 pid3 == 2 ~ 'Republican',
                                                 pid3 == 3 ~ 'Independent'),
         national_economy = case_when(cc20_302 == 1 ~ 'Gotten much better',
                                      cc20_302 == 2 ~ 'Gotten somewhat better',
                                      cc20_302 == 3 ~ 'Stayed about the same',
                                      cc20_302 == 4 ~ 'Gotten somewhat worse',
                                      cc20_302 == 5 ~ 'Gotten much worse',
                                      cc20_302 == 6 ~ 'Not sure'),
         someone_diagnosed_with_covid = if_else(cc20_309a_5 == 2, 'Yes', 'No'),
         trump_approval = case_when(cc20_320a == 1 ~ 'Strongly approve',
                                    cc20_320a == 2 ~ 'Somewhat approve',
                                    cc20_320a == 3 ~ 'Somewhat disapprove',
                                    cc20_320a == 4 ~ 'Strongly disapprove',
                                    cc20_320a == 5 ~ 'Not sure'),
         social_media_24h = if_else(cc20_300_1 == 1, 'Yes', 'No'),
         tv_news_24h = if_else(cc20_300_2 == 1, 'Yes', 'No'),
         newspaper_24h = if_else(cc20_300_3 == 1, 'Yes', 'No'),
         radio_news_24h = if_else(cc20_300_4 == 1, 'Yes', 'No'),
         ABC = if_else(cc20_300b_1 == 1, 'Yes', 'No'),
         CBS = if_else(cc20_300b_2 == 1, 'Yes', 'No'),
         NBC = if_else(cc20_300b_3 == 1, 'Yes', 'No'),
         CNN = if_else(cc20_300b_4 == 1, 'Yes', 'No'),
         FoxNews = if_else(cc20_300b_5 == 1, 'Yes', 'No'),
         MSNBC = if_else(cc20_300b_6 == 1, 'Yes', 'No'),
         PBS = if_else(cc20_300b_7 == 1, 'Yes', 'No'),
         Other = if_else(cc20_300b_8 == 1, 'Yes', 'No'),
         Fox_or_CNN = case_when(cc20_300b_4 == 1 ~ 'CNN',
                                cc20_300b_5 == 1 ~ 'FoxNews'),
         Region = case_when(region == 1 ~ "Northeast",
                            region == 2 ~ "Midwest",
                            region == 3 ~ "South",
                            region == 4 ~ "West"),
         #added variables together to get estimates of how well the participants are involved in political networks,
         #lower numbers mean that they said yes to the variable which equals out to a higher level of political network strength. 
         # Split the varible into thirds but the odd numbers resulted in moderates having 6 possible score instead of 5
         political_networkwhole = (cc20_300a + cc20_300c + cc20_300d_1 + cc20_300d_2 + 
                                     cc20_300d_3 + cc20_300d_4 + cc20_300d_5 + newsint),
         political_network = case_when(political_networkwhole == 8 ~ 'Strong',
                                       political_networkwhole == 9 ~ 'Strong',
                                       political_networkwhole == 10 ~ "Strong",
                                       political_networkwhole == 11 ~ 'Strong',
                                       political_networkwhole == 12 ~ 'Strong',
                                       political_networkwhole == 13 ~ 'Moderate',
                                       political_networkwhole == 14 ~ 'Moderate',
                                       political_networkwhole == 15 ~ 'Moderate',
                                       political_networkwhole == 16 ~ 'Moderate',
                                       political_networkwhole == 17 ~ 'Moderate',
                                       political_networkwhole == 18 ~ 'Moderate',
                                       political_networkwhole == 19 ~ 'Weak',
                                       political_networkwhole == 20 ~ 'Weak',
                                       political_networkwhole == 21 ~ 'Weak',
                                       political_networkwhole == 22 ~ 'Weak',
                                       political_networkwhole == 23 ~ 'Weak'))
# inputstate is a fips code. merge with maps::state.fips to get state names
state_names <- maps::state.fips %>% 
  select(fips, abb) %>% 
  # missing alaska and hawaii
  bind_rows(
    tibble(
      fips = c(2, 15),
      abb = c('AK', 'HI'))) %>% 
  unique %>% 
  arrange(fips)

midterm_ces <- midterm_ces %>% 
  mutate(fips = inputstate) %>% 
  left_join(state_names, by = 'fips') %>% 
  # select the variables you want
  select(caseid, gender, educ, race, age,Self_identified_affiliation, abb, national_economy,
         someone_diagnosed_with_covid,
         trump_approval, Region,
         social_media_24h, tv_news_24h, newspaper_24h, radio_news_24h, ABC, CBS, NBC, CNN, FoxNews, MSNBC, PBS, Other,
         political_network, political_networkwhole, Fox_or_CNN
  ) %>% 
  # order the factor variables
  mutate(national_economy = factor(national_economy,
                                   levels = c('Not sure', 'Gotten much worse',
                                              'Gotten somewhat worse', 'Stayed about the same',
                                              'Gotten somewhat better', 'Gotten much better')),
         trump_approval = factor(trump_approval,
                                 levels = c('Strongly disapprove', 'Somewhat disapprove',
                                            'Not sure', 'Somewhat approve', 'Strongly approve')),
         political_network = factor(political_network,
                                    levels = c('Strong', 'Moderate', 'Weak')))


# write cleaned dataset to file
# save(midterm_ces, file = 'data/ces-2020/cleanedmidterm-CES.RData')      
#Everything above was loading/importing data in from the website. 

#Filtering out the NA responses for my variables of interest
midterm_ces_not_na <- midterm_ces %>% 
  filter(!is.na(trump_approval) & !is.na(national_economy) & !is.na(political_network) & !is.na(Fox_or_CNN))


PoliticalNetworkStrength_by_Approval <- midterm_ces_not_na %>%
  group_by(trump_approval, political_network) %>%
  summarize(N = n()) %>% #creates news smaller table with trump approval, political network and N which is the number of observations within each political network for each level of trump approval
  mutate(freq = N / sum(N), # uses n to form relative proportion and percentage for each political network level, grouped by trump approval
         pct = round((freq*100), 0)) #rounds it to nearest percentage point

PoliticalNetworkStrength_by_Economic<- midterm_ces_not_na %>%
  group_by(national_economy, political_network) %>%
  summarize(N = n()) %>% 
  mutate(freq = N / sum(N),
         pct = round((freq*100), 0))

p <- ggplot(PoliticalNetworkStrength_by_Approval, aes(x = trump_approval, y = pct, fill = political_network))
#can use geom_col instead of geom_bar because data comes directly from percentage values in a summary table
p + geom_col(position = "dodge2") + #dodge2 puts the sub-categories (trump approval) side-by-side within groups (political strength)
  labs(x = NULL, y = "Percent", fill = "Political Network Strength", title = "Trump Approval by Political Network Strength",
       caption = "Data: 2020 Cooperative Election Study.") +
  #x is null because trump approval doesn't need an axis label, we understand it without it 
  guides(fill = FALSE)  + 
  coord_flip() + #switches the x and y axes after the plot is mapped
  scale_fill_manual(name = "Strength of Political Network",
                    labels = c("Strong", "Moderate", "Weak"),
                    values = c("Strong" = "darkorange", "Moderate" = "seagreen3", "Weak" = "purple"))+
  facet_grid(~ political_network)

p1 <- ggplot(PoliticalNetworkStrength_by_Economic, aes(x = national_economy, y = pct, fill = political_network))
p1 + geom_col(position = "dodge2") +
  labs(x = NULL, y = "Percent", fill = "Political Network Strength", title = "Economic Outlook by Political Network Strength",
       caption = "Data: 2020 Cooperative Election Study.") +
  guides(fill = FALSE)  + 
  coord_flip() + 
  scale_fill_manual(name = "Strength of Political Network",
                    labels = c("Strong", "Moderate", "Weak"),
                    values = c("Strong" = "darkorange", "Moderate" = "seagreen3", "Weak" = "purple"))+
  facet_grid(~ political_network)


p2 <- ggplot(data = midterm_ces_not_na, mapping = aes(x = national_economy, fill = political_network))
#using dodge to stack results within the columns
p2 + geom_bar(position = "dodge", mapping = aes(y = ..prop.., group = political_network)) +
  labs(y = "Proportion of Responses", x = "Economic Outlook",
       title = "Economic Outlook by Political Network Strength",
       caption = "Data source: 2020 Cooperative Election Study.") +
  scale_x_discrete(labels = function(x) str_wrap(x, width = 10), #setting values and labels 
                   limits = c("Gotten much better", "Gotten somewhat better",
                              "Stayed about the same", "Gotten somewhat worse",
                              "Gotten much worse", "not sure")) +
  #setting the colors to purple, green, and orange because it's almost the end of September. So it's almost October so it is basically Halloween. 
  scale_fill_manual(name = "Strength of Political Network",
                    labels = c("Strong", "Moderate", "Weak"),
                    values = c("Strong" = "darkorange", "Moderate" = "seagreen3", "Weak" = "purple"))

p4 <- ggplot(data = midterm_ces_not_na, mapping = aes(x = trump_approval, fill = political_network))
#using dodge to stack results within the columns
p4 + geom_bar(position = "dodge", mapping = aes(y = ..prop.., group = political_network)) +
  labs(y = "Proportion of Responses", x = "Trump Approval",
       title = "Trump Approval by Political Network Strength",
       caption = "Data source: 2020 Cooperative Election Study.") +
  scale_x_discrete(labels = function(x) str_wrap(x, width = 10), #setting values and labels 
                   limits = c('Strongly disapprove', 'Somewhat disapprove',
                                            'Not sure', 'Somewhat approve', 'Strongly approve')) +
  scale_fill_manual(name = "Strength of Political Network",
                    labels = c("Strong", "Moderate", "Weak"),
                    values = c("Strong" = "darkorange", "Moderate" = "seagreen3", "Weak" = "purple"))

#sliced midterm for all levels of trump approval, only plots 10 percent of the boxes makes it easier to see data
Midtermslice <- slice_sample(midterm_ces_not_na, prop = 0.1)
approval_colors <- c("#2E74C0", "#CB454A","#264F13")
p3 <- ggplot(data = Midtermslice) +
  #set alpha to 0.2 to make them more transparent not one huge black mass
  geom_jitter(mapping = aes(x=trump_approval, y=national_economy, alpha =0.2, color = political_network)) +
  scale_color_manual(values = approval_colors) +
  geom_line(mapping = aes(x=trump_approval, y=national_economy, alpha= 0.2)) +
  theme_minimal() +
  #get rid of stray alpha legend 
  guides(alpha = 'none') +
  labs(x = 'Trump Approval', y= "Economic Outlook",
       title = 'Economic Outlook Among Trump Supporters by Political Network Strength',
       color = 'Political Network Strength')
p3

# install.packages('gganimate')
# install.packages('gifski')
# devtools::install_github("ropensci/nlrx")


library(ggplot2)
library(gganimate)
library(gifski)



# Make a ggplot, but add frame=year: one image per year
myPlot <- ggplot(Midtermslice, aes(political_networkwhole, age, size = 12, color = Fox_or_CNN)) +
  geom_point(size = 10) +  #tried to fix the dot size not sure if it worked above or on this line
  scale_x_log10() +
  theme_bw() +
  # gganimate specific bits:
  labs(title = 'Age: {frame_time}', x = 'Poltical Network Strength', y = 'Age', color = 'News Preference')  +
  transition_time(age) +
  ease_aes('linear')

animate(myPlot, duration = 30, fps = 75, width = 700, height = 700, renderer = gifski_renderer())
# anim_save("output.gif")


