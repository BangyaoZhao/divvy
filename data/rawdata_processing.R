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

#convert the tripduration to mins
data$tripduration=data$tripduration/60


#----
#create cluster
divvydata <- read.csv("data/Divvy_Bicycle_Stations.csv")
loc <- divvydata[, c("ID", "Latitude", "Longitude")] # unique locations the stations
rownames(loc) <- loc[,1]
loc <- loc[, 2:3]

cl10 <- sapply(seq(10, 100, 10), function(x){ # 10 to 100
  c <- kmeans(loc, x, iter.max = 20, nstart = 25)
  return(c$tot.withinss)                      # get total within cluster variance
})
png("plots/totwithinss.png")                  # choose K
plot(seq(10, 100, 10), cl10, type = "l", xlab = "number of clusters",
     ylab = "total within variance")
dev.off()

# decide on K = 40
cl40 <- kmeans(loc, 40, iter.max = 20, nstart = 25)
loc_new <- cbind(ID = rownames(loc), loc, clusterID = cl40$cluster)
data_cl <- merge(data, loc_new, by.x = "from_station_id", by.y = "ID")
data <- data_cl



