#######################################
################# EDA ################
#######################################
trips=readRDS("/Users/sunyichi/Documents/GitHub/divvy/workingdata_normal.rds")
trips$tripduration=trips$tripduration/60
stations=read.csv("/Users/sunyichi/Documents/GitHub/divvy/Divvy_Bicycle_Stations.csv")
names(stations)[1]="from_station_id"
stations=stations[,c(1,5,7,8,9)]
merge(trips,stations,by="id")




smp_size=0.5*dim(trips)[1]
train_ind <- sample(seq_len(dim(trips)[1]), size = smp_size)
train <- trips[train_ind, ]
test <- trips[-train_ind, ]
saveRDS(train,file="/Users/sunyichi/Documents/GitHub/divvy/workingdata_train.rds")
saveRDS(test,file="/Users/sunyichi/Documents/GitHub/divvy/workingdata_test.rds")


trips_train=readRDS("/Users/sunyichi/Documents/GitHub/divvy/workingdata_train.rds")
trips_train$from_station_id=as.factor(trips_train$from_station_id)
set.seed(625)
library(caret)
library(doParallel)
cl <- makePSOCKcluster(20)
registerDoParallel(cl)
## All subsequent models are then run in parallel
fitControl <- trainControl(
  method = 'cv',                   # k-fold cross validation
  number = 5,                      # number of folds
  savePredictions = 'final'
) 
model <- train(tripduration ~ factor(from_station_id)+usertype+gender+factor(season)+age+hour+factor(day_of_week), data = trips_train[1:10,], method = "rf",metric="RMSE", trControl = fitControl)
stopCluster(cl)
save.image(file="rf.RData")


# method=rf,	treebag, bagEarth, rpart, gaussprRadial, knn, svmRadial

