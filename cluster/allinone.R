methods = c("svmRadial", "treebag", "rpart", "gaussprRadial", "knn", "rf")
i = Sys.getenv("SLURM_ARRAY_TASK_ID")
i = as.numeric(i)
method = methods[i]
i

trips_train = readRDS("../data/workingdata_train.rds")
set.seed(625)
library(caret)
library(doParallel)
cl <- makePSOCKcluster(100)
registerDoParallel(cl)
## All subsequent models are then run in parallel
fitControl <- trainControl(method = 'cv',
                           # k-fold cross validation
                           number = 5,
                           # number of folds
                           savePredictions = 'final')
model <-
  train(
    tripduration ~ factor(clusterID) + Docks.in.Service + usertype + gender +
      factor(season) + age + hour + factor(day_of_week),
    data = trips_train,
    method = method,
    metric = "RMSE",
    trControl = fitControl
  )
stopCluster(cl)

filename = paste0(method, ".Rdata")
save.image(file = filename)