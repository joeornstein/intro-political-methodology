p <- `CV` %>%
  group_by(State) %>%
  filter(State %in% c('Kerala')) %>%
  ggplot(mapping = aes(x= `State`, y= `Turnout`, color=`Year`,
                       group = `State`, `District`)) +
  facet_wrap(~District)+
  geom_point() +
  theme_minimal()+
  labs(x = 'Districts by State - Kerala', y = 'Turnout')
p + theme_minimal()