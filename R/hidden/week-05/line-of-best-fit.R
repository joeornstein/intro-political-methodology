## How do we estimate the "line of best fit"?

library(tidyverse)

d <- read_csv('data/ches/ches-cleaned.csv')

## Visualize that relationship

ggplot(data = d,
       mapping = aes(x = social,
                     y = economic)) +
  geom_point() +
  geom_smooth(method = 'lm', se = FALSE) +
  theme_minimal()


lm(economic ~ social, data = d)




# our measure of "goodness of fit" is the sum of squared errors

slope <- 0.3125

ggplot(data = d,
       mapping = aes(x = social,
                     y = economic)) +
  geom_point() +
  geom_abline(intercept = 0, slope = slope) +
  theme_minimal()

d |> 
  summarize(sum_of_squared_error = 
              sum( (economic - social * slope) ^ 2 ) 
            )







  
