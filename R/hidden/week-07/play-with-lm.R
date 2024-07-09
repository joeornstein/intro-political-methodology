# Play with the linear model

library(tidyverse)


swiss

p <- ggplot(data = swiss,
            mapping = aes(x = Education,
                          y = Examination)) + 
  geom_point()

p

# what's the line of best fit here?
p + 
  geom_smooth(method = 'lm', se = FALSE)

lm(Examination ~ Education, data = swiss)


# what if we exclude the outliers?
swiss |> 
  filter(Education < 25) |> 
  ggplot(mapping = aes(x = Education,
                       y = Examination)) + 
  geom_point() + 
  geom_smooth(method = 'lm', se = FALSE)

lm(Examination ~ Education,
   data = swiss |> filter(Education < 25))



## Agriculture and Education

ggplot(data = swiss,
       mapping = aes(x = Education,
                     y = Agriculture)) +
  geom_point() +
  geom_smooth(method = 'lm', se = FALSE)


# Now let's look at something very different

library(nycflights13)

ggplot(data = weather |> 
         filter(month == 6),
       mapping = aes(x = temp,
                     y = humid)) +
  geom_point() +
  labs(title = 'Temperature and Humidity at New York Airports in June') +
  geom_smooth(method = 'lm', se = FALSE)

june_weather <- weather |> 
  filter(month == 6)

lm(humid ~ temp, data = june_weather)
