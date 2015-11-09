library(shiny)
library(choroplethr)
library(choroplethrMaps)
library(ggplot2)

load("./Data/all_data.rdata")

data("all_data")

options(shiny.error=browser)

shinyServer(function(input, output) {
  
  output$stateMap = renderPlot({
    # add a progress bar
    progress = shiny::Progress$new()
    on.exit(progress$close())
    progress$set(message = "Creating image. Please wait.", value = 0)
    
    year = as.numeric(input$year)
    df1$value= df1[,input$year]
    state_choropleth(df1, num_colors = input$num_colors)
  })
  
  
  
})