

roll_dice <- function(num_dice = 2, num_sides = 6){
  
  # roll dice
  dice <- sample(1:num_sides, 
                 size = num_dice,
                 replace = TRUE)
  
  # get the total
  total <- sum(dice)
  
  # return the total
  return(total)
}


roll_dice()

rolls <- replicate(1e4, roll_dice())

hist(rolls)

mean(rolls)
sd(rolls)

# compare to empirical result ---------------

library(here)
library(readxl)

avery_dice <- read_xlsx(here('data/misc/avery-dice.xlsx'))

test_statistic <- mean(avery_dice$roll)
num_rolls <- nrow(avery_dice)

# generate a sampling distribution ------------

replicate(num_rolls, roll_dice())

mean(replicate(num_rolls, roll_dice()))

avg_58_dice <- function(){
  mean(replicate(num_rolls, roll_dice()))
}

avg_58_dice()

sampling_distribution <- replicate(1e5, avg_58_dice())

hist(sampling_distribution)
test_statistic
min(sampling_distribution)

plot(density(sampling_distribution))

# expected value

# standard error

# central limit theorem