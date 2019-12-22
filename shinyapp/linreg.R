prediction <- function(input) {
  coefs <- readRDS("results/coefs.rds")
  predict = coefs[(Intercept)]
  predict = predict + coefs["usertype"] * ((input$Usertype == "Customer") *
                                             1 + (input$Usertype == "Subscriber") * 2)
  predict = predict + coefs["gender"] * ((input$Gender == "Male") *
                                           3 + (input$Gender == "Female") * 2)
  if (input$Season == "Spring")
    predict = predict + coefs["season2"]
  
  if (input$Season == "Summer")
    predict = predict + coefs["season3"]
  
  if (input$Season == "Winter")
    predict = predict + coefs["season4"]
  
  predict = predict + coefs["age"] * input$age
  
  ID = stations$ID[which(stations$Station.Name == input$Station)]
  if (length(coefs[paste0("from_station_id", ID)] == 1))
    predict = predict + coefs[paste0("from_station_id", ID)]
  
  index = c("Monday",
            "Tuesday",
            "Wednesday",
            "Thursday",
            "Friday",
            "Saturday",
            "Sunday") == input$day
  day = (1:7)[index]
  predict = predict + coefs[paste0("day_of_week", day)]
}
