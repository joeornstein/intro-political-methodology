library(ggplot2) 
library(GGally) 
library(rgdal)
library(usmap) 
library(magick) 
library(tidyverse)
library(readr)

all50 <- read.csv('~/Documents/R/all50_2.csv')

#1

p.w1 <- plot_usmap(data=all50, values='w1', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week One') + 
  theme(legend.position = "right")

p.w1

ggsave(filename = "1w.png", plot=p.w1,width=4,height=4,units="in",scale=1)

w1 <- image_read("1w.png")


#2

p.w2 <- plot_usmap(data=all50, values='w2', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Two') + 
  theme(legend.position = "right")

p.w2

ggsave(filename = "2w.png", plot=p.w2,width=4,height=4,units="in",scale=1)

w2 <- image_read("2w.png")


#3

p.w3 <- plot_usmap(data=all50, values='w3', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Three') + 
  theme(legend.position = "right")

p.w3

ggsave(filename = "3w.png", plot=p.w3,width=4,height=4,units="in",scale=1)

w3 <- image_read("3w.png")


#4

p.w4 <- plot_usmap(data=all50, values='w4', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Four') + 
  theme(legend.position = "right")

p.w4

ggsave(filename = "4w.png", plot=p.w4,width=4,height=4,units="in",scale=1)

w4 <- image_read("4w.png")


#5

p.w5 <- plot_usmap(data=all50, values='w5', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Five') + 
  theme(legend.position = "right")

p.w5

ggsave(filename = "5w.png", plot=p.w5,width=4,height=4,units="in",scale=1)

w5 <- image_read("5w.png")


#6

p.w6 <- plot_usmap(data=all50, values='w6', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Six') + 
  theme(legend.position = "right")

p.w6

ggsave(filename = "6w.png", plot=p.w6,width=4,height=4,units="in",scale=1)

w6 <- image_read("6w.png")


#7

p.w7 <- plot_usmap(data=all50, values='w7', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Seven') + 
  theme(legend.position = "right")

p.w7

ggsave(filename = "7w.png", plot=p.w7,width=4,height=4,units="in",scale=1)

w7 <- image_read("7w.png")


#8

p.w8 <- plot_usmap(data=all50, values='w8', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Eight') + 
  theme(legend.position = "right")

p.w8

ggsave(filename = "8w.png", plot=p.w8,width=4,height=4,units="in",scale=1)

w8 <- image_read("8w.png")


#9

p.w9 <- plot_usmap(data=all50, values='w9', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Nine') + 
  theme(legend.position = "right")

p.w9

ggsave(filename = "9w.png", plot=p.w9,width=4,height=4,units="in",scale=1)

w9 <- image_read("9w.png")


#10

p.w10 <- plot_usmap(data=all50, values='w10', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Ten') + 
  theme(legend.position = "right")

p.w10

ggsave(filename = "10w.png", plot=p.w10,width=4,height=4,units="in",scale=1)

w10 <- image_read("10w.png")


#11

p.w11 <- plot_usmap(data=all50, values='w11', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Elevn') + 
  theme(legend.position = "right")

p.w11

ggsave(filename = "11w.png", plot=p.w11,width=4,height=4,units="in",scale=1)

w11 <- image_read("11w.png")


#12

p.w12 <- plot_usmap(data=all50, values='w12', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Twelve') + 
  theme(legend.position = "right")

p.w12

w12 <- image_read("12w.png")

#13

p.w13 <- plot_usmap(data=all50, values='w13', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Thirteen') + 
  theme(legend.position = "right")

p.w13

ggsave(filename = "13w.png", plot=p.w13,width=4,height=4,units="in",scale=1)

w13 <- image_read("13w.png")

ggsave(filename = "12w.png", plot=p.w12,width=4,height=4,units="in",scale=1)

#14

p.w14 <- plot_usmap(data=all50, values='w14', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Fourteen') + 
  theme(legend.position = "right")

p.w14

ggsave(filename = "14w.png", plot=p.w14,width=4,height=4,units="in",scale=1)

w14 <- image_read("14w.png")

#15

p.w15 <- plot_usmap(data=all50, values='w15', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Fifteen') + 
  theme(legend.position = "right")

p.w15

ggsave(filename = "15w.png", plot=p.w15,width=4,height=4,units="in",scale=1)

w15 <- image_read("15w.png")

#16

p.w16 <- plot_usmap(data=all50, values='w16', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Sixteen') + 
  theme(legend.position = "right")

p.w16

ggsave(filename = "16w.png", plot=p.w16,width=4,height=4,units="in",scale=1)

w16 <- image_read("16w.png")

#17

p.w17 <- plot_usmap(data=all50, values='w17', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Seventeen') + 
  theme(legend.position = "right")

p.w17

ggsave(filename = "17w.png", plot=p.w17,width=4,height=4,units="in",scale=1)

#18

w17 <- image_read("17w.png")

p.w18 <- plot_usmap(data=all50, values='w18', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Eighteen') + 
  theme(legend.position = "right")

p.w18

ggsave(filename = "18w.png", plot=p.w18,width=4,height=4,units="in",scale=1)

#19

w18 <- image_read("18w.png")

p.w19 <- plot_usmap(data=all50, values='w19', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Nineteen') + 
  theme(legend.position = "right")

p.w19

ggsave(filename = "19w.png", plot=p.w19,width=4,height=4,units="in",scale=1)

w19 <- image_read("19w.png")

#20

p.w20 <- plot_usmap(data=all50, values='w20', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Twenty') + 
  theme(legend.position = "right")

p.w20

ggsave(filename = "20w.png", plot=p.w20,width=4,height=4,units="in",scale=1)

w20 <- image_read("20w.png")

#21

p.w21 <- plot_usmap(data=all50, values='w21', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Twenty One') + 
  theme(legend.position = "right")

p.w21

ggsave(filename = "21w.png", plot=p.w21,width=4,height=4,units="in",scale=1)

w21 <- image_read("21w.png")

#22

p.w22 <- plot_usmap(data=all50, values='w22', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Twenty Two') + 
  theme(legend.position = "right")

p.w22

ggsave(filename = "22w.png", plot=p.w22,width=4,height=4,units="in",scale=1)

w22 <- image_read("22w.png")

#23

p.w23 <- plot_usmap(data=all50, values='w23', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Twenty Three') + 
  theme(legend.position = "right")

p.w23

ggsave(filename = "23w.png", plot=p.w23,width=4,height=4,units="in",scale=1)

w23 <- image_read("23w.png")

#24

p.w24 <- plot_usmap(data=all50, values='w24', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Twenty Four') + 
  theme(legend.position = "right")

p.w24

ggsave(filename = "24w.png", plot=p.w24,width=4,height=4,units="in",scale=1)

w24 <- image_read("24w.png")

#25

p.w25 <- plot_usmap(data=all50, values='w25', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Twenty Five') + 
  theme(legend.position = "right")

p.w25

ggsave(filename = "25w.png", plot=p.w25,width=4,height=4,units="in",scale=1)

w25 <- image_read("25w.png")


#26

p.w26 <- plot_usmap(data=all50, values='W26', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Twenty Six') + 
  theme(legend.position = "right")

p.w26

ggsave(filename = "26w.png", plot=p.w26,width=4,height=4,units="in",scale=1)

w26 <- image_read("26w.png")


#27

p.w27 <- plot_usmap(data=all50, values='w27', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Twenty Seven') + 
  theme(legend.position = "right")

p.w27

ggsave(filename = "27w.png", plot=p.w27,width=4,height=4,units="in",scale=1)

w27 <- image_read("27w.png")


#28

p.w28 <- plot_usmap(data=all50, values='w28', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Twenty Eight') + 
  theme(legend.position = "right")

p.w28

ggsave(filename = "28w.png", plot=p.w28,width=4,height=4,units="in",scale=1)

w28 <- image_read("28w.png")


#29

p.w29 <- plot_usmap(data=all50, values='W29', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Twenty Nine') + 
  theme(legend.position = "right")

p.w29

ggsave(filename = "29w.png", plot=p.w29,width=4,height=4,units="in",scale=1)

w29 <- image_read("29w.png")


#30

p.w30 <- plot_usmap(data=all50, values='w30', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Thirty') + 
  theme(legend.position = "right")

p.w30

ggsave(filename = "30w.png", plot=p.w30,width=4,height=4,units="in",scale=1)

w30 <- image_read("30w.png")


#31

p.w31 <- plot_usmap(data=all50, values='w31', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Thirty One') + 
  theme(legend.position = "right")

p.w31

ggsave(filename = "31w.png", plot=p.w31,width=4,height=4,units="in",scale=1)

w31 <- image_read("31w.png")


#32

p.w32 <- plot_usmap(data=all50, values='w32', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Thirty Two') + 
  theme(legend.position = "right")

p.w32

ggsave(filename = "32w.png", plot=p.w32,width=4,height=4,units="in",scale=1)

w32 <- image_read("32w.png")


#33

p.w33 <- plot_usmap(data=all50, values='w33', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Thirty Three') + 
  theme(legend.position = "right")

p.w33

ggsave(filename = "33w.png", plot=p.w33,width=4,height=4,units="in",scale=1)

w33 <- image_read("33w.png")


#34

p.w34 <- plot_usmap(data=all50, values='w34', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Thirty Four') + 
  theme(legend.position = "right")

p.w34

ggsave(filename = "34w.png", plot=p.w34,width=4,height=4,units="in",scale=1)

w34 <- image_read("34w.png")


#35

p.w35 <- plot_usmap(data=all50, values='w35', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Thirty Five') + 
  theme(legend.position = "right")

p.w35

ggsave(filename = "35w.png", plot=p.w35,width=4,height=4,units="in",scale=1)

w35 <- image_read("35w.png")


#36

p.w36 <- plot_usmap(data=all50, values='w36', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Thirty Six') + 
  theme(legend.position = "right")

p.w36

ggsave(filename = "36w.png", plot=p.w36,width=4,height=4,units="in",scale=1)

w36 <- image_read("36w.png")


#37

p.w37 <- plot_usmap(data=all50, values='w37', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Thirty Seven') + 
  theme(legend.position = "right")

p.w37

ggsave(filename = "37w.png", plot=p.w37,width=4,height=4,units="in",scale=1)

w37 <- image_read("37w.png")


#38

p.w38 <- plot_usmap(data=all50, values='w38', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Thirty Eight') + 
  theme(legend.position = "right")

p.w38

ggsave(filename = "38w.png", plot=p.w38,width=4,height=4,units="in",scale=1)

w38 <- image_read("38w.png")


#39

p.w39 <- plot_usmap(data=all50, values='w39', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Thirty Nine') + 
  theme(legend.position = "right")

p.w39

ggsave(filename = "39w.png", plot=p.w39,width=4,height=4,units="in",scale=1)

w39 <- image_read("39w.png")


#40

p.w40 <- plot_usmap(data=all50, values='w40', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Forty') + 
  theme(legend.position = "right")

p.w40

ggsave(filename = "40w.png", plot=p.w40,width=4,height=4,units="in",scale=1)

w40 <- image_read("40w.png")


#41

p.w41 <- plot_usmap(data=all50, values='w41', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Forty One') + 
  theme(legend.position = "right")

p.w41

ggsave(filename = "41w.png", plot=p.w41,width=4,height=4,units="in",scale=1)

w41 <- image_read("41w.png")


#42

p.w42 <- plot_usmap(data=all50, values='w42', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Forty Two') + 
  theme(legend.position = "right")

p.w42

ggsave(filename = "42w.png", plot=p.w42,width=4,height=4,units="in",scale=1)

w42 <- image_read("42w.png")


#43

p.w43 <- plot_usmap(data=all50, values='w43', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Forty Three') + 
  theme(legend.position = "right")

p.w43

ggsave(filename = "43w.png", plot=p.w43,width=4,height=4,units="in",scale=1)

w43 <- image_read("43w.png")


#44

p.w44 <- plot_usmap(data=all50, values='W44', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Forty Four') + 
  theme(legend.position = "right")

p.w44

ggsave(filename = "44w.png", plot=p.w44,width=4,height=4,units="in",scale=1)

w44 <- image_read("44w.png")


#45

p.w45 <- plot_usmap(data=all50, values='w45', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Forty Five') + 
  theme(legend.position = "right")

p.w45

ggsave(filename = "45w.png", plot=p.w45,width=4,height=4,units="in",scale=1)

w45 <- image_read("45w.png")


#46

p.w46 <- plot_usmap(data=all50, values='w46', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Forty Six') + 
  theme(legend.position = "right")

p.w46

ggsave(filename = "46w.png", plot=p.w46,width=4,height=4,units="in",scale=1)

w46 <- image_read("46w.png")


#47

p.w47 <- plot_usmap(data=all50, values='w47', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Forty Seven') + 
  theme(legend.position = "right")

p.w47

ggsave(filename = "47w.png", plot=p.w47,width=4,height=4,units="in",scale=1)

w47 <- image_read("47w.png")


#48

p.w48 <- plot_usmap(data=all50, values='w48', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Forty Eight') + 
  theme(legend.position = "right")

p.w48

ggsave(filename = "48w.png", plot=p.w48,width=4,height=4,units="in",scale=1)

w48 <- image_read("48w.png")


#49

p.w49 <- plot_usmap(data=all50, values='w49', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Forty Nine') + 
  theme(legend.position = "right")

p.w49

ggsave(filename = "49w.png", plot=p.w49,width=4,height=4,units="in",scale=1)

w49 <- image_read("49w.png")


#50

p.w50 <- plot_usmap(data=all50, values='w50', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Fifty') + 
  theme(legend.position = "right")

p.w50

ggsave(filename = "50w.png", plot=p.w50,width=4,height=4,units="in",scale=1)

w50 <- image_read("50w.png")


#51

p.w51 <- plot_usmap(data=all50, values='w51', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Fifty One') + 
  theme(legend.position = "right")

p.w51

ggsave(filename = "51w.png", plot=p.w51,width=4,height=4,units="in",scale=1)

w51 <- image_read("51w.png")


#52

p.w52 <- plot_usmap(data=all50, values='w52', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Fifty Two') + 
  theme(legend.position = "right")

p.w52

ggsave(filename = "52w.png", plot=p.w52,width=4,height=4,units="in",scale=1)

w52 <- image_read("52w.png")


#53

p.w53 <- plot_usmap(data=all50, values='w53', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Fifty Three') + 
  theme(legend.position = "right")

p.w53

ggsave(filename = "53w.png", plot=p.w53,width=4,height=4,units="in",scale=1)

w53 <- image_read("53w.png")


#54

p.w54 <- plot_usmap(data=all50, values='w54', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Fifty Four') + 
  theme(legend.position = "right")

p.w54

ggsave(filename = "54w.png", plot=p.w54,width=4,height=4,units="in",scale=1)

w54 <- image_read("54w.png")


#55

p.w55 <- plot_usmap(data=all50, values='w55', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Fifty Five') + 
  theme(legend.position = "right")

p.w55

ggsave(filename = "55w.png", plot=p.w55,width=4,height=4,units="in",scale=1)

w55 <- image_read("55w.png")


#56

p.w56 <- plot_usmap(data=all50, values='w56', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Fifty Six') + 
  theme(legend.position = "right")

p.w56

ggsave(filename = "56w.png", plot=p.w56,width=4,height=4,units="in",scale=1)

w56 <- image_read("56w.png")


#57

p.w57 <- plot_usmap(data=all50, values='w57', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Fifty Seven') + 
  theme(legend.position = "right")

p.w57

ggsave(filename = "57w.png", plot=p.w57,width=4,height=4,units="in",scale=1)

w57 <- image_read("57w.png")

#58

p.w58 <- plot_usmap(data=all50, values='w58', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Fifty Eight') + 
  theme(legend.position = "right")

p.w58

ggsave(filename = "58w.png", plot=p.w58,width=4,height=4,units="in",scale=1)

w58 <- image_read("58w.png")


#59

p.w59 <- plot_usmap(data=all50, values='w59', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Fifty Nine') + 
  theme(legend.position = "right")

p.w59

ggsave(filename = "59w.png", plot=p.w59,width=4,height=4,units="in",scale=1)

w59 <- image_read("59w.png")


#60

p.w60 <- plot_usmap(data=all50, values='w60', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Sixty') + 
  theme(legend.position = "right")

p.w60

ggsave(filename = "60w.png", plot=p.w60,width=4,height=4,units="in",scale=1)

w60 <- image_read("60w.png")


#61

p.w61 <- plot_usmap(data=all50, values='w61', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Sixty One') + 
  theme(legend.position = "right")

p.w61

ggsave(filename = "61w.png", plot=p.w61,width=4,height=4,units="in",scale=1)

w61 <- image_read("61w.png")


#62

p.w62 <- plot_usmap(data=all50, values='w62', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Sixty Two') + 
  theme(legend.position = "right")

p.w62

ggsave(filename = "62w.png", plot=p.w62,width=4,height=4,units="in",scale=1)

w62 <- image_read("62w.png")


#63

p.w63 <- plot_usmap(data=all50, values='w63', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Sixty Three') + 
  theme(legend.position = "right")

p.w63

ggsave(filename = "63w.png", plot=p.w63,width=4,height=4,units="in",scale=1)

w63 <- image_read("63w.png")


#64

p.w64 <- plot_usmap(data=all50, values='w64', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Sixty Four') + 
  theme(legend.position = "right")

p.w64

ggsave(filename = "64w.png", plot=p.w64,width=4,height=4,units="in",scale=1)

w64 <- image_read("64w.png")


#65

p.w65 <- plot_usmap(data=all50, values='w65', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Sixty Five') + 
  theme(legend.position = "right")

p.w65

ggsave(filename = "65w.png", plot=p.w65,width=4,height=4,units="in",scale=1)

w65 <- image_read("65w.png")


#66

p.w66 <- plot_usmap(data=all50, values='w66', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Sixty Six') + 
  theme(legend.position = "right")

p.w66

ggsave(filename = "66w.png", plot=p.w66,width=4,height=4,units="in",scale=1)

w66 <- image_read("66w.png")


#67

p.w67 <- plot_usmap(data=all50, values='w67', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Sixty Seven') + 
  theme(legend.position = "right")

p.w67

ggsave(filename = "67w.png", plot=p.w67,width=4,height=4,units="in",scale=1)

w67 <- image_read("67w.png")


#68

p.w68 <- plot_usmap(data=all50, values='w68', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Sixty Eight') + 
  theme(legend.position = "right")

p.w68

ggsave(filename = "68w.png", plot=p.w68,width=4,height=4,units="in",scale=1)

w68 <- image_read("68w.png")


#69

p.w69 <- plot_usmap(data=all50, values='w69', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Sixty Nine') + 
  theme(legend.position = "right")

p.w69

ggsave(filename = "69w.png", plot=p.w69,width=4,height=4,units="in",scale=1)

w69 <- image_read("69w.png")


#70

p.w70 <- plot_usmap(data=all50, values='w70', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Seventy') + 
  theme(legend.position = "right")

p.w70

ggsave(filename = "70w.png", plot=p.w70,width=4,height=4,units="in",scale=1)

w70 <- image_read("70w.png")


#71

p.w71 <- plot_usmap(data=all50, values='w71', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Seventy One') + 
  theme(legend.position = "right")

p.w71

ggsave(filename = "71w.png", plot=p.w71,width=4,height=4,units="in",scale=1)

w71 <- image_read("71w.png")


#72

p.w72 <- plot_usmap(data=all50, values='w72', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Seventy Two') + 
  theme(legend.position = "right")

p.w72

ggsave(filename = "72w.png", plot=p.w72,width=4,height=4,units="in",scale=1)

w72 <- image_read("72w.png")


#73

p.w73 <- plot_usmap(data=all50, values='w73', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Seventy Three') + 
  theme(legend.position = "right")

p.w73

ggsave(filename = "73w.png", plot=p.w73,width=4,height=4,units="in",scale=1)

w73 <- image_read("73w.png")


#74

p.w74 <- plot_usmap(data=all50, values='w74', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Seventy Four') + 
  theme(legend.position = "right")

p.w74

ggsave(filename = "74w.png", plot=p.w74,width=4,height=4,units="in",scale=1)

w74 <- image_read("74w.png")


#75

p.w75 <- plot_usmap(data=all50, values='W75', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Seventy Five') + 
  theme(legend.position = "right")

p.w75

ggsave(filename = "75w.png", plot=p.w75,width=4,height=4,units="in",scale=1)

w75 <- image_read("75w.png")


#76

p.w76 <- plot_usmap(data=all50, values='w76', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Seventy Six') + 
  theme(legend.position = "right")

p.w76

ggsave(filename = "76w.png", plot=p.w76,width=4,height=4,units="in",scale=1)

w76 <- image_read("76w.png")


#77

p.w77 <- plot_usmap(data=all50, values='w77', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Seventy Seven') + 
  theme(legend.position = "right")

p.w77

ggsave(filename = "77w.png", plot=p.w77,width=4,height=4,units="in",scale=1)

w77 <- image_read("77w.png")


#78

p.w78 <- plot_usmap(data=all50, values='w78', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Seventy Eight') + 
  theme(legend.position = "right")

p.w78

ggsave(filename = "78w.png", plot=p.w78,width=4,height=4,units="in",scale=1)

w78 <- image_read("78w.png")


#79

p.w79 <- plot_usmap(data=all50, values='w79', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Seventy Nine') + 
  theme(legend.position = "right")

p.w79

ggsave(filename = "79w.png", plot=p.w79,width=4,height=4,units="in",scale=1)

w79 <- image_read("79w.png")


#80

p.w80 <- plot_usmap(data=all50, values='w80', color = "grey") + 
  scale_fill_continuous(low = 'white', high = 'red', name = "Popularity", 
                        label = scales::comma, limits=c(0,100)) +
  labs(title = "Popularity of the Search Term 'Suicidal` Since 3/1/20",
       subtitle = 'Week Eighty') + 
  theme(legend.position = "right")

p.w80

ggsave(filename = "80w.png", plot=p.w80,width=4,height=4,units="in",scale=1)

w80 <- image_read("80w.png")

img <- c(w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,w13,w14,w15,w16,w17,w18,w19,w20,
         w21,w22,w23,w24,w25,w26,w27,w28,w29,w30,w31,w32,w33,w34,w35,w36,w37,
         w38,w39,w40,w41,w42,w43,w44,w45,w46,w47,w48,w49,w50,w51,w52,w53,w54,
         w55,w56,w57,w58,w59,w60,w61,w62,w63,w64,w65,w66,w67,w68,w69,w70,
         w71,w72,w73,w74,w75,w76,w77,w78,w79,w80)

image_append(image_scale(img, "x100"))

my.animation<-image_animate(image_scale(img, "600x600"), fps = 1.25, dispose = "previous")
image_write(my.animation, "all50.gif")

my.animation
