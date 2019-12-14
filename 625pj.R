trips=readRDS("/Users/sunyichi/Documents/GitHub/divvy/workingdata_normal.rds")
trips$tripduration=trips$tripduration/60
smp_size=0.7*dim(trips)[1]
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
model <- train(tripduration ~ ., data = trips_train, method = "rf")

stopCluster(cl)





