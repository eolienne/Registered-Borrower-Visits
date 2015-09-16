#This will be the server file for the % borrowers per state over time
shinyServer(function(input, output) {
  
  # You can access the value of the widget with input$select, e.g.
  output$value <- renderPrint({ input$select })
  
})