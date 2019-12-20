
#install.packages('rJava', type='binary')
library(shiny)
library(ggplot2)
library(shinydashboard)
library(shinythemes)
library(d3heatmap)
options(java.parameters = "-Xmx5g")
#dyn.load('/Library/Java/JavaVirtualMachines/jdk-9.jdk/Contents/Home/lib/server/libjvm.dylib')
#library(rJava)
#library(bartmachine)
library(BART)
#set_bart_machine_num_cores(4)

#setwd("~/Downloads/bayesian_ML/iBAG")
source("fun_survbart.R")


header<- dashboardHeader(
  
  title = "Intergrative Bayesian analysis of multi-platform genomics data",
  titleWidth = 700
)






body<- dashboardBody(
            
            fluidRow(img(src='ibag.png',align="left"),
                     
                     p("iBAG is short for integrative Bayesian analysis of high-dimensional multiplatform genomics data. iBAG is a general framework for integrating information across genomic, transcriptomic and epigenetic data. Briefly, iBAG uses a novel hierarchical procedure by breaking the modeling into two parts, a mechanistic component that clarifies the molecular behaviors, mechanisms and relationships between and within the different types of molecular platforms. Subsequently, a clinical component that utilizes this information to assess associations between the phenotypes and clinical outcomes that characterize cancer development and progression (e.g. survival times, treatment arms, response to chemotherapy and tumor [sub]-types). The  Figure shows a schematic representation of the iBAG modeling strategy. The statistical formulation of the iBAG models can be found",a('here', href='http://www.ncbi.nlm.nih.gov/pubmed/23142963'),"and", a('here', href='http://www.ncbi.nlm.nih.gov/pubmed/24053265'),". A standalone version of this code along with an example dataset is available at" , a('here', href='http://odin.mdacc.tmc.edu/~vbaladan/Veera_Home_Page/iBAG.zip'),"."),
                     box(title = "Input Data", status = "primary",width = 4, background = "black", "If you understand the data format to input for the app click the button to proceed", actionButton("inButton", "Input data for iBAG",icon = icon("play"),style="success"))
                     
            ),
            fluidRow(
              
              
              
              box(title = "This app requires the following data in the format described below", status = "primary",width = 12, background = "black",
                  
                  fluidRow( box(title = "Input format for clinical data", status = "primary",width = 4, background = "black",p("The rows should represent the individuals and the  2 columns should be the individual Id and the response (Binary, Continuous, Survival)."), img(src='sdata.png') ),
                            
                            fluidRow(   box(title = "Input format for mRNA data", status = "primary",width = 7, background = "black", p("The rows should be individuals and the columns should be the genes."), img(src='mrnadata.png') ),
                                        
                                        
                                        
                                        box(title = "Input format for genomic data(Methylation/CNA)", status = "primary",width = 7, background = "black", p("The rows should be individuals and the columns should be markers. Each marker name should include the name of the gene it is present in."), img(src='gdata.png') )
                                        
                                        
                            )
                            
                  )
                  
              )
              
            ),
            
            
            
            
            
    
            fluidRow(
              box(title = "Input multi-platform Genomics Data", status = "primary", solidHeader = TRUE, width=6,
                  checkboxInput("cn", label = "Copy Number"),
                  conditionalPanel(
                    condition = "input.cn==true",
                    fileInput('cnfile', 'Input Copy Number Data File')
                  ),
                  
                  checkboxInput("meth", label = "DNA Methylation"),
                  conditionalPanel(
                    condition = "input.meth==true",
                    fileInput('methfile', 'Input DNA Methylation Data File')
                  ),
                  checkboxInput("mrna", label = "MRNA Expression"),
                  conditionalPanel(
                    condition = "input.mrna==true",
                    fileInput('mrnafile', 'Input mRNA Expression Data File')
                  )),
              
              box(title = "Input Clinical Response Data", status = "primary", solidHeader = TRUE, width=6,
                  selectInput("rdata", label = h3(" Select data type"),
                              choices = list("None"=0,"Continuous" = 2,
                                             "Survival (Uncensored)" = 3),selected=0),
                  conditionalPanel(
                    condition = "input.rdata>0",
                    fileInput('rfile', paste("Input clinical data file"))
                  ))),
            
            sliderInput("mruns", "Number of MCMC Runs (Burn in is 5% of runs) (Calibrate the number of runs according to the computer it is being run on) :",
                        min = 10, max = 10000, value = 10, step= 100),
            
            fluidRow(
              box(title = "Input Data summary", status = "primary",width = 4, background = "black",
                  tableOutput('mytable')),
              
              
              box(title = "Run Analysis", status = "primary",width = 4, background = "black", "If you conform with the input data summary press the button to run the analysis", actionButton("goButton1", "Run linear iBAG!",icon = icon("play"),style="success"), actionButton("goButton2", "Run bart iBAG!",icon = icon("play"),style="success")),
              box(title="RMSE:", status = "primary",width = 4, background = "black",textOutput("rmse"))
            
            
            
            
            
   
  )
)



ui<-dashboardPage(skin = "blue",header,body)
server<-function(input,output,session){
  
  global <- reactiveValues()
  
  df1<-eventReactive(input$goButton1, {
    
    withProgress(message = 'Fitting Mechanistic Model', value = 1/10, {})
    return(list())
    
})

  output$col <- renderUI({
    
  #  selectInput("gene", "Select the Gene",  global$cname)
  })
  
  
  output$rmse<-renderText({
    df()$rmse
  })
  
 




}
shinyApp(ui=ui,server=server)
