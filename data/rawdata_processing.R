library(dplyr)

#----
#Create data

#load original data
original_data <- readRDS("rawdata/original_data.rds")

#obtain age
data = original_data
data$tripduration = as.numeric(data$tripduration)
data$age = 2018 - as.numeric(data$birthyear)

#discard missing data
data = filter(data,!is.na(age) & !is.na(gender) & gender != "")

#discard abnormal data
range = quantile(data$tripduration, seq(0, 1, 0.01))[c(2, 100)]
data = filter(data, tripduration >= range[1] &
                tripduration <= range[2])

#create hour
hour = as.character(data$start_time)
hour = as.numeric(substring(hour, 12, 13))
data$hour = hour

#create day of week
day_of_week = as.Date(data$start_time)
day_of_week = weekdays(day_of_week)
day_of_week = 1 * (day_of_week == "Monday") +
  2 * (day_of_week == "Tuesday") +
  3 * (day_of_week == "Wednesday") +
  4 * (day_of_week == "Thursday") +
  5 * (day_of_week == "Friday") +
  6 * (day_of_week == "Saturday") +
  7 * (day_of_week == "Sunday")
data$day_of_week = day_of_week

#----
#create cluster
library(readr)
Divvy_Bicycle_Stations <- read_csv("data/Divvy_Bicycle_Stations.csv")
View(Divvy_Bicycle_Stations)



