
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------


library(shiny)
library(ggrepel)
library(tidyverse)
#library(devtools); install_github("mkleinsa/exdata")
library(exdata)

# UI Defines how the app looks
ui <- fluidPage(
  
  
)

# Server does the computation behind the results displayed by the IU

# Define server logic ---
server <- function(input, output) {
  
  
}

shinyApp(ui, server)



# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------








# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------





# UI Defines how the app looks
ui <- fluidPage(
  # App title ----
  
  fluidPage(
    
    titlePanel("Interactive Corruption and Human Development Plot")
    
  )
  
)

# Server does the computation behind the results displayed by the IU

# Define server logic ---
server <- function(input, output) {
  
  
}

shinyApp(ui, server)










# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------













# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------





# UI Defines how the app looks
ui <- fluidPage(
  # App title ----
  
  fluidPage(
    
    titlePanel("Interactive Corruption and Human Development Plot"),
    sidebarLayout(
      sidebarPanel(
        
      ),
      mainPanel(
        
      )
    )
    
  )
  
)

# Server does the computation behind the results displayed by the IU

# Define server logic ---
server <- function(input, output) {
  
  
}

shinyApp(ui, server)










# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------












# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------





# UI Defines how the app looks
ui <- fluidPage(
  # App title ----
  
  fluidPage(
    
    titlePanel("Interactive Corruption and Human Development Plot"),
    sidebarLayout(
      sidebarPanel(
        selectInput(
          "region_fit", "Fit by region?",
          c(Yes = "yes",
            No = "no"),
          selected = "no"
        ),
        
      ),
      mainPanel(
        
      )
    )
    
  )
  
)

# Server does the computation behind the results displayed by the IU

# Define server logic ---
server <- function(input, output) {

  
}

shinyApp(ui, server)











# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------





# UI Defines how the app looks
ui <- fluidPage(
  # App title ----
  
  fluidPage(
    
    titlePanel("Interactive Corruption and Human Development Plot"),
    sidebarLayout(
      sidebarPanel(
        selectInput(
          "region_fit", "Fit by region?",
          c(Yes = "yes",
            No = "no"),
          selected = "no"
        ),
        
      ),
      mainPanel(
        
      )
    )
    
  )
  
)

# Server does the computation behind the results displayed by the IU

# Define server logic ---
server <- function(input, output) {
  
  output$CPI_plot = renderPlot({
    
  })
  
}

shinyApp(ui, server)










# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------









# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------





# UI Defines how the app looks
ui <- fluidPage(
  # App title ----
  
  fluidPage(
    
    titlePanel("Interactive Corruption and Human Development Plot"),
    sidebarLayout(
      sidebarPanel(
        selectInput(
          "region_fit", "Fit by region?",
          c(Yes = "yes",
            No = "no"),
          selected = "no"
        ),
        
      ),
      mainPanel(
        
      )
    )
    
  )
  
)

# Server does the computation behind the results displayed by the IU

# Define server logic ---
server <- function(input, output) {
  
  country_labels =  c("Russia", "Venezuela", "Iraq", "Myanmar", "Sudan",
                      "Afghanistan", "Congo", "Greece", "Argentina", "Brazil",
                      "United States", "Germany", "Britain", "Barbados", "Norway", 
                      "Japan", "New Zealand", "Singapore")
  
  base_plot = 
    ggplot(EconomistData, aes(x = CPI, y = HDI, color = Region)) + 
    geom_point(shape = 1, size = 3, stroke = 2) + 
    geom_smooth(method = "lm",
                formula = y ~ x + log(x), se = FALSE,
                color = "red") + 
    geom_text_repel(aes(label = Country), color = "black", 
                    data = filter(EconomistData, Country %in% country_labels)) + 
    scale_x_continuous(name = "Corruption Perceptions Index, 2011 (10=least corrupt)",
                       limits = c(.9, 10.5),
                       breaks = 1:10) +
    scale_y_continuous(name = "Human Development Index, 2011 (1=Best)",
                       limits = c(0.2, 1.0),
                       breaks = seq(0.2, 1.0, by = 0.1)) +
    scale_color_manual(name = "",
                       values = c("#24576D",
                                  "#099DD7",
                                  "#28AADC",
                                  "#248E84",
                                  "#F2583F",
                                  "#96503F")) +
    ggtitle("Corruption and Human development") + 
    theme_minimal() + 
    theme(text = element_text(color = "gray20"),
          legend.position = c("top"),  
          legend.direction = "horizontal",
          legend.justification = 0.1, 
          legend.text = element_text(size = 11, color = "gray10"),
          axis.text = element_text(face = "italic"),
          axis.title.x = element_text(vjust = -1),
          axis.title.y = element_text(vjust = 2), 
          axis.ticks.y = element_blank(), 
          axis.line = element_line(color = "gray40", size = 0.5),
          axis.line.y = element_blank(),
          panel.grid.major = element_line(color = "gray50", size = 0.5),
          panel.grid.major.x = element_blank()
    )
  
  output$CPI_plot = renderPlot({
    base_plot
  })
  
}

