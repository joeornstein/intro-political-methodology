
# this function draws 57 reviews, assuming that the distribution
# of reviews for the second banana costume is exactly equal to the
# first
its_bananas <- function(k = 57){
  sample(1:5, size = k, replace = TRUE,
    prob = c(0.03, 0.02, 0.08, 0.16, 0.71))
}

its_bananas()

mean(its_bananas())

num_simulations <- 1e4
banana2_avg_reviews <- replicate(num_simulations, mean(its_bananas()))

hist(banana2_avg_reviews)

table(banana2_avg_reviews > 4.55)

mean(banana2_avg_reviews > 4.55)
