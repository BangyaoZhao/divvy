#######################################
################# EDA ################
#######################################
### Combining station location and docks####
trips=readRDS("/Users/sunyichi/Documents/GitHub/divvy/workingdata_normal.rds")
trips$tripduration=trips$tripduration/60
stations=read.csv("/Users/sunyichi/Documents/GitHub/divvy/Divvy_Bicycle_Stations.csv")
names(stations)[1]="from_station_id"
stations=stations[,c(1,5,7,8,9)]
newdata=merge(trips,stations,by="from_station_id")
saveRDS(newdata,file="/Users/sunyichi/Documents/GitHub/divvy/newdata_addlocationdock.rds")
##########################################
######## Split data to train/test #########
smp_size=0.5*dim(trips)[1]
train_ind <- sample(seq_len(dim(trips)[1]), size = smp_size)
train <- trips[train_ind, ]
test <- trips[-train_ind, ]
saveRDS(train,file="/Users/sunyichi/Documents/GitHub/divvy/workingdata_train.rds")
saveRDS(test,file="/Users/sunyichi/Documents/GitHub/divvy/workingdata_test.rds")
################################################
############## mapbox plot ####################
stations=read.csv("/Users/sunyichi/Documents/GitHub/divvy/data/Divvy_Bicycle_Stations.csv")
library(plotly)
library(maps)
library(ggmap)
library(raster)
library(sp)
library(maptools)
gpclibPermit()
library(maptools)
library(mapdata)
library(geosphere)
library(ggplot2)

ggmap::register_google(key = "private")
myLocation <- c(lon = 41.8781, lat = 87.6298)
ChicagoMap = get_map("Chicago", zoom = 14, color = "color", legend = "topleft")
p <- ggmap(get_googlemap(center = c(lon = -87.6298, lat = 41.8781),
                         zoom = 11, scale = 2,
                         maptype ='terrain',
                         color = 'color'))
png('mapbox.png')
p + geom_point(aes(x = stations$Longitude, y = stations$Latitude,colour=factor(stations$clusterID)), data = stations, size = 0.5, show.legend = F) 
dev.off()


myMap <- get_map(location=myLocation,source="osm", maptype="bw",crop=FALSE)
ggmap(myMap)                 




#######################################################################
####### fit non-parametric model using parallel computing #################
##############################################################################
trips_train=readRDS("/Users/sunyichi/Documents/GitHub/divvy/workingdata_train.rds")
trips_train$from_station_id=as.factor(trips_train$from_station_id)
set.seed(625)
library(caret)
library(doParallel)
cl <- makePSOCKcluster(20)
registerDoParallel(cl)
## All subsequent models are then run in parallel
fitControl <- trainControl(
  method = 'cv',                   # k-fold cross validation
  number = 5,                      # number of folds
  savePredictions = 'final'
) 
model <- train(tripduration ~ factor(from_station_id)+usertype+gender+factor(season)+age+hour+factor(day_of_week), data = trips_train[1:10,], method = "rf",metric="RMSE", trControl = fitControl)
stopCluster(cl)
save.image(file="rf.RData")


# method=rf,	treebag, bagEarth, rpart, gaussprRadial, knn, svmRadial

