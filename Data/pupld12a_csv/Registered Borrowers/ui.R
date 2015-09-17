shinyUI(fluidPage (
  titlePanel("Percentage of state population as registered library borrowers"),
  div(HTML("By <a href='http://wwww.twitter.com/alyssa_briggs'>Alyssa Hislop</a>. Source code here.")),
  
  sidebarLayout(position="right"),
   sidebarPanel("sidebar panel"),
   mainPanel("main panel"),

#Creating a dropdown selector to toggle between years of data 
  selectInput("select", label = h3("Select box"), 
              choices = list("FY 2012" = 1, "FY 2011" = 2, "FY 2010" = 3), 
              selected = 1),
  
  hr(),
  fluidRow(column(3, verbatimTextOutput("value")))
  
  ))

