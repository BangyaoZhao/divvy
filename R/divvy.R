library(biglm)
library(dplyr)
library(bigmemory)
library(biganalytics)

workingdata <- readRDS("F:/R_2/divvy/workingdata.rds")
hist(workingdata$tripduration)
range = quantile(workingdata$tripduration, seq(0, 1, 0.01))[c(2, 100)]
workingdata_normal = filter(workingdata, tripduration >= range[1] &
                              tripduration <= range[2])
hour=as.character(workingdata_normal$start_time)
hour=as.numeric(substring(hour,12,13))
workingdata_normal$hour=hour
day_of_week=as.Date(workingdata_normal$start_time)
day_of_week=weekdays(day_of_week)
day_of_week = 1 * (day_of_week == "Monday") +
  2 * (day_of_week == "Tuesday") +
  3 * (day_of_week == "Wednesday") +
  4 * (day_of_week == "Thursday") +
  5 * (day_of_week == "Friday") +
  6 * (day_of_week == "Saturday") +
  7 * (day_of_week == "Sunday")
workingdata_normal$day_of_week=day_of_week
workingdata_normal_b = as.big.matrix(workingdata_normal)


res_normal_sqrt = biglm.big.matrix(
  I(sqrt(tripduration)) ~ gender + age + season + hour + day_of_week + from_station_id,
  data = workingdata_normal_b,
  fc = c("season", "from_station_id", "hour", "day_of_week")
)
sum_normal_sqrt = summary(res_normal_sqrt)
save(res_normal_sqrt, file = "res_normal_sqrt.Rdata")
sum_normal_sqrt$rsq


#-----------------
# workingdata_train = workingdata[sample(nrow(workingdata_normal), 30000), ]
# workingdata_train_b = as.big.matrix(workingdata_train)
# res_train = biglm.big.matrix(
#   I(sqrt(tripduration)) ~ gender + age + season + from_station_id,
#   data = workingdata_train_b,
#   fc = c("season", "from_station_id")
# )
# save(res_train, file = "res_train.Rdata")
# sum_train = summary(res_train)
# sum_train$rsq
# 
# workingdata_b = as.big.matrix(workingdata)
# res = biglm.big.matrix(
#   tripduration ~ gender + age + season + from_station_id,
#   data = workingdata_b,
#   fc = c("season", "from_station_id")
# )
# save(res, file = "res.Rdata")
# sum = summary(res)
# 
# res_normal = biglm.big.matrix(
#   tripduration ~ gender + age + season + from_station_id,
#   data = workingdata_normal_b,
#   fc = c("season", "from_station_id")
# )
# sum_normal = summary(res_normal)
# 
# res_log = biglm.big.matrix(
#   I(log(tripduration)) ~ gender + age + season + from_station_id,
#   data = workingdata_b,
#   fc = c("season", "from_station_id")
# )
# res_sqrt = biglm.big.matrix(
#   I(sqrt(tripduration)) ~ gender + age + season + from_station_id,
#   data = workingdata_b,
#   fc = c("season", "from_station_id")
# )
# sum_log = summary(res_log)
# sum_sqrt = summary(res_sqrt)
# 
# sum_train$rsq
# sum$rsq
# sum_log$rsq
# sum_sqrt$rsq
# sum_normal$rsq
