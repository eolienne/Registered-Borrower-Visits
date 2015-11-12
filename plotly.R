#devtools::install_github("ropensci/plotly")
library(plotly)
library(ggplot2)

#Make sure you're authenticated

df <- read.csv("C:/Users/Alyssa/Box Sync/Programming Projects/IMLSdata/Registered-Borrower-Visits/all_data.csv")
df$hover <- with(df, paste(region, "<br>",X2008))
# give state boundaries a white border
l <- list(color = toRGB("white"), width = 2)
# specify some map projection
g <- list(
  scope = 'usa',
  projection = list(type = 'albers usa'),
  showlakes = TRUE,
  showcoastlines = FALSE, 
  showframe = FALSE,
  lakecolor = toRGB('white')
)

#df <- Filter(Negate(is.null), df)

p <- plot_ly(df, z = X2008, text = hover, type = 'choropleth', locations = code,
             locationmode = 'USA-states', color = X2008, colors = 'Purples',
             marker = list(line = l), colorbar = list(title = "Visits per regbor"))


plotly_POST(p, "borrowers", fileopt= "overwrite", world_readable = TRUE) 
