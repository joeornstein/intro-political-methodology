## Evaluate predictions from student submissions
## Author: Joe Ornstein
## Date: December 1, 2020
## Version: 1.0


library(tidyverse)

pn <- 'problem-sets/08-prediction/'

# ------------------ Load labeled test data -------------------------

labeled_test <- pn %>% 
  paste0('data/Labeled-CCES-Test-POLS-7012.csv') %>% 
  read_csv %>% 
  mutate(id = 1:n())

# function to compute classification accuracy
classification_accuracy <- function(truth, predicted){
  predicted <- ifelse(predicted > 0.5, 1, 0)
  sum(truth == predicted) / length(truth) * 100
}


# ----------------- Loop through submissions and compute prediction accuracy ----------

submissions <- paste0(pn, 'submissions/') %>% 
  list.files

results <- tibble(last_name = submissions %>% str_replace_all('.csv', ''),
                  classification_accuracy = NA)

for(fn in submissions){
  
  last_name <- str_replace(fn, '.csv', '')
  
  data <- paste0(pn, 'submissions/', fn) %>% 
    read_csv %>% 
    mutate(id = 1:n()) %>%
    select(id, p_democrat) %>% 
    left_join(labeled_test)

  # skip if the csv doesn't have the correct number of rows
  if(nrow(data) != nrow(labeled_test)) next
    
  ggplot(data) +
    geom_point(aes(x=p_democrat, y = democratic2016)) + 
    geom_smooth(aes(x=p_democrat, y = democratic2016)) + 
    geom_abline(intercept = 0, slope = 1, linetype = 'dashed') + 
    labs(x = 'Predicted Probability Democrat',
         y = 'Voted Democrat') 
  
  # save calibration plot
  ggsave(paste0(pn, 'plots/', last_name, '.png'))
  
  # compute classification accuracy
  results$classification_accuracy[results$last_name == last_name]<- 
    classification_accuracy(truth = data$democratic2016,
                          predicted = data$p_democrat)

}