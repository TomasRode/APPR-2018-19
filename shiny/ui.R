library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Izobraževanje v državah OECD"),
  sidebarLayout(
    sidebarPanel(
      sliderInput('steviloSkupin', 'Število skupin', min = 2, max = 20, value = 4)
    ),
    mainPanel(
      plotOutput('Rzemljevid')
    )
  )
))
