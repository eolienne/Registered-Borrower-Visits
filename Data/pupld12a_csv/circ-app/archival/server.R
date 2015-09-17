# server.R

library(maps)
library(mapproj)
source("helpers.R")

shinyServer(
  function(input, output) {
    output$map <- renderPlot({
      data <- switch(input$var, 
                     "Ebooks per capita" = staffcirc$MY_NEW_COLUMN,
                     "Audio download" = staffcirc$AUDIO_DL)
      
      percent_map(var = data, color = "blue", legend.title = "legend title", max = 2, min = 0)
    })
  }
)