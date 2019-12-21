trips_train=readRDS("workingdata_train.rds")
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
model <- train(tripduration ~ usertype+gender+factor(season)+age+hour+factor(day_of_week)+factor(clusterID)+Docks.in.Service, data = trips_train, method = "svmRadial",metric="RMSE", trControl = fitControl)
stopCluster(cl)
save.image(file="svmRadial.RData")
