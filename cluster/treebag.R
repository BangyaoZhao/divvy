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
model <- train(tripduration ~ factor(clusterID)+Docks.in.Service+usertype+gender+factor(season)+age+hour+factor(day_of_week), data = trips_train, method = "treebag",metric="RMSE", trControl = fitControl)
stopCluster(cl)
save.image(file="treebag.RData")
