# read in data and model
load("rpart.RData")
workingdata_test <- readRDS("../data/workingdata_test.rds")

# parallel setting
library(doParallel)
cl <- makePSOCKcluster(20)
registerDoParallel(cl)

# predict and calculate MSE
p <- predict(model, workingdata_test)
(mse <- sum((workingdata_test$tripduration - p)^2 / 1501320))

stopCluster(cl)

save.image("rpart_p.Rdata")
