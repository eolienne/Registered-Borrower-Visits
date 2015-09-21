library(shiny)
library(choroplethr)
library(choroplethrMaps)

#Getting data from BOX
response <- GET(url="https://stanford.box.com/s/uh9k9z5pr32556pmrx5105eucnx20y3s")
load(rawConnection(response$content))

data("state.regions", package="choroplethrMaps")

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