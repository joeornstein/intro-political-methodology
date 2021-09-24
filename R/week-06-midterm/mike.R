# library(ggplot2)
# library(tinytex)
library(tidyverse)  
library(haven)
library(sjlabelled)
# Import data
mydata <- read_dta("data/raw/March_2020_data.dta") %>%
  remove_all_labels()

mydata_tidy <- mydata %>%
  select (v143_code, v12, v13, v19, v144) %>%
  rename(religion=v143_code,prevent=v13,palestine=v19,religiosity=v144, peace=v12) %>%
  filter(religion==1) %>%
  filter(prevent<=2) %>%
  filter(peace<=4) %>%
  filter(palestine<=4) %>%
  filter(religiosity<=5) %>%
  mutate(hawk_score=palestine + prevent + peace)%>% 
  mutate(religiosity = case_when(religiosity== 1 ~'Haredi',
                                 religiosity== 2 ~'Religious',
                                 religiosity== 3 ~'Traditional Religious',
                                 religiosity== 4 ~'Traditional Non-Religious',
                                 religiosity== 5 ~'Secular'))
  

I <- ggplot(data=mydata_tidy,
            aes(x=religiosity, y=hawk_score))
I + geom_jitter()+geom_boxplot(alpha=0.3)+stat_summary(fun.y=mean, geom="point", shape=20, size=8, 
                                                                   color="red", fill="red")+labs(title="Jewish Religiosity and Hawkish Attitudes in Israel",x="Religiosity",
                                                                                                 y='Hawk Score')


## Alternative hawk score where each component gets equal weight:
mydata_tidy <- mydata %>%
  select (v143_code, v12, v13, v19, v144) %>%
  rename(religion=v143_code,prevent=v13,palestine=v19,religiosity=v144, peace=v12) %>%
  filter(religion==1) %>%
  filter(prevent<=2) %>%
  filter(peace<=4) %>%
  filter(palestine<=4) %>%
  filter(religiosity<=5) %>%
  # rescale each component to 0-1, where one is the most hawkish
  mutate(peace = (peace - min(peace)) / (max(peace) - min(peace)),
         palestine = (palestine - min(palestine)) / (max(palestine) - min(palestine)),
         prevent = (prevent - min(prevent)) / (max(prevent) - min(prevent))) %>% 
  mutate(hawk_score=palestine + prevent + peace)%>% 
  mutate(religiosity = case_when(religiosity== 1 ~'Haredi',
                                 religiosity== 2 ~'Religious',
                                 religiosity== 3 ~'Traditional Religious',
                                 religiosity== 4 ~'Traditional Non-Religious',
                                 religiosity== 5 ~'Secular'))

I <- ggplot(data=mydata_tidy,
            aes(x=religiosity, y=hawk_score))
I + geom_jitter(width = 0.2, height = 0.2)+
  geom_boxplot(alpha=0.3)+
  stat_summary(fun.y=mean, geom="point", shape=20, size=8, 
               color="red", fill="red")+labs(title="Jewish Religiosity and Hawkish Attitudes in Israel",x="Religiosity",
                                             y='Hawk Score')
