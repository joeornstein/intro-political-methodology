#' ---
#' title: Problem Set 3 Answer Key
#' author: Joe Ornstein
#' date: 2022-09-07
#' ---


## Load Packages and Data --------------

library(tidyverse)
library(here)

ces_raw <- read_csv(here('data/raw/ces-2020/CES20_Common_OUTPUT_vv.csv'))


## Problem 1 ----------
# Are labor union members more likely to be Democrats or Republicans?

ces_clean <- ces_raw |> 
  mutate(union = case_when(union == 1 ~ 'Yes',
                           union == 2 ~ 'Former',
                           union == 3 ~ 'No')) |> 
  mutate(partyid = case_when(pid3 == 1 ~ 'Democrat',
                             pid3 == 2 ~ 'Republican',
                             TRUE ~ 'Other'))
ces_clean |> 
  group_by(union) |> 
  summarize(pct_democrat = sum(partyid == 'Democrat') / n() * 100,
            count = n())

## Problem 2 ----------------
# What is the median age of people with landline phones, 
# compared to people who only have cell phones?

ces_clean <- ces_clean |> 
  mutate(has_landline = case_when(phone == 1 ~ 'Has Landline',
                                  phone == 2 ~ 'Cell Only',
                                  phone == 3 ~ 'Has Landline',
                                  phone == 4 ~ 'Neither')) |>
  mutate(age = 2020 - birthyr)
  
ces_clean |> 
  filter(!is.na(has_landline)) |> 
  group_by(has_landline) |> 
  summarize(median_age = median(age, na.rm = TRUE))


## Problem 3 -------------------------
# Are the people who read newspapers more likely to correctly answer
# the questions about who controls the US House and Senate?

ces_clean |> 
  count(CC20_300_3)

ces_clean <- ces_clean |> 
  mutate(reads_newspaper = (CC20_300_3 == 1)) |>
  mutate(
    answered_correctly_both = 
      if_else(CC20_310a == 2 & CC20_310b == 1, 1, 0))

ces_clean |> 
  filter(!is.na(reads_newspaper),
         !is.na(answered_correctly_both)) |> 
  group_by(reads_newspaper) |> 
  summarize(pct_correct = mean(answered_correctly_both) * 100)

## Problem 4 --------------------------------
# Which religious groups are the most and least likely to support
# making abortion illegal in all circumstances?

ces_clean <- ces_clean |> 
  mutate(religion = case_when(religpew == 1 ~ 'Protestant',
                              religpew == 2 ~ 'Roman Catholic',
                              religpew == 3 ~ 'Mormon',
                              religpew == 4 ~ 'Orthodox',
                              religpew == 5 ~ 'Jewish',
                              religpew == 6 ~ 'Muslim',
                              religpew == 7 ~ 'Buddhist',
                              religpew == 8 ~ 'Hindu',
                              religpew == 9 ~ 'Atheist',
                              religpew == 10 ~ 'Agnostic',
                              religpew == 11 ~ 'Nothing in particular',
                              religpew == 12 ~ 'Something else')) |> 
  mutate(abortion_illegal = if_else(CC20_332f == 1, 1, 0))

ces_clean |> 
  filter(!is.na(religion)) |> 
  group_by(religion) |> 
  summarize(pct_support_abortion_ban = mean(abortion_illegal,
                                            na.rm = TRUE) * 100,
            num_respondents = n()) |> 
  arrange(-pct_support_abortion_ban)
