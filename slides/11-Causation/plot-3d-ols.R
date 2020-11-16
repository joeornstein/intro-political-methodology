## Function to plot a 3D "plane of best fit"
## Author: Joe Ornstein
## Date: November 16, 2020
## Version: 1.0

library(tidyverse)
library(plotly)

plane_of_best_fit <- function(X,Y,Z,
                              xlab = 'X',
                              ylab = 'Z',
                              zlab = 'Y'){
  
  # estimate model
  lm_fit <- lm(Y~X+Z, data=tibble(X,Y,Z))
  
  # predict plane of best fit
  x <- round(min(X)):round(max(X))
  z <- round(min(Z)):round(max(Z))
  
  yhat <- function(x,z){
    coef(lm_fit)[1] + coef(lm_fit)[2] * x + coef(lm_fit)[3] * z
  }
  
  plane_of_best_fit <- outer(x,z,yhat)
  colnames(plane_of_best_fit) <- z
  rownames(plane_of_best_fit) <- x
  
  # return plot
  p <- plot_ly(z = plane_of_best_fit, type = "surface") %>% 
    layout(scene = list(
      xaxis = list(title = xlab),
      yaxis = list(title = ylab),
      zaxis = list(title = zlab))) %>% 
    add_trace(x = Z, y = X, z = Y, type = 'scatter3d', mode = 'markers',
              marker = list(size = 5, color = "black", symbol = 104))
  
  p
}

