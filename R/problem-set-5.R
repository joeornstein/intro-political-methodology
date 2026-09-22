
d <- read.csv('MEASUREMENT/unvoting.csv')


# Question 1: Plot distribution of idealpoint in 1980 and 2000, and compare -------------------------

unvoting1980 <- subset(d, Year == 1980)
unvoting2000 <- subset(d, Year == 2000)

hist(unvoting1980$idealpoint)
abline(v = median(unvoting1980$idealpoint), col = 'red')

hist(unvoting2000$idealpoint)
abline(v = median(unvoting2000$idealpoint), col = 'red')

quantile(unvoting1980$idealpoint)
quantile(unvoting2000$idealpoint)



# Question 4: Compare former Soviet countries with non-former Soviet countries ------------


d$soviet <- d$CountryName %in% c('Estonia', 'Latvia', 'Lithuania', 'Belarus', 'Moldova', 
                                'Ukraine', 'Armenia', 'Azerbaijan', 'Georgia', 'Kazakhstan',
                              'Kyrgyzstan', 'Tajikistan', 'Turkmenistan', 'Uzbekistan', 'Russia')
table(d$soviet)


# plot ideal point vs. pctAgreeUS, compare soviet vs. non-soviet countries (2012)
library(ggplot2)
ggplot(data = d[d$Year == 2012,], mapping = aes(x = idealpoint, y = PctAgreeUS, color = soviet)) +
  geom_point()


mean(d$idealpoint[d$soviet])
mean(d$idealpoint[!d$soviet])

mean(d$PctAgreeUS[d$soviet])
mean(d$PctAgreeUS[!d$soviet], na.rm=TRUE)


ggplot(data = d[d$Year == 1993,], mapping = aes(x = idealpoint, y = PctAgreeUS, color = soviet)) +
  geom_point()
