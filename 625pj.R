readRDS("workingdata.rds")
library(caret)
library(doParallel)
cl <- makePSOCKcluster(4)
registerDoParallel(cl)

## All subsequent models are then run in parallel
model <- train(tripduration ~ ., data = trips[1:100000,], method = "rf")

## When you are done:
stopCluster(cl)





