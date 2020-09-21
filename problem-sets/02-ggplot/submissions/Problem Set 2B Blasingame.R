#Elise Blasingame Problem Set 2 - FIGURE B
#September 7, 2020
#Data was already loaded from previous problem set.
#Load tidyverse, because now we know that's all that is needed!

library (tidyverse)

load('data/anes_pilot_2019.Rdata')

#Start process for second image (violin plot)
#Take a look at the data to see what we are working with:
table(data$vote20dem)
table(data$ftmuslim)

#Recode the name of the Muslim Thermometer Data
data$Muslim_Thermometer <- data$ftmuslim

#Filer out the inappropriate responses.
figb_data <- filter(data, Muslim_Thermometer>= 0 & Muslim_Thermometer <= 100)

#Label the political parties.
figb_data$vote20dem[figb_data$vote20dem == 1] <- "Democrat"
figb_data$vote20dem[figb_data$vote20dem == 2] <- "Republican"
figb_data$vote20dem[figb_data$vote20dem == 3] <- "Neither"
figb_data$vote20dem[figb_data$vote20dem == -7] <- NA

#Recode the party data:
vote20dem <- data$vote20dem

table(vote20dem)

# Filter out the missing values (NA)
figb_data <- filter(figb_data, !is.na(vote20dem))

# Convert the variable muslim thermometer from a numeric to a factor variable
data$Muslim_Thermometer <- as.factor(data$Muslim_Thermometer)

#Load RColorBrewer themes:
library(RColorBrewer)

#Build the violin plot:
FigB <- ggplot(data = figb_data) +
  geom_violin(mapping = aes(x = Muslim_Thermometer, y = vote20dem, color=vote20dem))+
  xlab('Feeling Thermometer (Muslim)') +
  ylab('Party') +
  scale_color_manual(values=c("#4174C4", "#999999", "#B33317"))+ theme_minimal()

#Run the violin plot:
FigB

#Save the violin plot:
ggsave(filename = 'FigureB.png', plot = FigB, 
       height = 5, width = 8)
