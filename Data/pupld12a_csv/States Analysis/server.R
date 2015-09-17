library(maps)
library(mapproj)
library(choroplethr)

setwd("C:/Users/Alyssa/Box Sync/Programming Projects/Library stats/pupld12a_csv/States Analysis")

#RDS file has already been created and saved in the Data directory through the rawtotalvisits.R script
#readRDS is where I keep having problems: "Error in readRDS("Data/states.Rds") : unknown input format"
states <- readRDS("Data/states.Rds")
#readRDS(states)
setwd("C:/Users/Alyssa/Box Sync/Programming Projects/Library stats/pupld12a_csv/States Analysis/Data")

data(states, package="maps")
states = data.frame(states)

shinyServer(
  function(input, output) {
    
    output$pleth <- renderPlot({pleth=state_choropleth(states, title="exploring library data", num_colors = 7)
      data <- switch(input$var,
          "Total visits" = states$value, 
          "Total registered borrowers" = states$REGBOR,
          "Total circulation" = states$TOTCIR, 
          "Total children's programming" = states$KIDPRO)
      
    })
      
  }
    )
    


    