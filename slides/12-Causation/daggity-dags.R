# Plot dags with ggdag
# Author: Joe Ornstein (jornstein@uga.edu)
# Date: November 5, 2020
# Version: 1.0

library(tidyverse)
library(ggdag)

dagify(y ~ x) %>% 
  ggdag() +
  theme_dag()
