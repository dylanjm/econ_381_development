library(readxl)
library(downloader)
library(tidyverse)


#Read in the data
USA <- read_excel("C:/Users/Andrew/Documents/Econ 381 Course Development/Chapter 1/USA.xls", skip = 9)
Germany <- read_excel("C:/Users/Andrew/Documents/Econ 381 Course Development/Chapter 1/DEU.xls", skip = 9)
Italy <- read_excel("C:/Users/Andrew/Documents/Econ 381 Course Development/Chapter 1/ITA.xls", skip = 9)
Japan <- read_excel("C:/Users/Andrew/Documents/Econ 381 Course Development/Chapter 1/JPN.xls", skip = 9)

#Fiter out a row of NA's from each dataset
USA <- USA %>% 
  filter(Year != is.na(Year))

Germany <- Germany %>% 
  filter(Year != is.na(Year))

Italy <- Italy %>% 
  filter(Year != is.na(Year))

Japan <- Japan %>% 
  filter(Year != is.na(Year))



##############################################################################
#Question 4a
#Make a plot of per capita GDP (in dollars) for the years 1950 to 2014 
#for a country of your choice. Label the x-axis “year” and the y-axis 
#“per capita GDP.”
##############################################################################

USA %>% 
  ggplot(aes(x = Year, y = `Y/Pop`)) + 
  geom_point() + 
  geom_line() + 
  labs(y = "per Capita GDP", title = "USA Per Capita GDP") + 
  theme_bw()
  

##############################################################################
#Question 4b
#Make a plot of GDP per capita relative to the United States (U.S = 100) for the years 
# 1950 to 2014 that includes the U.S. and three other counteries of your choice
# all on the same graph. Be sure to label the lines on the graph in some 
#informative way so that each
##############################################################################

ggplot(USA) + 
  geom_point(data = Italy, aes(x = Year, y = `Y/Pop(us=100)`), col = "green") + 
  geom_line(data = Italy, aes(x = Year, y = `Y/Pop(us=100)`),  col = "green") +
  geom_point(data = Germany, aes(x = Year, y = `Y/Pop(us=100)`), col = "red") + 
  geom_line(data = Germany, aes(x = Year, y = `Y/Pop(us=100)`), col = "red") + 
  geom_point(data = Japan, aes(x = Year, y = `Y/Pop(us=100)`)) + 
  geom_line(data = Japan, aes(x = Year, y = `Y/Pop(us=100)`)) +
  geom_text(aes(label = "Italy", x = 2008, y = 60), col = "green") +
  geom_text(aes(label = "Japan", x = 2011, y = 65), col = "black") +
  geom_text(aes(label = "Germany", x = 2011, y = 77), col = "red") +
  labs(y = "per capita GDP", title = "Per Capita GDP Relative to USA", 
       subtitle = "Note USA = 100") + 
  theme_bw()

