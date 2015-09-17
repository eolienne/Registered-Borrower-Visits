#Using Ari Lamstein's ui.R as a base

library(shiny)
library(choroplethrMaps)

data(df_state_demographics, package="choroplethr")
demographic_choices = colnames(df_state_demographics)[2:ncol(df_state_demographics)]

shinyUI(fluidPage(
  
  titlePanel("Annual public library registered borrower visits"),
  div(HTML("By <a href='https://iskati.wordpress.com/'>Alyssa Hislop</a>. Source code <a href='https://github.com/eolienne/Registered-Borrower-Visits'>here</a>.")),
  
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId  = "year", 
                  label    = "Year",
                  choices  = 2011:2012,
                  selected = 2012),
      
      sliderInput(inputId = "num_colors",
                  label   = "Select number of colors",
                  min     = 1,
                  max     = 9,
                  value   = 7)),
    
    mainPanel(
      plotOutput("stateMap"),
      plotOutput("countyMap")
    )
  )
))