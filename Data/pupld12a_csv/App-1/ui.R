library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  titlePanel("title panel"),
  sidebarLayout(
    sidebarPanel(),
    mainPanel(
      h1("Cats"),
      h2("Dogs"),
      h3("Horses"),
      p("This is a paragraph"),
      div("my little pony")
      )
  )
))