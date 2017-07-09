#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
fluidPage(
  # change from having one action button to having 2 action buttons. 
  # change the display label on the actionButtons. 
  
  sliderInput("num", "Choose a Number", 1, 100, 50), 
  actionButton("norm", "Normal Distribution"),
  actionButton("unif", "Uniform Distribution"),
  plotOutput("hist"),
  verbatimTextOutput("txt")
)