shinyApp(ui, server)







# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------










# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------





# UI Defines how the app looks
ui <- fluidPage(
  # App title ----
  
  fluidPage(
    
    titlePanel("Interactive Corruption and Human Development Plot"),
    sidebarLayout(
      sidebarPanel(
        selectInput(
          "region_fit", "Fit by region?",
          c(Yes = "yes",
            No = "no"),
          selected = "no"
        ),
        
        conditionalPanel(
          condition = "input.region_fit == 'yes'",
          selectInput(
            "region", "Region",
            c("Asia_Pacific", "East_EU_Cemt_Asia", "MENA", "SSA", 
              "Americas", "EU_W._Europe")
          )
          
        )
        
      ),
      mainPanel(
        
      )
    )
    
  )
  
)

# Server does the computation behind the results displayed by the IU

# Define server logic ---
server <- function(input, output) {
  
  country_labels =  c("Russia", "Venezuela", "Iraq", "Myanmar", "Sudan",
                      "Afghanistan", "Congo", "Greece", "Argentina", "Brazil",
                      "United States", "Germany", "Britain", "Barbados", "Norway", 
                      "Japan", "New Zealand", "Singapore")
  
  base_plot = 
    ggplot(EconomistData, aes(x = CPI, y = HDI, color = Region)) + 
    geom_point(shape = 1, size = 3, stroke = 2) + 
    geom_smooth(method = "lm",
                formula = y ~ x + log(x), se = FALSE,
                color = "red") + 
    geom_text_repel(aes(label = Country), color = "black", 
                    data = filter(EconomistData, Country %in% country_labels)) + 
    scale_x_continuous(name = "Corruption Perceptions Index, 2011 (10=least corrupt)",
                       limits = c(.9, 10.5),
                       breaks = 1:10) +
    scale_y_continuous(name = "Human Development Index, 2011 (1=Best)",
                       limits = c(0.2, 1.0),
                       breaks = seq(0.2, 1.0, by = 0.1)) +
    scale_color_manual(name = "",
                       values = c("#24576D",
                                  "#099DD7",
                                  "#28AADC",
                                  "#248E84",
                                  "#F2583F",
                                  "#96503F")) +
    ggtitle("Corruption and Human development") + 
    theme_minimal() + 
    theme(text = element_text(color = "gray20"),
          legend.position = c("top"),  
          legend.direction = "horizontal",
          legend.justification = 0.1, 
          legend.text = element_text(size = 11, color = "gray10"),
          axis.text = element_text(face = "italic"),
          axis.title.x = element_text(vjust = -1),
          axis.title.y = element_text(vjust = 2), 
          axis.ticks.y = element_blank(), 
          axis.line = element_line(color = "gray40", size = 0.5),
          axis.line.y = element_blank(),
          panel.grid.major = element_line(color = "gray50", size = 0.5),
          panel.grid.major.x = element_blank()
    )
  
  output$CPI_plot = renderPlot({
    base_plot
  })
  
}

shinyApp(ui, server)







# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------



















# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------





# UI Defines how the app looks
ui <- fluidPage(
  # App title ----
  
  fluidPage(
    
    titlePanel("Interactive Corruption and Human Development Plot"),
    sidebarLayout(
      sidebarPanel(
        selectInput(
          "region_fit", "Fit by region?",
          c(Yes = "yes",
            No = "no"),
          selected = "no"
        ),
        
        conditionalPanel(
          condition = "input.region_fit == 'yes'",
          selectInput(
            "region", "Region",
            c("Asia_Pacific", "East_EU_Cemt_Asia", "MENA", "SSA", 
              "Americas", "EU_W._Europe")
          )
          
        )
        
      ),
      mainPanel(
        plotOutput("CPI_plot")
      )
    )
    
  )
  
)

# Server does the computation behind the results displayed by the IU

