trips=trips[,c(5,6,10,11,13,14)]
saveRDS(trips,file = "workingdata.rds")
readRDS("workingdata.rds")
library(caret)
library(doParallel)
cl <- makePSOCKcluster(4)
registerDoParallel(cl)

## All subsequent models are then run in parallel
model <- train(tripduration ~ ., data = trips[1:100000,], method = "rf")

## When you are done:
stopCluster(cl)





