# ui.R

shinyUI(fluidPage(
  titlePanel("Circulation data!"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Create a map of circulation statistics"),
      
      selectInput("var", 
                  label = "Choose a variable to display",
                  choices = c("Ebooks per capita", "Audio download"),
                  selected = "Ebooks per capita"),
      
      sliderInput("range", 
                  label = "Range of interest:",
                  min = 0, max = 2, value = c(0, 2))
    ),
    
    mainPanel(plotOutput("map"))
  )
))