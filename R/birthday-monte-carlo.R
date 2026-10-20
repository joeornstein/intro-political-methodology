
generate_birthdays <- function(k){
  sample(1:365, size = k, replace = TRUE)
}

birthday_sequence <- generate_birthdays(25)
birthday_sequence

sort(birthday_sequence)

diff(sort(birthday_sequence))

diff(sort(birthday_sequence)) <= 1

any(diff(sort(birthday_sequence)) <= 1)


any_within_one <- function(k){
  birthdays <- generate_birthdays(k)
  any(diff(sort(birthdays)) <= 1)
}

any_within_one(25)

# let's try 10,000 simulations
num_simulations <- 1e4
sims <- replicate(num_simulations, any_within_one(25))

table(sims)




sample(365, 25)

choose(365,25)
