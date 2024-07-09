#### Midterm ####
# Author: Jennifer Hickey
# Date: September 21, 2021
#
# This script analyzes a data set constructed for the 2014 article, 
# Testing Theories of American Politics: Elites, Interest Groups, and Average Citizens
# It creates two graphs, one showing policy influence of Elite Americans as compared
# to Average Americans, grouped by policy area. The other shows influence of Average
# Americans as compared to Interest Groups
# Each graph shows how policy views diverge between issues in the different policy areas
# and which group "wins" when there is a disagreement
# Data can be retrieved here (Supplementary Material 6): 
# https://www.cambridge.org/core/journals/perspectives-on-politics/article/testing-theories-of-american-politics-elites-interest-groups-and-average-citizens/62327F513959D0A304D4893B382B992B#supplementary-materials
#######################
library(tidyverse)
library(haven)
library(here)

#### Function - determine_winner ####
# Returns the "winner" based on whether a specific policy change was adopted or not
# If policy change adopted (outcome >0), the winner is determined where approval rating
# is greater than 50%. If the policy change was not adopted, the winner is
# where approval rating is less than or equal to 50%
# args:
# outcome - the outcome of the proposed change, either 0 for not adopted or gt 0
# middle_income_approval - calculated approval rate of average americans
# compare_approval - the other approval rate to compare
# comparison - a text description of the category of compare_approval (i.e. Elite 
# or Interest Group)
######################
determine_winner <- function(outcome, middle_income_approval, compare_approval, 
                             comparison) {
  # Default Case
  winner <- "Neither"

  if(outcome > 0) {
    if(middle_income_approval > .5 && compare_approval > .5) {
      winner <- "Both"
    } else if(middle_income_approval > .5) {
      winner <- "Average"
    } else if(compare_approval > .5) {
      winner <- comparison
    }
  } else {
    if(middle_income_approval < .5 && compare_approval < .5) {
      winner <- "Both" 
    }else if (middle_income_approval < .5) {
      winner <- "Average"
    } else if (compare_approval < .5) {
      winner <- comparison
    } 
  }
  return(winner)
}
# Vectorize function for use with data set
determine_winner_vec <- Vectorize(determine_winner)

#### Function - plot_data ####
# Returns a stacked horizontal bar chart where y is the percentage of issues
# within a given policy area and x are the policy areas. Fill of the stacked
# bars is grouped by winner
# args:
# d - data set
# issue_area: Policy area
# pct: Proportion of issues adopted/not adopted per winner category
# winner: The winner
# comparison - a text description of the category of comparison (i.e. Elite 
# or Interest Group)
######################
plot_data <- function (d, issue_area, pct, winner, comparison) {
   # Order fill categories to keep consensus (Both/Neither) together
   winners <- c(comparison, "Average", "Neither", "Both")
   
   p_out <- ggplot(d, aes(fill=factor(winner,winners), y=pct, x=issue_area)) + 
    geom_bar(position="stack", stat="identity") +
    labs(x = "", y = "Percent", fill = "Winner") +
    ggtitle(paste("Average vs.", comparison, "Policy Influence")) +
    scale_fill_brewer(palette="RdYlBu") +
    theme(plot.title = element_text(hjust = 0.5, face="bold")) +
    coord_flip() +
    facet_grid(~ adopted)
   
   return(p_out)
}

### Average vs Elites ###
# Read stata file into R using haven
d <- read_dta(file = here('./data/rep-inequality/rep-inequality.dta'))  %>% 
  filter(!is.na(pred50_sw), !is.na(pred90_sw)) %>% 
  select(middle_income_approval=pred50_sw, 
         high_income_approval=pred90_sw, outcome=OUTCOME, issue_area=XL_AREA) %>% 
  # Categorize by policy area, Adopted/Not Adopted, and "winner" - Both/Neither/Avg/Elite
  group_by(issue_area, adopted=ifelse(outcome >0, "Adopted", "Not Adopted"), 
           winner=determine_winner_vec(outcome, middle_income_approval, high_income_approval, 
                                       "Elite") ) %>%
  # Count issues in each category
  summarize(count=n())  %>% 
  # Calculate proportion of issues based on total number of issues per policy area
  group_by(issue_area) %>% 
  mutate(pct= count/sum(count))

  p_out <- plot_data(d, issue_area, pct, winner, "Elite")
    
  # assumes a figures directory
  ggsave(here("figures", "avg_vs_elite.png"), plot = p_out, height=7, 
         width=9)

### Average vs Interest Groups ###
# Interest group approval is calculated by summing the groups that either approved
# or disapproved (since many groups abstain from issues of no concern) and
# taking the percentage of the columns that either strongly approve or 
# strongly disapprove
  d <- read_dta(file = here('./data/rep-inequality/rep-inequality.dta'))  %>% 
    filter(!is.na(pred50_sw), !is.na(INTGRP_STFAV) && !is.na(INTGRP_SWFAV) && 
             !is.na(INTGRP_STOPP) && !is.na(INTGRP_SWOPP)) %>% 
    select(middle_income_approval=pred50_sw, str_approve = INTGRP_STFAV, sw_approve=INTGRP_SWFAV, 
           str_disapprove=INTGRP_STOPP,sw_disapprove=INTGRP_SWOPP, outcome=OUTCOME,
           issue_area=XL_AREA) %>% 
    group_by(issue_area, adopted=ifelse(outcome >0, "Adopted", "Not Adopted"), 
             winner=determine_winner_vec(outcome, middle_income_approval, 
                                         ifelse((str_approve + sw_approve + str_disapprove + sw_disapprove) == 0, 
                                                0.00, (str_approve + sw_approve)/(str_approve + sw_approve + str_disapprove + sw_disapprove)), 
                                         "Interest Group")) %>%
    summarize(count=n())  %>% 
    group_by(issue_area) %>% 
    mutate(pct= count/sum(count))
  
  p_out <- plot_data(d, issue_area, pct, winner, "Interest Group")
  
  # assumes a figures directory
  ggsave(here("figures", "avg_vs_ig.png"), plot = p_out, height=7, 
         width=9)

