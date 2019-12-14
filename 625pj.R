trips=readRDS("/Users/sunyichi/Documents/GitHub/divvy/workingdata_normal.rds")
trips$tripduration=trips$tripduration/60
smp_size=0.5*dim(trips)[1]
train_ind <- sample(seq_len(dim(trips)[1]), size = smp_size)
train <- trips[train_ind, ]
test <- trips[-train_ind, ]
saveRDS(train,file="/Users/sunyichi/Documents/GitHub/divvy/workingdata_train.rds")
saveRDS(test,file="/Users/sunyichi/Documents/GitHub/divvy/workingdata_test.rds")


trips_train=readRDS("~/workingdata_normal.rds")
set.seed(625)
library(caret)
library(doParallel)
cl <- makePSOCKcluster(20)
registerDoParallel(cl)
## All subsequent models are then run in parallel
fitControl <- trainControl(
  method = 'cv',                   # k-fold cross validation
  number = 5,                      # number of folds
  savePredictions = 'final',       # saves predictions for optimal tuning parameter
  classProbs = T,                  # should class probabilities be returned
  summaryFunction=twoClassSummary  # results summary function
) 
model <- train(tripduration ~ ., data = trips_train, method = "rf",metric="RMSE", trControl = fitControl)
stopCluster(cl)



# method=rf,	treebag, bagEarth, rpart, gaussprRadial, knn, svmRadial

