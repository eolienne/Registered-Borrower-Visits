library(shiny)
library(choroplethr)
library(choroplethrMaps)

setwd("C:/Users/Alyssa/Box Sync/Programming Projects/IMLSdata/Registered-Borrower-Visits/Data")
load("all_data.rdata")

data(df_all_data, package="choroplethr")
year_choices = colnames(df_all_data)[2:ncol(df_all_data)]

shinyUI(fluidPage(
  
  titlePanel("Annual public library registered borrower visits"),
  div(HTML("By <a href='https://iskati.wordpress.com/'>Alyssa Hislop</a>. Source code <a href='https://github.com/eolienne/Registered-Borrower-Visits'>here</a>.")),
  
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId  = "year", 
                  label    = "Year",
                  choices  = 2007:2013,
                  selected = 2013),
      
      sliderInput(inputId = "num_colors",
                  label   = "Select number of colors",
                  min     = 1,
                  max     = 9,
                  value   = 1)),
    
    mainPanel(
      plotOutput("stateMap"),
      plotOutput("countyMap")
    )
  )
))