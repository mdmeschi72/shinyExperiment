#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
function(input, output) {
   
#  data <- reactive({rnorm(input$num)})
# using event reactive waits for user to press the button before redrawing the histogram 
  
  data <- eventReactive(input$go, {
    rnorm(input$num)
  })
  
  output$hist <- renderPlot( {
    hist(data())
  })
  
  output$txt <- renderPrint( {
    summary(data())
  })
  
}


