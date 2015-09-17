shinyUI(fluidPage(
  titlePanel("Public library stats 2012"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Create maps from the 2012 IMLS data"),
      
      selectInput("var", 
                  label = "Choose a variable to display",
                  choices = c("Total visits", "Total registered borrowers",
                              "Total circulation", "Total children's programming"),
                  selected = "Total visits"),
      
      sliderInput("range", 
                  label = "Range of interest:",
                  min = 0, max = 100, value = c(0, 100))
      ),
    
    mainPanel(plotOutput("pleth"))
  )
))