methods = c("svmRadial", "treebag", "rpart", "gaussprRadial", "knn", "rf")
# i = Sys.getenv("SLURM_ARRAY_TASK_ID")
# (i = as.numeric(i))


# read in data and model
# workingdata_test <- readRDS("data/workingdata_test.rds")
# for (i in c(2, 3, 5, 6))
i = 6
method = methods[i]
load(paste0("../divvy0/", method, ".Rdata"))

# parallel setting
library(doParallel)
cl <- makePSOCKcluster(20)
registerDoParallel(cl)

# predict and calculate MSE
p <- predict(model, workingdata_test)
(mse <- sum((workingdata_test$tripduration - p)^2 / 1501320))

stopCluster(cl)

save.image(paste0(method,"_p.Rdata"))
