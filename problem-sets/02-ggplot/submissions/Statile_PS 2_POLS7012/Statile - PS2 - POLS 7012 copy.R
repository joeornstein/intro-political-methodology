# Evan Statile 
# POLS 7012
# Dr. Ornstien 
# Spetember 9, 2020
# Problem Set 2 

load("data/anes_pilot_2019.Rdata")
library(tidyverse)

# Recoding vote20jb and educ observations
data$vote20jb[data$vote20jb == 1] = "Donald Trump"
data$vote20jb[data$vote20jb == 2] = "Joe Biden"
data$vote20jb[data$vote20jb == 3] = "Other"
data$vote20jb[data$vote20jb == 4] = "Not Voting"

data$educ[data$educ == 1] = "No High School"
data$educ[data$educ == 2] = "High School Graduate"
data$educ[data$educ == 3] = "Some College"
data$educ[data$educ == 4] = "2 Year Degree"
data$educ[data$educ == 5] = "4 Year Degree"
data$educ[data$educ == 6] = "Post-Grad Degree"

# Creating a bar graph that shows support for Trump or Biden based on education 
Education = ggplot(data = data)+
  geom_bar(mapping = aes(x=vote20jb))+
  facet_wrap(~educ)+
  theme_classic()+
  xlab("Candidate")+
  ylab("Number of Votes") 

Education
## Those with more education are more likely to vote for Joe Biden 

# New data set that filters out data for ftnato and fttrump
Nato_data = filter(data, ftnato >= 0 & ftnato <= 100, fttrump >=0 & fttrump <= 100)

# Creating a point scatter plot that shows feelings towards Nato and Trump, categorized by who you are voting for
Nato = ggplot(data = Nato_data) +
  geom_point(mapping = aes(x=ftnato, y=ftrussia), color = "blue") +
  facet_wrap(~vote20jb) +
  theme_bw()+
  xlab("Feelings Thermometer (NATO)") +
  ylab("Feelings Theremometer (Russia)")
  
Nato
## Those who support Donald Trump are more or less ambivilant towards NATO and Russia 
## Those who support Joe Biden have high support for NATO and low support for Russia

# Creating a histogram looking at feelings towards journalists based on who you are voting for 
Journalism = ggplot(data = data) +
  geom_histogram(mapping = aes(x=ftjournal), color = "white") +
  facet_wrap(~vote20jb) +
  xlab("Feelings Thermometer (Journalism)") +
  ylab("Count") +
  theme_minimal()

Journalism
## If you support Joe Biden you are more likely to support journalists

#Saving my plots as .png files 
ggsave(filename = 'Education.png', plot = Education, height = 5, width = 10)
ggsave(filename = 'Nato.png', plot = Nato, height = 5, width = 8)
ggsave(filename = "Journalism.png", plot = Journalism, height = 5, width = 8)