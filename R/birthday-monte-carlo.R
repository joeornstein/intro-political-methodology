
generate_birthdays <- function(n){
  sample(1:365, size = n, replace = TRUE)
}

birthday_sequence <- generate_birthdays(24)
birthday_sequence

sort(birthday_sequence)

diff(sort(birthday_sequence))

diff(sort(birthday_sequence)) <= 1

any(diff(sort(birthday_sequence)) <= 1)


any_within_one <- function(n){
  birthdays <- generate_birthdays(n)
  any(diff(sort(birthdays)) <= 1)
}

any_within_one(24)

# let's try 10,000 simulations
num_simulations <- 1e4
sims <- replicate(num_simulations, any_within_one(20))

table(sims)
