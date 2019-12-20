library(bigmemory)
library(biganalytics)
#load trainning data
workingdata_train <- readRDS("data/workingdata_train.rds")

#fit linear model by lm()
#----
# res1 = lm(
#   tripduration ~ usertype + gender + factor(season) + age + factor(from_station_id) +
#     factor(hour) + factor(day_of_week),
#   data = workingdata_train
# )


#fit linear model by bigmemory
#----
workingdata_train_b = as.big.matrix(workingdata_train)
res1 = biglm.big.matrix(
  tripduration ~ usertype + gender + season + age + from_station_id +
    hour + day_of_week,
  data = workingdata_train_b,
  fc = c("season", "from_station_id", "hour", "day_of_week")
)

sum1 = summary(res1)

#residual plot(Model adequacy check)
#----
workingdata_train2 = workingdata_train[sample(nrow(workingdata_train), 30000),]
res = lm(
  tripduration ~ usertype + gender + factor(season) + age + factor(from_station_id) +
    factor(hour) + factor(day_of_week),
  data = workingdata_train2
)
res_sqrt = lm(
  I(sqrt(tripduration)) ~ usertype + gender + factor(season) + age + factor(from_station_id) +
    factor(hour) + factor(day_of_week),
  data = workingdata_train2
)
res_log = lm(
  I(log(tripduration)) ~ usertype + gender + factor(season) + age + factor(from_station_id) +
    factor(hour) + factor(day_of_week),
  data = workingdata_train2
)


#fit the model again
res2 = biglm.big.matrix(
  I(sqrt(tripduration)) ~ usertype + gender + season + age + from_station_id +
    hour + day_of_week,
  data = workingdata_train_b,
  fc = c("season", "from_station_id", "hour", "day_of_week")
)


#use the clustered data to directly run
#----
res3 = lm(
  I(sqrt(tripduration)) ~ usertype + gender + factor(season) + age + factor(clusterID) +
    factor(hour) + factor(day_of_week),
  data = workingdata_train
)

#save files
#----
saveRDS(res, file = "results/res.rds")
saveRDS(res_sqrt, file = "results/res_sqrt.rds")
saveRDS(res_log, file = "results/res_log.rds")
saveRDS(res1, file = "results/res1.rds")
saveRDS(res2, file = "results/res2.rds")
