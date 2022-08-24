## Explore the General Social Survey (GSS, 2016)


## Step 1: Load the libraries and data ---------------

library(tidyverse)
library(socviz)

d <- gss_sm



## Step 2: Explore the distribution of polviews ----------

# one way to summarize categorical variables: count up 
# the number of people in each category
d |>
  count(polviews)

# what percent of people categorize themselves as 
# some kind of liberal?
d |>
  # filter out the missing observations
  filter(!is.na(polviews)) |>
  # count the number of people with liberal views
  summarize(num_liberal = sum(polviews == 'Extremely Liberal' |
                                polviews == 'Liberal' |
                                polviews == 'Slightly Liberal'),
            num_total = n(),
            pct_liberal = num_liberal / num_total * 100)


## Step 3: Summarizing a continuous variable ----------

mean(d$age, na.rm = TRUE) # get the mean age

# mean should be the sum divided by the number of observations
sum(d$age, na.rm = TRUE)
d |> filter(!is.na(age)) |> nrow()
140438 / 2857

median(d$age, na.rm = TRUE)

hist(d$age)


# conditional means: what is the average age for each 
# category of political view?
d |>
  group_by(polviews) |>
  summarize(avg_age = mean(age, na.rm = TRUE))


## Step 4: Support for grass by party and region --------

summary_table <- d |>
  # remove the people they didn't ask about grass
  filter(!is.na(grass)) |>
  group_by(polviews, region) |>
  summarize(support_legalization = sum(grass == 'Legal'),
            num = n(),
            pct_legalization = support_legalization / num * 100)

## Step 5: Zodiac sign and religiosity ----------------

d |>
  group_by(zodiac) |>
  summarize(pct_nonreligious = sum(relig == 'None', na.rm = TRUE) / 
              n() * 100) |>
  arrange(pct_nonreligious)


