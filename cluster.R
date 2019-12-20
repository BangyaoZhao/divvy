divvydata <- readRDS(file = "data/newdata_addlocationdock.rds")
loc <- unique(divvydata[, c("from_station_id", "Latitude", "Longitude")]) # unique locations the stations
rownames(loc) <- loc[,1]
loc <- loc[, 2:3]

cl10 <- sapply(seq(10, 100, 10), function(x){ # 10 to 100
  c <- kmeans(loc, x, iter.max = 20, nstart = 25)
  return(c$tot.withinss)                      # get total within cluster variance
})
png("plots/totwithinss.png")                  # choose K
plot(seq(10, 100, 10), cl10, type = "l", xlab = "number of clusters",
     ylab = "total within variance")
dev.off()

# decide on K = 40
cl40 <- kmeans(loc, 40, iter.max = 20, nstart = 25)
loc_new <- cbind(loc, cl40$cluster)
data_cl <- merge(divvydata, loc_new)
