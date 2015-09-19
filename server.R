#Using Ari Lamstein's server-final.R as a base

library(shiny)
library(choroplethr)
library(choroplethrMaps)

shinyServer(function(input, output) {
  
  output$stateMap = renderPlot({
    # add a progress bar
    progress = shiny::Progress$new()
    on.exit(progress$close())
    progress$set(message = "Creating image. Please wait.", value = 0)
    
    year                         = as.numeric(input$year)
    df_all_data$value  = df_all_data[, input$year]
    state_choropleth(df_all_data, num_colors = input$num_colors)
  })
  
  
  
})