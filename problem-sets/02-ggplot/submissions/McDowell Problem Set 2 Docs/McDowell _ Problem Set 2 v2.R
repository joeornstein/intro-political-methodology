# Problem Set 2

# install tidyverse
install.packages("tidyverse")

# Use "Library" to load tidyverse
library(tidyverse)

# Load (read) dataset
library(readr)
Jeff_Francoeur_Stats <- read_csv("Jeff Francoeur Stats.csv")
table(Jeff_Francoeur_Stats$Year)

# Change digit settings
options(digits = "10")

# Create "atl2005" subset
atl2005 = subset(Jeff_Francoeur_Stats, Year == "2005")

# Frenchy's 2005 SLG %
atl2005$SLG

# Clean up overlap year data
stats_2010 = subset(Jeff_Francoeur_Stats, Year == "2010")
mean(stats_2010$BA)
avg2010BA <- "mean(stats_2010$BA)"

# Create ggplot point graph for Frenchy career SLG
careerSLGfig2 <- ggplot(data = Jeff_Francoeur_Stats) + 
  geom_line(aes(Year, SLG)) + ggtitle("Career Slugging Percentage") + 
  geom_smooth(aes(Year, SLG), method = "lm")
careerSLGfig2

# Create ggplot point graph for Frenchy only ATL BA
atlcareer <- subset(Jeff_Francoeur_Stats, Tm == "ATL")
atlBAfig <- ggplot(data = atlcareer) + 
  geom_line(aes(Year, BA)) + ggtitle("Batting Average in Atlanta") +
  geom_smooth(aes(Year, BA), method = "lm")
atlBAfig

# Create ggplot point graph for Frenchy career BA
careerBAfig2 <- ggplot(data = Jeff_Francoeur_Stats) + 
  geom_line(aes(Year, BA)) + 
  ggtitle("Career Batting Average Percentage") +
  geom_smooth(aes(Year, BA), method = "lm")
careerBAfig2

# Create ggplot point graph for Frenchy ATL SLG
atlSLGfig <- ggplot(data = atlcareer) + 
  geom_line(aes(Year, SLG)) + ggtitle("Slugging Percentage in Atlanta") +
  geom_smooth(aes(Year, SLG), method = "lm")
atlSLGfig

# Create combined ggplot of career + ATL BA
combinedBA <- ggplot() + 
  geom_line(data=Jeff_Francoeur_Stats,aes(Year, BA), color='blue') + 
  geom_line(data=atlcareer,aes(Year, BA), color='red') + 
  ggtitle("Combined Career/Atlanta Batting Average") +
combinedBA
  
# Create combined ggplot of career + ATL SLG
combinedSLG <- ggplot() + 
  geom_line(data=Jeff_Francoeur_Stats,aes(Year, SLG), color='blue') + 
  geom_line(data=atlcareer,aes(Year, SLG), color='red') + 
  ggtitle("Combined Career/Atlanta Slugging Percentage")
combinedSLG

# Make a grid of Frenchy stat plots
install.packages('cowplot')
library(cowplot)
cowplot::plot_grid(PAvsSO, careerBAfig2, combinedBA, careerSLGfig2, combinedSLG)

#Stats for each league
NatlStats <- subset(Jeff_Francoeur_Stats, Lg == "NL")


AmeriStats <- subset(Jeff_Francoeur_Stats, Lg == "AL")

# Strikeouts compared to Plate appearances, Hits, HR
PAvsSO <- ggplot() + 
  geom_line(data=Jeff_Francoeur_Stats,aes(Year, PA), color="blue") + 
  geom_line(data=Jeff_Francoeur_Stats,aes(Year, SO), color='red') + 
  geom_line(data = Jeff_Francoeur_Stats, aes(Year, H), color = "purple") +
  geom_line(data = Jeff_Francoeur_Stats, aes(Year, HR), color = "orange") +
  ggtitle("Career Plate Appearances, Hits,Strikeouts and Homeruns")
PAvsSO






