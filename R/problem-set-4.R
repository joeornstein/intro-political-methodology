
# load the dataset
d <- read.csv('MEASUREMENT/vignettes.csv')


# average differences in self-efficacy variable
mean(d$self[d$china==1])
mean(d$self[d$china==0])

# plot the raw self-efficacy distribution
library(tidyverse)

china_labels <- c(`0` = "Mexico", `1` = "China")

ggplot(data = d, mapping = aes(x = self, fill = factor(china))) +
  geom_histogram(binwidth = 1, color = "white", show.legend = FALSE) +
  facet_wrap(~china, labeller = as_labeller(china_labels)) +
  scale_fill_manual(values = c("0" = "#4C72B0", "1" = "#DD8452")) +
  labs(
    title = "Distribution of Self-Efficacy",
    subtitle = "Compared across China and non-China respondents",
    x = "Self-Efficacy",
    y = "Count"
  ) +
  theme_minimal(base_size = 13) +
  theme(
    plot.title = element_text(face = "bold"),
    strip.text = element_text(face = "bold"),
    panel.grid.minor = element_blank()
  )


# problem 4. keep only the respondents who ranked alison > jane > moses,
# and create a new variable based on where they ranked themselves on that spectrum

d_paying_attention <- d[d$alison >= d$jane & d$jane >= d$moses,]

d_paying_attention$relative_efficacy <- NA
# 1 if lower than moses
d_paying_attention$relative_efficacy[d_paying_attention$self < d_paying_attention$moses] <- 1
# 2 if less than jane
d_paying_attention$relative_efficacy[d_paying_attention$self >= d_paying_attention$moses & d_paying_attention$self < d_paying_attention$jane] <- 2
# 3 if less than alison
d_paying_attention$relative_efficacy[d_paying_attention$self >= d_paying_attention$jane & d_paying_attention$self < d_paying_attention$alison] <- 3
# 4 if greater or equal to alison
d_paying_attention$relative_efficacy[d_paying_attention$self >= d_paying_attention$alison] <- 4



ggplot(data = d_paying_attention, mapping = aes(x = relative_efficacy, fill = factor(china))) +
  geom_histogram(binwidth = 1, color = "white", show.legend = FALSE) +
  facet_wrap(~china, labeller = as_labeller(china_labels)) +
  scale_fill_manual(values = c("0" = "#4C72B0", "1" = "#DD8452")) +
  scale_x_continuous(breaks = 1:4, labels = c("< Moses", "< Jane", "< Alison", "≥ Alison")) +
  labs(
    title = "Relative Self-Efficacy",
    subtitle = "Where respondents rank themselves against Moses, Jane, and Alison",
    x = "Relative Ranking",
    y = "Count"
  ) +
  theme_minimal(base_size = 13) +
  theme(
    plot.title = element_text(face = "bold"),
    strip.text = element_text(face = "bold"),
    panel.grid.minor = element_blank(),
    axis.text.x = element_text(angle = 20, hjust = 1)
  )




# problem 5: do the same conclusions hold regardless of age group?

d_paying_attention$older_than_40 <- ifelse(d_paying_attention$age >=40, "40 or Older", "Younger Than 40")

ggplot(data = d_paying_attention, mapping = aes(x = relative_efficacy, fill = factor(china))) +
  geom_histogram(binwidth = 1, color = "white", show.legend = FALSE) +
  facet_grid(older_than_40~china) +
  scale_fill_manual(values = c("0" = "#4C72B0", "1" = "#DD8452")) +
  scale_x_continuous(breaks = 1:4, labels = c("< Moses", "< Jane", "< Alison", "≥ Alison")) +
  labs(
    title = "Relative Self-Efficacy",
    subtitle = "Where respondents rank themselves against Moses, Jane, and Alison",
    x = "Relative Ranking",
    y = "Count"
  ) +
  theme_minimal(base_size = 13) +
  theme(
    plot.title = element_text(face = "bold"),
    strip.text = element_text(face = "bold"),
    panel.grid.minor = element_blank(),
    axis.text.x = element_text(angle = 20, hjust = 1)
  )


d_paying_attention |> 
  group_by(china, older_than_40) |> 
  summarize(mean_relative_efficacy = mean(relative_efficacy))





# bonus fun: self-efficacy by age smooth plots

ggplot(data = d, mapping = aes(x = age, y=self)) +
  geom_smooth() +
  facet_wrap(~china)

ggplot(data = d_paying_attention, mapping = aes(x = age, y=relative_efficacy)) +
  geom_smooth() +
  facet_wrap(~china)





# bonus bonus fun: correlation between age and relative efficacy
cor(d_paying_attention$age, d_paying_attention$relative_efficacy)


# here's what's going on under the hood

# compute z-scores for both variables
d_paying_attention$age_z <- (d_paying_attention$age - mean(d_paying_attention$age)) / sd(d_paying_attention$age)
d_paying_attention$relative_efficacy_z <- (d_paying_attention$relative_efficacy - mean(d_paying_attention$relative_efficacy)) / sd(d_paying_attention$relative_efficacy)

plot(d_paying_attention$age_z, d_paying_attention$relative_efficacy_z)

# correlation is the average product of z-scores (divided by n-1 instead of n, but it doesn't make a big difference for a dataset this size)
sum(d_paying_attention$age_z * d_paying_attention$relative_efficacy_z) / (nrow(d_paying_attention) - 1)
