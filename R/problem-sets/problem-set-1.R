
kenya <- read.csv('INTRO/Kenya.csv')
sweden <- read.csv('INTRO/Sweden.csv')
world <- read.csv('INTRO/World.csv')

## Problem 1: Crude Birth Rates ----------------------------------------

# total person-years
kenya$py <- kenya$py.women + kenya$py.men

kenya_py_total_1950_1955 <- sum(kenya$py[kenya$period == '1950-1955'])
kenya_births_total_1950_1955 <- sum(kenya$births[kenya$period == '1950-1955'])

kenya_cbr_1950_1955 <- kenya_births_total_1950_1955 / kenya_py_total_1950_1955


# it would be super nice to have a function here so that we can replicate this computation with the other datasets and periods

calculate_cbr <- function(dataset, period){

  # total person-years column
  dataset$py <- dataset$py.women + dataset$py.men

  # compute total person-years and births in the given period
  py_total_period <- sum(dataset$py[dataset$period == period])
  births_total_period <- sum(dataset$births[dataset$period == period])

  # return crude birth rate
  return(births_total_period / py_total_period)

}

calculate_cbr(kenya, '1950-1955')
calculate_cbr(kenya, '2005-2010')

calculate_cbr(sweden, '1950-1955')
calculate_cbr(sweden, '2005-2010')

calculate_cbr(world, '1950-1955')
calculate_cbr(world, '2005-2010')


## Problem 2: Age-Specific Fertility Rates ----------------------------------

asfr <- function(dataset, period){

  # just keep the women 15-50 in the period of interest
  dataset <- dataset[dataset$period == period & dataset$age %in% c('15-19','20-24', '25-29', '30-34', '35-39', '40-44', '45-49') ,]

  asfr <- dataset$births / dataset$py.women
  names(asfr) <- dataset$age

  return(asfr)

}

asfr(dataset = kenya, period = '1950-1955')
asfr(dataset = kenya, period = '2005-2010')

asfr(dataset = sweden, period = '1950-1955')
asfr(dataset = sweden, period = '2005-2010')

# that's interesting. Sweden birth rates declined in every age group *except* women in their 30s. That makes sense!

asfr(dataset = world, period = '1950-1955')
asfr(dataset = world, period = '2005-2010')


## Problem 3: Total Fertility Rate ------------------------------------

tfr <- function(dataset, period){

  asfr <- asfr(dataset, period)

  # total fertility rate is each asfr times 5, added together
  sum(asfr * 5)

}

tfr(kenya, '1950-1955')
tfr(kenya, '2005-2010')

tfr(sweden, '1950-1955')
tfr(sweden, '2005-2010')

tfr(world, '1950-1955')
tfr(world, '2005-2010')



## Problem 4: Crude Death Rate ------------------------------------

calculate_cdr <- function(dataset, period){

  # total person-years column
  dataset$py <- dataset$py.women + dataset$py.men

  # compute total person-years and deaths in the given period
  py_total_period <- sum(dataset$py[dataset$period == period])
  deaths_total_period <- sum(dataset$deaths[dataset$period == period])

  # return crude death rate
  return(deaths_total_period / py_total_period)

}

calculate_cdr(kenya, '1950-1955')
calculate_cdr(kenya, '2005-2010')

calculate_cdr(sweden, '1950-1955')
calculate_cdr(sweden, '2005-2010')

# interesting note here. crude death rates appear to be equal in Kenya and Sweden in the 2005-2010 period!

calculate_cdr(world, '1950-1955')
calculate_cdr(world, '2005-2010')

## Problem 5: Age-Specific Death Rate ----------------------------

asdr <- function(dataset, period){

  # just keep the period of interest
  dataset <- dataset[dataset$period == period,]

  asdr <- dataset$deaths / (dataset$py.women + dataset$py.men)
  names(asdr) <- dataset$age

  return(asdr)

}

asdr(kenya, '1950-1955')
asdr(kenya, '2005-2010')

asdr(sweden, '1950-1955')
asdr(sweden, '2005-2010')

asdr(world, '1950-1955')
asdr(world, '2005-2010')

## Problem 6: Counterfactual CDR ------------------------

# what would Kenya's Crude Death Rate be if it had the age-distribution of Sweden?
asdr(kenya, '2005-2010')

sweden$py <- sweden$py.men + sweden$py.women
sweden_population <- sum(sweden$py[sweden$period=='2005-2010'])
sweden_period <- sweden[sweden$period == '2005-2010',]
# the proportion column will now tell me the percent of Swedes in each age bucket during the 2005-2010 period
sweden_period$proportion <- sweden_period$py / sweden_population

# counterfactual CDR is sum(asdr x sweden's population proportions)
sum(asdr(kenya, '2005-2010') * sweden_period$proportion)
