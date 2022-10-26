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
