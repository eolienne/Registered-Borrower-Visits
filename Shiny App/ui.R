library(shiny)
library(choroplethr)
library(choroplethrMaps)
library(ggplot2)


load("./Data/all_data.rdata")

data(all_data)

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