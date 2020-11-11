## Scratchpad for prediction slides
## Author: Joe Ornstein
## Date: November 10, 2020
## Version: 1.0

set.seed(42)
library(tidyverse)

# load and clean ANES
source('slides/10-Prediction/clean-anes.R', echo = TRUE)

# create rmse function
rmse <- function(truth, predictions){
  (truth - predictions)^2 %>% 
    mean %>% 
    sqrt
}

# kitchen sink lm
kitchen_sink_lm <- lm(ftjournal ~ age + race + female + educ + liveurban + ftbiden + fttrump +
                        marstat + child18 + pew_religimp + vote20jb + ideo5 + bmi +
                        facebook_user + twitter_user + instagram_user + reddit_user + 
                        youtube_user + snapchat_user + tiktok_user, data = data)

# simple, parsimonious lm
simple_lm <- lm(ftjournal ~ ftbiden + age + vote20jb, data = data)


rmse(truth = data$ftjournal, 
     predictions = predict(kitchen_sink_lm, data))

rmse(truth = data$ftjournal, 
     predictions = predict(simple_lm, data)) # worse, but we cheated

## Split into test and train ------------------
train <- data %>% 
  sample_frac(0.7)

test <- data %>% 
  anti_join(train, by = 'caseid')

# fit the models on train
kitchen_sink_lm <- lm(ftjournal ~ age + race + female + educ + liveurban + ftbiden + fttrump +
                        marstat + child18 + pew_religimp + vote20jb + ideo5 + bmi +
                        facebook_user + twitter_user + instagram_user + reddit_user + 
                        youtube_user + snapchat_user + tiktok_user, data = train)

simple_lm <- lm(ftjournal ~ ftbiden + fttrump + ideo5 + female, data = train)

summary(kitchen_sink_lm)

# test performance on test
rmse(truth = test$ftjournal, 
     predictions = predict(kitchen_sink_lm, test))

rmse(truth = test$ftjournal, 
     predictions = predict(simple_lm, test))

# Visualize predictions
tibble(truth = test$ftjournal,
       predictions = predict(simple_lm, test)) %>% 
ggplot() +
  geom_point(mapping = aes(x=predictions, y=truth),
             alpha = 0.2) +
  labs(x = 'Predicted Feeling Thermometer (Journalists)',
       y = 'Actual Feeling Thermometer (Journalists)') +
  theme_bw() +
  geom_abline(intercept=0, slope = 1, linetype = 'dashed')


## Cross-Validation --------------------------------------

library(caret)

# 10-fold cross-validation
train.control <- trainControl(method = "cv", number = 10)

# Train the kitchen sink model
kitchen_sink_model <- train(ftjournal ~ age + race + female + educ + liveurban + ftbiden + fttrump +
                 marstat + child18 + pew_religimp + vote20jb + ideo5 + bmi +
                 facebook_user + twitter_user + instagram_user + reddit_user + 
                   youtube_user + snapchat_user + tiktok_user, 
               data = data, method = "lm",
               trControl = train.control)

# Train the simple model
simple_model <- train(ftjournal ~ ftbiden + fttrump + ideo5 + female,
                      data = data, method = 'lm',
                      trControl = train.control)

# Summarize the results
print(kitchen_sink_model)
print(simple_model)


## LASSO ------------------------------------

# automate the variable selection
library(glmnet)

# pull the outcome vector
y <- train %>% 
  pull(ftjournal)

# create a matrix of predictor variables
x <- model.matrix(ftjournal ~ age + race + female + educ + liveurban + ftbiden + fttrump +
                     marstat + child18 + pew_religimp + vote20jb + ideo5 + bmi +
                     facebook_user + twitter_user + instagram_user + reddit_user + 
                     youtube_user + snapchat_user + tiktok_user, data = train)

x2 <- model.matrix(ftjournal ~ age + race + female + educ + liveurban + ftbiden + fttrump +
                    marstat + child18 + pew_religimp + vote20jb + ideo5 + bmi +
                    facebook_user + twitter_user + instagram_user + reddit_user + 
                    youtube_user + snapchat_user + tiktok_user, data = test)

lasso_model <- cv.glmnet(x, y)

lasso_model$lambda.min

lasso_best <- glmnet(x, y, lambda = lasso_model$lambda.min)

coef(lasso_best)

test$ftjournal_predicted_lasso <- predict(lasso_best, x2)

