## Does democracy reduce corruption?

library(tidyverse)

d <- read_csv('data/week-09/corruption-data.csv')


lm(cpi_score ~ democracy, data = d)


d |> 
  mutate(income_group = case_when(gdp_per_capita < 10000 ~ 'Low Income',
                                  gdp_per_capita < 40000 ~ 'Middle Income',
                                  TRUE ~ 'High Income')) |> 
  ggplot(mapping = aes(x=democracy, y=cpi_score)) +
  geom_point() +
  geom_smooth(method = 'lm', se = FALSE) +
  facet_wrap(~income_group)



A <- rbind(c(1,2,5),
           c(2,4,100),
           c(3,6,-42))

solve(A)


# drop all of the countries that don't have data
d <- filter(d, complete.cases(d))

lm(cpi_score ~ democracy, data = d)


# create the Y vector
Y <- d$cpi_score
# create the X matrix
X <- d |> 
  select(democracy, gdp_per_capita) |> 
  mutate(intercept = 1) |> 
  as.matrix()

beta_hat <- solve( t(X) %*% X  ) %*% t(X) %*% Y

beta_hat

lm(cpi_score ~ democracy + gdp_per_capita, data = d)


## What if we include Human Freedom Index?
hf <- read_csv('data/raw/HFI2021.csv')

hf <- hf |> 
  filter(year == max(year))

# rename ISO to iso3 and left_join()

hf <- hf |> 
  select(iso3 = ISO, hf_score)

d <- left_join(d, hf, by = 'iso3')



lm(cpi_score ~ democracy + hf_score, data = d)


ggplot(data = d,
       mapping = aes(x = democracy, y = hf_score)) +
  geom_point() +
  geom_smooth(method = 'lm', se = FALSE)


library(ggrepel)

ggplot(data = d,
       mapping = aes(x = hf_score, y = cpi_score, 
                     label = iso3, color = factor(democracy))) +
  geom_point() +
  geom_text_repel() +
  scale_color_manual(values = c('red', 'blue'))


mod <- lm(cpi_score ~ hf_score + democracy, data = d)

mod

intercept_for_democracies <- -57.93 + -13.29
  
intercept_for_autocracies <- -57.93 
  
slope_of_hf <- 15.53

ggplot(data = d,
       mapping = aes(x = hf_score, y = cpi_score, 
                     label = iso3, color = factor(democracy))) +
  geom_point() +
  geom_text_repel() +
  scale_color_manual(values = c('red', 'blue')) +
  geom_abline(intercept = intercept_for_autocracies, slope = slope_of_hf,
              color = 'red') +
  geom_abline(intercept = intercept_for_democracies, slope = slope_of_hf,
              color = 'blue')
  
