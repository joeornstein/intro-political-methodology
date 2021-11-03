# Instrumental variables designs through two-stage least squares


library(tidyverse)
library(foreign)

raw <- read.dta('data/campante-do-2014/CampanteDo_MainData.dta')

# line 6 on of the do file
d <- raw %>% 
  mutate(GCISCmean1970 = rowMeans(across(GCISC1920:GCISC1970)),
         # average log distance, the opposite of GCISC
         ALDmean1970 = 1 - GCISCmean1970,
         # compute average distance to the state centroid
         centr_GCISCmean1970 = rowMeans(across(centr_GCISC1920:centr_GCISC1970)),
         centr_ALDmean1970 = 1 - centr_GCISCmean1970) %>% 
  filter(year == 1970)
