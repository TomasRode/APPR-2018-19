library(shiny)

shinyServer(function(input, output) {
  output$Rzemljevid <- renderPlot({
    NaslikajRazvscanje(input$steviloSkupin)
  })
})
