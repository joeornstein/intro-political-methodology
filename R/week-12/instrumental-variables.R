# Instrumental variable designs through two-stage least squares
# Replicating the Campante & Do (2014) paper


## Step 1: Load and clean the data ----------------------

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
  filter(year == 1970) %>% 
  filter(!is.na(ALDmean1970))


## Step 2: Recreate Figure 1 -------------------
library(ggrepel)

ggplot(data = d,
       mapping = aes(x=ALDmean1970,
                     y=corruptrate_avg,
                     label=state_code)) +
  geom_point() +
  geom_text_repel() +
  theme_minimal() +
  geom_smooth(method = 'lm', se = FALSE) +
  ggthemes::theme_stata()


## Step 3: Try to close all the back doors (Table 2) ----------------

# bigger states will have higher average distances, just geometrically
# so you want to condition on the size of the state
# column 1 (condition on state size)
lm(corruptrate_avg ~ ALDmean1970 +
     logarea + logMaxDistSt, data = d)

# column 2:
# condition on all of the above +
# population + income + pct college

lm(corruptrate_avg ~ ALDmean1970 +
     logarea + logMaxDistSt + 
     loginc + bacen + logpop, data = d)


# column 3:
# condition on all of the above +
# urban share + government employment share + census region
lm(corruptrate_avg ~ ALDmean1970 +
     logarea + logMaxDistSt + 
     loginc + bacen + logpop +
     govemp_sh + urbans + 
     south + northeast + midwest, data = d)

# column 4:
# condition on all of the above +
# ethnic fractionalization, index of regulation, 
# share of value added in mining
lm(corruptrate_avg ~ ALDmean1970 +
     logarea + logMaxDistSt + 
     loginc + bacen + logpop +
     govemp_sh + urbans + 
     south + northeast + midwest +
     fract + regulation99 + miningshare2007, 
   data = d)


## Step 4: Find a front door with 2SLS (Table 5) ---------------

# stage 1: estimate the causal effect of the instrument on the treatment
lm1 <- lm(ALDmean1970 ~ centr_ALDmean1970 +
            logarea + logMaxDistSt + 
            loginc + bacen + logpop, data = d)

lm1

# get the predicted average log distance values
d <- mutate(d,
            predicted_ALD = lm1$fitted.values)

# stage 2: model the outcome as function of the predicted values
lm(corruptrate_avg ~ predicted_ALD +
     logarea + logMaxDistSt + 
     loginc + bacen + logpop, data = d)

## Step 5: Do all that, but with a package ----------------------

library(estimatr)

iv_robust(corruptrate_avg ~ 
            ALDmean1970 + logarea + logMaxDistSt + 
            loginc + bacen + logpop | 
            centr_ALDmean1970 + logarea + logMaxDistSt + 
            loginc + bacen + logpop, 
          data = d,
          se_type = 'HC0') # exact replication
