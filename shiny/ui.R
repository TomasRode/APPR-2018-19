library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Razvrščanje"),
  sidebarLayout(
    sidebarPanel(
      sliderInput('steviloSkupin', 'Število skupin', min = 2, max = 10, value = 4)
    ),
    mainPanel(
      plotOutput('Rzemljevid')
    )
  )
))
