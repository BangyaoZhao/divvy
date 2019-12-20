divvydata <- readRDS(file = "data/newdata_addlocationdock.rds")
loc <- unique(divvydata[, c("Latitude", "Longitude")]) # unique locations the stations

# cl10 <- sapply(seq(10, 50, 10), function(x){ # 10 to 50
#   c <- kmeans(loc, x, nstart = 25)
#   return(c(c$totss, c$betweenss))
# })
# plot(1:5, cl10[2, ])
cl10 <- sapply(seq(10, 100, 10), function(x){ # 10 to 100
  c <- kmeans(loc, x, iter.max = 20, nstart = 25)
  return(c$tot.withinss)
})
png("../plots/totwithinss.png")
plot(seq(10, 100, 10), cl10, type = "l", xlab = "number of clusters",
     ylab = "total within variance")
dev.off()
# lines(x = 25:35, y = cl25)
# 
# cl20 <- sapply(seq(20,40), function(x){ # 25 to 35
#   c <- kmeans(loc, x, iter.max = 20, nstart = 25)
#   return(c(x, c$tot.withinss))
# })
# plot(t(cl20), type = "l")

