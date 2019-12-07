trips_1=read.csv(file="Divvy_Trips_2018_Q1.csv")
trips_2=read.csv(file="Divvy_Trips_2018_Q2.csv")
trips_3=read.csv(file="Divvy_Trips_2018_Q3.csv")
trips_4=read.csv(file="Divvy_Trips_2018_Q4.csv")

library(dplyr)
library(bigmemory)
library(biganalytics)

trips_1$season=rep(1,nrow(trips_1))
trips_2$season=rep(2,nrow(trips_2))
trips_3$season=rep(3,nrow(trips_3))
trips_4$season=rep(4,nrow(trips_4))

trips_origin=rbind(trips_1,trips_2,trips_3,trips_4)

# data cleaning
trips = trips_origin

trips$tripduration=as.numeric(trips$tripduration)

trips$age=2018-as.numeric(trips$birthyear)

trips=filter(trips,!is.na(age) & !is.na(gender) & gender != "")

# data feature view
hist(trips$tripduration)
summary(trips$tripduration)

sum(trips$tripduration==1)

#use bigmemory
trips_b=as.big.matrix(trips)
res=biglm.big.matrix(tripduration~gender+age+factor(from_station_name),data = trips_b)
summary(res)

#
trips_train=trips[sample(nrow(trips),300000),]

# all(is.na(trips$gender))
# sum(is.na(trips$age))
# 
# levels(trips$gender)
# 
# head(trips$from_station_name)

res=lm(tripduration~gender,data = trips)

res=lm(tripduration~gender+age+factor(season),data = trips)

res=lm(tripduration~gender+age+from_station_name,data = trips)

res=lm(tripduration~gender,data = trips_train)

res=lm(tripduration~gender+age+factor(season),data = trips)

res2=lm(tripduration~gender+age+factor(season)+from_station_name,data = trips)