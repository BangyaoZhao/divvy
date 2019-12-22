library(shiny)
library(ggplot2)
library(ggrepel)
library(tidyverse)
library(shinydashboard)
library(shinythemes)
stations=read.csv("Divvy_Bicycle_Stations.csv")
ui <- fluidPage(
  
    titlePanel("Divvy"),
    sidebarLayout(
      sidebarPanel(
        fluidRow(
        box(title = "Input Data",status = "primary",width = 14,
        selectInput(
          "Usertype", "Usertype",
          c(Subscriber = "Subscriber",
            Customer = "Customer"),
          selected = "Subscriber"
        ),
        selectInput(
          "Gender", "Gender",
          c(Male = "Male",
            Female = "Female"),
          selected = "Female"
        ),
        selectInput(
          "Season", "Season",
          c(Spring = "Spring",
            Summer = "Summer",
            Autumn="Autumn",
            Winter="Winter"
            ),
          selected = "Spring"
        ),
        selectInput(
          "day", "Which day in the week",
          c(Monday = "Monday",
            Tuesday = "Tuesday",
            Wednesday="Wednesday",
            Thursday="Thursday",
            Friday="Friday",
            Saturday="Saturday",
            Sunday="Sunday"
          ),
          selected = "Spring"
        ),
        selectInput(
          "Station", "Station",
          c(stations),
          selected = "Buckingham Fountain"
        ),
        sliderInput(inputId = "age",
                    label = "Age:",
                    min = 1,
                    max = 80,
                    value = 1)
        
        )
        )
      ),
      mainPanel(
        img(src="mapbox.png"),
        fluidRow(
          box(title = "Predicted duration of user using bike",status = "primary",width = 14
              ))
      )
      )
  )



server <- function(input, output) {
  
}

shinyApp(ui, server)