# Define server logic ---
server <- function(input, output) {
  
  country_labels =  c("Russia", "Venezuela", "Iraq", "Myanmar", "Sudan",
                      "Afghanistan", "Congo", "Greece", "Argentina", "Brazil",
                      "United States", "Germany", "Britain", "Barbados", "Norway", 
                      "Japan", "New Zealand", "Singapore")
  
  base_plot = 
    ggplot(EconomistData, aes(x = CPI, y = HDI, color = Region)) + 
    geom_point(shape = 1, size = 3, stroke = 2) + 
    geom_smooth(method = "lm",
                formula = y ~ x + log(x), se = FALSE,
                color = "red") + 
    geom_text_repel(aes(label = Country), color = "black", 
                    data = filter(EconomistData, Country %in% country_labels)) + 
    scale_x_continuous(name = "Corruption Perceptions Index, 2011 (10=least corrupt)",
                       limits = c(.9, 10.5),
                       breaks = 1:10) +
    scale_y_continuous(name = "Human Development Index, 2011 (1=Best)",
                       limits = c(0.2, 1.0),
                       breaks = seq(0.2, 1.0, by = 0.1)) +
    scale_color_manual(name = "",
                       values = c("#24576D",
                                  "#099DD7",
                                  "#28AADC",
                                  "#248E84",
                                  "#F2583F",
                                  "#96503F")) +
    ggtitle("Corruption and Human development") + 
    theme_minimal() + 
    theme(text = element_text(color = "gray20"),
          legend.position = c("top"),  
          legend.direction = "horizontal",
          legend.justification = 0.1, 
          legend.text = element_text(size = 11, color = "gray10"),
          axis.text = element_text(face = "italic"),
          axis.title.x = element_text(vjust = -1),
          axis.title.y = element_text(vjust = 2), 
          axis.ticks.y = element_blank(), 
          axis.line = element_line(color = "gray40", size = 0.5),
          axis.line.y = element_blank(),
          panel.grid.major = element_line(color = "gray50", size = 0.5),
          panel.grid.major.x = element_blank()
    )
  
  output$CPI_plot = renderPlot({
    base_plot
  })
  
}

shinyApp(ui, server)







# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
















# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------





# UI Defines how the app looks
ui <- fluidPage(
  # App title ----
  
  fluidPage(
    
    titlePanel("Interactive Corruption and Human Development Plot"),
    sidebarLayout(
      sidebarPanel(
        selectInput(
          "region_fit", "Fit by region?",
          c(Yes = "yes",
            No = "no"),
          selected = "no"
        ),
        
        conditionalPanel(
          condition = "input.region_fit == 'yes'",
          selectInput(
            "region", "Region",
            c("Asia_Pacific", "East_EU_Cemt_Asia", "MENA", "SSA", 
              "Americas", "EU_W._Europe")
          )
          
        )
        
      ),
      mainPanel(
        plotOutput("CPI_plot")
      )
    )
    
  )
  
)

# Server does the computation behind the results displayed by the IU

# Define server logic ---
server <- function(input, output) {
  
  country_labels =  c("Russia", "Venezuela", "Iraq", "Myanmar", "Sudan",
                      "Afghanistan", "Congo", "Greece", "Argentina", "Brazil",
                      "United States", "Germany", "Britain", "Barbados", "Norway", 
                      "Japan", "New Zealand", "Singapore")
  
  base_plot = 
    ggplot(EconomistData, aes(x = CPI, y = HDI, color = Region)) + 
    geom_point(shape = 1, size = 3, stroke = 2) + 
    geom_smooth(method = "lm",
                formula = y ~ x + log(x), se = FALSE,
                color = "red") + 
    geom_text_repel(aes(label = Country), color = "black", 
                    data = filter(EconomistData, Country %in% country_labels)) + 
    scale_x_continuous(name = "Corruption Perceptions Index, 2011 (10=least corrupt)",
                       limits = c(.9, 10.5),
                       breaks = 1:10) +
    scale_y_continuous(name = "Human Development Index, 2011 (1=Best)",
                       limits = c(0.2, 1.0),
                       breaks = seq(0.2, 1.0, by = 0.1)) +
    scale_color_manual(name = "",
                       values = c("#24576D",
                                  "#099DD7",
                                  "#28AADC",
                                  "#248E84",
                                  "#F2583F",
                                  "#96503F")) +
    ggtitle("Corruption and Human development") + 
    theme_minimal() + 
    theme(text = element_text(color = "gray20"),
          legend.position = c("top"),  
          legend.direction = "horizontal",
          legend.justification = 0.1, 
          legend.text = element_text(size = 11, color = "gray10"),
          axis.text = element_text(face = "italic"),
          axis.title.x = element_text(vjust = -1),
          axis.title.y = element_text(vjust = 2), 
          axis.ticks.y = element_blank(), 
          axis.line = element_line(color = "gray40", size = 0.5),
          axis.line.y = element_blank(),
          panel.grid.major = element_line(color = "gray50", size = 0.5),
          panel.grid.major.x = element_blank()
    )
  
  # Programming with ggplot:
  individual_fit = function(region) {
    list(geom_smooth(data = filter(EconomistData, Region %in% region),
                     method = "lm",
                     formula = y ~ x + log(x), se = FALSE,
                     color = "black"))
  }
  
  
  output$CPI_plot = renderPlot({
    base_plot
  })
  
}

