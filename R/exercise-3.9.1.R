
# in this exercise we're going to compare the gay marriage study data
# with the CCAP data, and show that they look....suspiciously identical

d <- read.csv('MEASUREMENT/gayreshaped.csv')
ccap <- read.csv('MEASUREMENT/ccap2012.csv')

# what is the correlation between wave 1 and wave 2 feeling thermometers
# among the control group in study 1?
cor(d$therm1[d$study == 1 & d$treatment == 'No Contact'], d$therm2[d$study == 1 & d$treatment == 'No Contact'], use = 'pairwise.complete.obs')

# another option
control_group_study_1 <- d[d$treatment == 'No Contact' & d$study==1,]
cor(control_group_study_1$therm1, control_group_study_1$therm2, use = 'pairwise.complete.obs')

plot(control_group_study_1$therm1, control_group_study_1$therm2, xlab = 'Wave 1 Feeling Thermometer', ylab = 'Wave 2 Feeling Thermometer')

# what percentage of "respondents" don't change their minds from Wave 1 to Wave 2?
control_group_study_1$same_number <- control_group_study_1$therm1 == control_group_study_1$therm2
prop.table(table(control_group_study_1$same_number))
# 78% of respondents gave the same number in Waves 1 and 2

# do people group their responses around 5's and 10's? and are they more likely to give the same answer if they gave a 5 or 10 number?
control_group_study_1$even_number <- control_group_study_1$therm1 %% 5 == 0
# note: the %% operator is the "modulus" operator; divide by 5 and take the remainder.
mean(control_group_study_1$even_number) * 100
# only 43% of respondents gave a number ending in 5 or 0.

table('Number Ends in 0 or 5' = control_group_study_1$even_number, 'Same Number in Waves 1 and 2' = control_group_study_1$same_number)
prop.table(table('Number Ends in 0 or 5' = control_group_study_1$even_number, 'Same Number in Waves 1 and 2' = control_group_study_1$same_number), margin = 1)


# let's compare all this to a benchmark dataset where we are pretty confident the answers are coming from real humans

# load ANES 2024 time series dataset
anes <- read.csv('ANES/anes_timeseries_2024_csv_20260519.csv')


# feeling thermometer about Donald Trump, pre-election and post-election wave
anes$pre_trump_ft <- anes$V241157
anes$post_trump_ft <- anes$V242126

# drop missing values; don't do this at home, kids
anes <- anes[anes$post_trump_ft <= 100 & anes$post_trump_ft >= 0,]
anes <- anes[anes$pre_trump_ft <= 100 & anes$pre_trump_ft >= 0,]

hist(anes$pre_trump_ft)
hist(anes$post_trump_ft)

cor(anes$pre_trump_ft, anes$post_trump_ft)

plot(anes$pre_trump_ft, anes$post_trump_ft)

# THIS is what real humans look like. It's infuriating to trying to work with them.

anes$even_number <- anes$pre_trump_ft %% 5 == 0
mean(anes$even_number) # 98% gave a number ending in 0 or 5

anes$same_number <- anes$pre_trump_ft == anes$post_trump_ft
mean(anes$same_number) # only 53% gave the same number across waves

prop.table(table('Number Ends in 0 or 5' = anes$even_number, 'Same Number in Waves 1 and 2' = anes$same_number), margin = 1)
# and they were *way* more likely to give the same number if their first number was a multiple of 5.