library(tidyverse)
library(dplyr)
library(ggplot2)
library(knitr)
library(janitor)
library(readxl)
wh2020data <- read_excel("wh2020data.xlsx")
View(wh2020data)
library (dplyr)
df2 <- wh2020data %>% slice(-c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 16, 17, 22, 23, 24, 25, 26 ,27, 28, 29, 30, 31,40, 41, 42, 43, 44 ,45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57 ,58, 59, 60, 61, 62 ,63, 64, 65, 66 ,67 ,68, 69, 70, 71, 72, 73, 74))
View(df2)


str(df2)
df2$Group [df2$Group== 1] <- "Non-College"
df2$Group [df2$Group== 2] <- "College"
df2$Group [df2$Group== 3] <- "White Non-College"
df2$Group [df2$Group== 4] <- "White College"
df2$Group [df2$Group== 5] <- "Voters of Color Non-College"
df2$Group [df2$Group== 6] <- "Voters of Color College"
df2$Group [df2$Group== 7] <- "White College Men"
df2$Group [df2$Group== 8] <- "White Non-College Men"
df2$Group [df2$Group== 9] <- "White College Women"
df2$Group [df2$Group== 10] <- "White Non-College Women"
df2$Group [df2$Group== 11] <- "Voters of Color Non-College Men"
df2$Group [df2$Group== 12] <- "Voter of Color Non-College Women"
df2$Group [df2$Group== 13] <- "Voters of Color College Men"
df2$Group [df2$Group== 14] <- "Voters of Color College Women"

library(dplyr)
library(tidyr)
library(ggplot2)


par("mar")
par(mar= c(1, 1, 1, 1))

barplot(df2,legend=T,beside=T,main='Vote by Education')
plot(df2,main='Vote by Education Level')


df2 <- read_xlsx(file='df2',sep=',',header=T)
df2 <- table(df2$Group,df2$`Pres
2020
Dem`)
mosaicplot(df2)
help(mosaicplot)

mosaicplot(df2,main="Vote by Education",xlab="Education",ylab="Party")
mosaicplot(df2,dir=c("v","h"))



barplot(t(df2), legend=TRUE, beside=FALSE, 
        main='Vote by Education'
        
barplot(df2, legend=TRUE, beside=TRUE,
        main='Vote by Education (bar plot)')
data <- matrix(c())

subdata <- df2 [df2$Group== 1,2, c("Pres_2020_Dem","Pres_2020_Rep", "Pres_2020_Oth")]

p<-ggplot(data=df2_plot1, aes(x=[,1], y=[,2])) +
  geom_bar(stat="identity", fill="steelblue")+
  theme_minimal()
p

dat <- as.data.frame(matrix(1:12, ncol = 3))
colnames(dat) <- LETTERS[1:4]
dat

rownames(df2_plot1) <- c('Non-College', 'College')
colnames(df2_plot1) <- c('Dem2020', 'Rep2020', 'Oth2020', 'Dem2016', 'Rep2016', 'Oth2016')
df2_plot1

barplot(df2_plot1, legend=True, beside=True, main='Vote by Education')

barplot(y, mainlab= "Vote by Education", xlab= "Party Voted For", ylab= "Percentage",
        names.arg= x)

fill=c('Non-College', 'College')
x=c('Dem2020', 'Rep2020', 'Oth2020', 'Dem2016', 'Rep2016', 'Oth2016')
y=
barplot(y, mainlab= "Vote by Education", xlab= "Party Voted For", ylab= "Percentage",
        names.arg= x)

df2_plot1%>%
  count(x)
  mutate(perc=n/nrow(df2_plot1))-> educ
  
ggplot(df2_plot1, aes(x=party, fill=educ)) +geom_bar(stat="identity")
  
ggplot()  

two_way <- table(df2_plot1$Dem2020, df2_plot1$Rep2020)
barplot(two_way)


df2.1 <- df2[c(1:2), c(2:7)]
rownames(df2.1) <- c('Non-College', 'College')


df2.2 <- df2[c(3:6), c(2:7)]
rownames(df2.2) <- c('White Non-College', 'White College', 'Voters of Color Non-College', 'Voters of Color College')


df2.3 <- df2[c(7:14), c(2:7)]
rownames(df2.3) <- c('White College Men', 'White Non-College Men', 'White College Women', 'White Non-College Women', 'Voters of Color Non-College Men', 'Voters of Color Non-College Women','Voters of Color College Men', 'Voters of Color College Women' )



