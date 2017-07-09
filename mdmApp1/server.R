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
 
#  comment this out to to use reactiveValues and observeEvent 
#  to diplay different values based on slider input depending on 
#  which button is pressed, uniform distribution or normal distribution 
#  data <- eventReactive(input$go, {
#    rnorm(input$num)
#  })

# first, default to normal distribution with 50 values
  rv <- reactiveValues(data = rnorm(50))
  
  observeEvent(input$norm, {rv$data <- rnorm(input$num)})
  observeEvent(input$unif, {rv$data <- runif(input$num)})
  
  output$hist <- renderPlot( {
    hist(rv$data)
  })
  
  output$txt <- renderPrint( {
    summary(rv$data)
  })
  
}


