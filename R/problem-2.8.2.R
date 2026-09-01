
d <- read.csv('CAUSALITY/gay.csv')

# keep only Study 1 for now
d <- d[d$study == 1,]


## Problem 1: Was the randomization successful? ---------------------------

# did the researchers do a good job of randomizing treatments across subjects?

# here's a dataset just with the pretreatment outcomes
d_pretreatment <- d[d$wave==1,]

tapply(d_pretreatment$ssm, d_pretreatment$treatment, mean)
sd(d_pretreatment$ssm)

# sidenote: here's a tidyverse version
library(tidyverse)

d_pretreatment |> 
  group_by(treatment) |> 
  summarize(mean_ssm = mean(ssm))


prop.table(table(d_pretreatment$treatment, d_pretreatment$ssm), margin = 1)


## Problem 2: Estimate the average treatment effect at Wave 2 ------------------------------

# for simplicity let's compare each treatment against no contact
d_wave2 <- d[d$wave == 2,]

control_mean <- mean(d_wave2$ssm[d_wave2$treatment == 'No Contact'])

mean(d_wave2$ssm[d_wave2$treatment == 'Recycling Script by Gay Canvasser']) - control_mean
mean(d_wave2$ssm[d_wave2$treatment == 'Recycling Script by Straight Canvasser']) - control_mean
mean(d_wave2$ssm[d_wave2$treatment == 'Same-Sex Marriage Script by Straight Canvasser']) - control_mean
mean(d_wave2$ssm[d_wave2$treatment == 'Same-Sex Marriage Script by Gay Canvasser']) - control_mean

# because the outcome is ordinal, it's a bit more straightforward to estimate something like
# the difference in percent that strongly support same-sex marriage
mean(d_wave2$ssm[d_wave2$treatment == 'Same-Sex Marriage Script by Gay Canvasser'] == 5) -
  mean(d_wave2$ssm[d_wave2$treatment == 'No Contact'] == 5)


# can also view the results graphically
d_wave2 |>
  mutate(treatment = fct_relevel(treatment, 'No Contact')) |>
  group_by(treatment) |>
  count(ssm) |>
  mutate(pct = n / sum(n)) |>
  ggplot(mapping = aes(x = ssm, y = pct, fill = treatment)) +
  geom_col(position = 'dodge') +
  scale_fill_manual(
    values = c(
      'No Contact'                                     = 'grey55',
      'Recycling Script by Gay Canvasser'              = '#1b9e77',
      'Recycling Script by Straight Canvasser'         = '#7570b3',
      'Same-Sex Marriage Script by Straight Canvasser' = '#e7298a',
      'Same-Sex Marriage Script by Gay Canvasser'      = '#d95f02'
    )
  ) +
  scale_y_continuous(labels = scales::percent) +
  labs(
    title = 'Wave 2 support for same-sex marriage, by canvassing treatment',
    subtitle = 'No Contact (grey) is the baseline; colored bars are the canvassing scripts',
    x = 'Support for same-sex marriage',
    y = 'Percent of respondents',
    fill = 'Treatment'
  ) +
  theme_minimal(base_size = 12) +
  theme(legend.position = 'bottom')