rmse(truth = test$ftjournal, predictions = predict(kitchen_sink_lm, test))
rmse(truth = test$ftjournal, predictions = predict(simple_lm, test))
rmse(truth = test$ftjournal, predictions = test$ftjournal_predicted_lasso)

# this is great and everything, but....your kids will freak. It's not for them.

## K-Nearest Neighbors -----------------------------------

library(kknn)

knn_model <- kknn(ftjournal ~ ftbiden + fttrump + age, 
                        train = train, 
                        test = test, 
                        k = 50)

rmse(truth = test$ftjournal, predictions = knn_model$fitted.values)

tibble(truth = test$ftjournal,
       prediction = knn_model$fitted.values) %>% 
  ggplot() + 
  geom_point(aes(x=prediction, y=truth),
             alpha = 0.2) +
  labs(title = 'KNN Predictions',
       x = 'Predicted Feeling Thermometer (Journalists)',
       y = 'Actual Feeling Thermometer (Journalists)') +
  geom_abline(intercept = 0, slope = 1, linetype = 'dashed') +
  theme_bw()

# plotly the kknn -----------------

library(plotly)

vizset <- train %>% 
  sample_n(500)

fttrump <- vizset$ftbiden
ftbiden <- vizset$fttrump
age <- vizset$age
ftjournal <- vizset$ftjournal

scatter3d <- plot_ly(x = fttrump, y = ftbiden, z = age, color = ~ftjournal, type = 'scatter3d', mode = 'markers',
                     marker = list(size = 3, symbol = 104)) %>% 
  layout(scene = list(
    xaxis = list(title = "Feeling Thermometer (Trump)"),
    yaxis = list(title = "Feeling Thermometer (Biden)"),
    zaxis = list(title = "Age")))

scatter3d


## Binary Dependent Variables ---------------------------------

## A Taste of Logit
lm_dream <- lm(pro_dream ~ ftbiden + fttrump + age + female + race + educ + liveurban,
               data = train)

logit_model <- glm(pro_dream ~ ftbiden + fttrump + age + female + race + educ + liveurban,
                   data = train, family = 'binomial')

## KNN
knn_model <- kknn(pro_dream ~ ftbiden + fttrump + age,
                  train = train,
                  test = test,
                  k = 51)

test <- test %>% 
  mutate(pro_dream_prediction_logit = predict(logit_model, test, type = 'response'),
         pro_dream_prediction_lm = predict(lm_dream, test),
         pro_dream_prediction_knn = knn_model$fitted.values)

ggplot(test) +
  geom_point(aes(x=pro_dream_prediction_lm,
                 y=pro_dream_prediction_logit)) +
  labs(x = 'Linear Model Prediction',
       y = 'Logistic Model Prediction') +
  theme_bw()

ggplot(test) +
  geom_jitter(aes(x=pro_dream_prediction_lm,
                 y=pro_dream),
             alpha = 0.2) +
  labs(x = 'Linear Model Prediction',
       y = 'Actual Opinion') +
  theme_bw() +
  geom_abline(intercept = 0, slope = 1, linetype = 'dashed') +
  geom_smooth(aes(x=pro_dream_prediction_logit,
                  y=pro_dream))


## Compare predictions ---------

# pct correct
mean(test$pro_dream == as.numeric(test$pro_dream_prediction_lm > 0.5)) * 100
mean(test$pro_dream == as.numeric(test$pro_dream_prediction_logit > 0.5)) * 100
mean(test$pro_dream == as.numeric(test$pro_dream_prediction_knn > 0.5)) * 100

# root brier score
rmse(test$pro_dream, test$pro_dream_prediction_lm)
rmse(test$pro_dream, test$pro_dream_prediction_logit)
rmse(test$pro_dream, test$pro_dream_prediction_knn)


## Visualize ------------

library(plotly)

vizset <- train %>% 
  sample_n(500)

fttrump <- vizset$ftbiden
ftbiden <- vizset$fttrump
age <- vizset$age
pro_dream <- vizset$pro_dream

scatter3d <- plot_ly(x = fttrump, y = ftbiden, z = age, color = ~pro_dream, type = 'scatter3d', mode = 'markers',
                     marker = list(size = 3, symbol = 104)) %>% 
  layout(scene = list(
    xaxis = list(title = "Feeling Thermometer (Trump)"),
    yaxis = list(title = "Feeling Thermometer (Biden)"),
    zaxis = list(title = "Age")))

scatter3d
