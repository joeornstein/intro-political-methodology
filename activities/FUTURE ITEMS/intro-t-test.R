## T-test
## Motivate from the most basic sampling problem

library(tidyverse)

N1 <- 1e4
N2 <- 1e4
population <- tibble(sex = c(rep('Male',N1),rep('Female',N2)),
                     outcome = c(rnorm(N1, 0, 1), rnorm(N2, 1, 1)))

population %>% 
  ggplot(mapping = aes(x=outcome, fill = sex)) +
  geom_density(alpha = 0.2)


data <- population %>% 
  slice_sample(n = 1000)

data %>% 
  ggplot(mapping = aes(x=outcome, fill = sex)) +
  geom_density(alpha = 0.2)

data %>% 
  ggplot(mapping = aes(x=y, color = factor(x))) +
  geom_density()

summary(lm(outcome~sex,data=data))

difference_in_means <- function(population, sample_size){
  data <- population %>% 
    slice_sample(n=sample_size)
    
  return(mean(data$outcome[data$sex == 'Male']) - 
           mean(data$outcome[data$sex == 'Female']))
}

# data %>% 
#   ggplot(mapping = aes(x=x,y=y)) +
#   geom_density2d_filled()

## NO FAKE DATA. Pull from the giant population.
## Load CCES
population <- read_csv('problem-sets/08-prediction/data/Labeled-CCES-Test-POLS-7012.csv') %>% 
  select(democratic2016, gender)

population %>% 
  group_by(gender) %>% 
  summarize(percent_democrat = mean(democratic2016))

set.seed(42)
data <- population %>% 
  slice_sample(n = 500)

data %>% 
  group_by(gender) %>% 
  summarize(percent_democrat = mean(democratic2016),
            num = n())

mosaicplot(~ gender + democratic2016, data = data)
data %>% 
  ggplot(aes(x=gender, y=1, fill=factor(democratic2016))) +
  geom_bar(stat="identity", position = 'fill')