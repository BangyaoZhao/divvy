methods = c("svmRadial", "treebag", "rpart", "gaussprRadial", "knn", "rf")
i = Sys.getenv("SLURM_ARRAY_TASK_ID")
(i = as.numeric(i))
method = methods[i]

# read in data and model
workingdata_test <- readRDS("../data/workingdata_test.rds")
load(paste0(method,".Rdata"))

# parallel setting
library(doParallel)
cl <- makePSOCKcluster(20)
registerDoParallel(cl)

# predict and calculate MSE
p <- predict(model, workingdata_test)
(mse <- sum((workingdata_test$tripduration - p)^2 / 1501320))

stopCluster(cl)

save.image(paste0(method,"_p.Rdata"))
