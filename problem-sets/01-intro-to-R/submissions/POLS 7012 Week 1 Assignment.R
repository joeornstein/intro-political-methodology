R version 4.0.2 (2020-06-22) -- "Taking Off Again"
Copyright (C) 2020 The R Foundation for Statistical Computing
Platform: x86_64-apple-darwin17.0 (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

Natural language support but running in an English locale

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

[Workspace loaded from ~/data:/POLS 7012 Problem Set 1/.RData]

> #Author: Matthew Wallack
  > #Assignment: POLS 7012 R Porlbmes, Week 1
  > 
  > #Number of Rows in Data
  > nrow(data)
[1] 3165
> 
  > #Number of Columns (i.e. variables) in Data
  > ncol(data)
[1] 900
> 
  > #Create Variable called AGe
  > #Create Variable called "Age"
  > age ->2020 - data$birthyr
Error in 2020 - data$birthyr <- age : 
  target of assignment expands to non-language object
> age <- 2020 - data$birthyr
> 
  > #Median Age
  > median(age)
[1] 56
> 
  > #Histogram of Age
  > hist(age)
> 
  > #Create Table for Variable vote16
  > table(vote16)
vote16<-data$vote16
vote16
-1    1    2    3 
603 1172 1110  280 : 
> 
  > #Remove Non Response from variable vote16
  > data$vote16[data$vote16 == -1]
[1] -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
[22] -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
[43] -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
[64] -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
[85] -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
[106] -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
[127] -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
[148] -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
[169] -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
[190] -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
[211] -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
[232] -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
[253] -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
[274] -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
[295] -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
[316] -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
[337] -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
[358] -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
[379] -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
[400] -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
[421] -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
[442] -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
[463] -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
[484] -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
[505] -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
[526] -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
[547] -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
[568] -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
[589] -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1

#Create Table for vote16 Without -1 Value
vote16<-data$vote16[data$vote16 == -1] <- NA
> table(vote16)
< table of extent 0 >
  #When I remove the NA (-1) value, R shows "table of etent 0"

  #Create variable liveurban  
>liveurban<-data$liveurban

#Create table for variable liveurban
<table(liveurban)
liveurban
1    2    3    4 
643  589 1117  816 
#Respondents are most likely to live in suburban areas, with cities as he second likeliest option

#Create variable vote20jb
vote20jb<-data$vote20jb

#Create Table for variable liveurban and vote20jb
table(liveurban, vote20jb)

vote20jb
liveurban   1   2   3   4
1 314 204  64  61
2 259 221  58  51
3 465 462 107  83
4 235 401  92  88

#Rural respondents are most likelt to vote for Donald Trump. Urban respondents are most likely to vote for Joe Biden.

#Find and summarize three variables
expcolldebt<-data$expcolldebt
ftchina<-data$ftchina
ftnato<-data$ftnato

#Table for expcolldebt
expcolldebt
-7   -1    1    2 
3 1586  252 1324 

#Most respondents were not asked about student debt. Of those that were,the vast majority c

#Find median for ftchina
median(ftchina)
[1] 40
#Suggests public opinion of Chin a is broadly negative)

#Find median for ftnato
median(ftnato)
[1] 55
#Suggests that public opinion of NATO is positive, but not overwhelmingly so.
