library(palmerpenguins)




penguins |> 
  filter(island == 'Biscoe') |> 
  ggplot(mapping = aes(x = bill_length_mm,
                       y = bill_depth_mm,
                       color = species)) +
  geom_point() +
  geom_smooth(method = 'lm', se = FALSE)