shinyApp(ui, server)







# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------






















# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------


# UI Defines how the app looks
ui <- fluidPage(
  # App title ----
  
  fluidPage(
    
    titlePanel("Interactive Corruption and Human Development Plot"),
    sidebarLayout(
      sidebarPanel(
        selectInput(
          "region_fit", "Fit by region?",
          c(Yes = "yes",
            No = "no"),
          selected = "no"
        ),
        
        conditionalPanel(
          condition = "input.region_fit == 'yes'",
          selectInput(
            "region", "Region",
            c("Asia_Pacific", "East_EU_Cemt_Asia", "MENA", "SSA", 
              "Americas", "EU_W._Europe")
          )
          
        )
                
      ),
      mainPanel(
        plotOutput("CPI_plot")
      )
    )
    
  )
  
)

# Server does the computation behind the results displayed by the IU

# Define server logic ---
server <- function(input, output) {
  
   country_labels =  c("Russia", "Venezuela", "Iraq", "Myanmar", "Sudan",
                        "Afghanistan", "Congo", "Greece", "Argentina", "Brazil",
                        "United States", "Germany", "Britain", "Barbados", "Norway", 
                        "Japan", "New Zealand", "Singapore")
  
   base_plot = 
    ggplot(EconomistData, aes(x = CPI, y = HDI, color = Region)) + 
    geom_point(shape = 1, size = 3, stroke = 2) + 
    geom_smooth(method = "lm",
                formula = y ~ x + log(x), se = FALSE,
                color = "red") + 
    geom_text_repel(aes(label = Country), color = "black", 
                    data = filter(EconomistData, Country %in% country_labels)) + 
    scale_x_continuous(name = "Corruption Perceptions Index, 2011 (10=least corrupt)",
                       limits = c(.9, 10.5),
                       breaks = 1:10) +
    scale_y_continuous(name = "Human Development Index, 2011 (1=Best)",
                       limits = c(0.2, 1.0),
                       breaks = seq(0.2, 1.0, by = 0.1)) +
    scale_color_manual(name = "",
                       values = c("#24576D",
                                  "#099DD7",
                                  "#28AADC",
                                  "#248E84",
                                  "#F2583F",
                                  "#96503F")) +
    ggtitle("Corruption and Human development") + 
    theme_minimal() + 
    theme(text = element_text(color = "gray20"),
          legend.position = c("top"),  
          legend.direction = "horizontal",
          legend.justification = 0.1, 
          legend.text = element_text(size = 11, color = "gray10"),
          axis.text = element_text(face = "italic"),
          axis.title.x = element_text(vjust = -1),
          axis.title.y = element_text(vjust = 2), 
          axis.ticks.y = element_blank(), 
          axis.line = element_line(color = "gray40", size = 0.5),
          axis.line.y = element_blank(),
          panel.grid.major = element_line(color = "gray50", size = 0.5),
          panel.grid.major.x = element_blank()
    )
   
   individual_fit = function(region) {
     list(geom_smooth(data = filter(EconomistData, Region %in% region),
                      method = "lm",
                      formula = y ~ x + log(x), se = FALSE,
                      color = "black"))
   }
    
    
  output$CPI_plot = renderPlot({
    if(input$region_fit == "no") {
      base_plot
    } else if(input$region_fit == "yes") {
      base_plot + individual_fit(input$region)
    }
  })
  # add se option for the fits
}

shinyApp(ui, server)

# Exercise: add se (standard error option for the fits.)

# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------










































