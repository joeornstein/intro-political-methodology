
# library(bibtex)
#Gun control is an important, sensitive, and controversial subject, and  the debate about guns control has been an important diverging point between Republicans and Democrats for decades
#In 1994 the US passed a federal assault weapon ban, but this ban expired in 2004. It was studied by DiMaggio that between 1981 and 2017 assault rifles were uses in 85% od mass shootings reported. This same study concluded that ‘Mass-shooting related homicides in the United States were reduced during the years of the federal assault weapons ban of 1994 to 2004’(DiMaggio et al. 2019).

#When elected in 2016, Donald Trump had declared he was a ‘Big Second Amendment believer’ but mentioned the possibility of background checks for gun buyers and he signed in 2018 the Fix NICS Act, aimed at improving the National Instant Criminal Background Check System, and in 2019, Democrats took control of the House and passed the Bipartisan Background Check that would expand federal background checks to guns, but the bill hasn’t been taken to Senate.
#Yet, the Bipartisan Background check didn’t make it to the Senate and 2019 has been the year with the most defendants guilty of firearms offense under Trump’s office, and today Biden’s government does not seem to be considering a new assault rifle ban.
#All these elements led us to wonder about the public opinion on this ban and could the social background. 
#Our theory is that social background does influence opinion on the ban, but not as much as the political scene could show (Wozniak 2017).
#To explain it we chose data from the data set gathered in the Cooperative Election Study of 2020. We focus on race, the importance of religion, approval of institutions under Trump and level education to determine a social background and political preferences.

# View(ces)
                       
# library(ggplot2)
library(tidyverse)
# library(magrittr)
# View(ces)

# don't forget to load your data!
load('data/ces-2020/cleaned-CES.RData')

# remove missing values so NA's don't show up in the charts
ces <- ces %>% 
  filter(!is.na(trump_approval), !is.na(assault_rifle_ban), !is.na(pew_religimp))

ggplot(data = ces)+
  geom_bar(mapping = aes(y = trump_approval,fill = trump_approval)) +
  facet_wrap(~assault_rifle_ban) + 
  theme_classic() +
  labs(y = 'Approval of Trump',
       title = 'Opinion about the assault rifle ban and Trump approval')+
  theme(legend.position = 'none')

ces %>%
summarize(pct_strongly_disapprove = sum(trump_approval == 'Strongly disapprove') / n(),
          total_surveyed = n())
ces %>%
  summarize(pct_strongly_approve = sum(trump_approval == 'Strongly approve') / n(),
            total_surveyed = n())

#As expected, people strongly disapproving of Trump are much more likely to support the assault rifle ban. It is interesting to note that the difference of position on the ban inside the 'Strongly disaprove of Trump' group and inside the 'Strongly approve of Trump' is not that different, yet we must be careful because this group only represent 14749 people or 24% of total answers for 31927 people or 52,36 % of total answers in 'Strongly disapprove'.

# library(ggplot2)
# View(ces)


ggplot(data = ces)+
  geom_bar(mapping = aes(y = pew_religimp,  fill = pew_religimp)) +
  facet_wrap(~assault_rifle_ban) + 
  theme_classic() + 
  labs(y = 'Importance of regligion',
       title = 'Opinion about the assault rifle ban and importance of religion') +
  theme(legend.position = 'none')

ces %>%
  summarize(pct_very_imporant = sum(pew_religimpl == 'Very important') / n(),
            total_surveyed = n())
ces %>%
  summarize(pct_not_at_all_important = sum(pew_religimp == 'Not at all important') / n())
#We can note here that regardless of what proportion of total answers the 'very important' group is divided on the question of assault rifle and and a majority of them support the ban  ('Very important' represents 34% of all answers and 'not at all important' represents 25%)

ggplot(data = ces)+
  geom_bar(mapping = aes(y = race,  fill = race)) +
  facet_wrap(~assault_rifle_ban) + 
  theme_classic() + 
  labs(y = 'Race',
       title = 'Opinion about the assault rifle ban and race') +
  theme(legend.position = 'none')
#It i interesting to note that the proportion of people in favor in each group is not that significantly different for the other group. 

ggplot(data = ces)+
  geom_bar(mapping = aes(y = educ,  fill = educ)) +
  facet_wrap(~assault_rifle_ban) + 
  theme_classic() + 
  labs(y = 'Education level',
       title = 'Opinion about the assault rifle ban and leel of education') +
  theme(legend.position = 'none')
#We see here that the higher the level of education is, the bigger the proportion in favor of the ban is


#To conclude we can first notice that for the independent variables ‘importance of religion’, ‘race’ and ‘education level’ the variations are more important when it comes to the extremes, but for each group the majority supports the assault rifle ban. The only exception to this rule is with the independent variable “trump approval”, where we can clearly see that the group “strongly approve” mainly opposes the ban. 
#This result leads us to consider the debate around assault guns ban as a function of partisanship more than the result of social background. Then we can if the part of the population in favor of such a ban is, actually, the majority. 
