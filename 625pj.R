trips=readRDS("/Users/sunyichi/Documents/GitHub/divvy/workingdata_normal.rds")
trips$tripduration=trips$tripduration/60



library(caret)
library(doParallel)
cl <- makePSOCKcluster(4)
registerDoParallel(cl)
trips=trips[,-7]
## All subsequent models are then run in parallel
model <- train(tripduration ~ ., data = trips[1:100,], method = "rf")
saveRDS(trips,file="/Users/sunyichi/Documents/GitHub/divvy/workingdata.rds")
## When you are done:
stopCluster(cl)





