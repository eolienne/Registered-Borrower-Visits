devtools::install_github("ropensci/plotly")
library(plotly)
library(ggplot2)


df <- read.csv("C:/Users/Alyssa/Box Sync/Programming Projects/IMLSdata/Registered-Borrower-Visits/all_data.csv")
df$hover <- with(df, paste(region, '<br>', "X2008", X2008))
# give state boundaries a white border
l <- list(color = toRGB("white"), width = 2)
# specify some map projection/options
g <- list(
  scope = 'usa',
  projection = list(type = 'albers usa'),
  showlakes = TRUE,
  lakecolor = toRGB('white')
)

df <- Filter(Negate(is.null), df)


plot_ly(df, z = X2008, text = hover, locations = code, type = 'choropleth',
        locationmode = 'USA-states', color = X2008, colors = 'Purples',
        marker = list(line = l), colorbar = list(title = "Visits per regbor"),
        #plotly_POST(df, "borrowers", fileopt="new", world_readable = TRUE)%>%
        layout(title = 'Borrowers<br>(Hover for breakdown)', geo = g))