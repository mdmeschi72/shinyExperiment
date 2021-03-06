#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
require(quantmod)
require(dplyr)
require(reshape2)
require(tidyquant)
require(ggplot2)
require(Hmisc)

# Define UI for application that draws a histogram
fluidPage(
  
  tabsetPanel(
    ################ Equity information panel #############################
    tabPanel("Equity Information", 
              sidebarLayout(
                sidebarPanel(
                  textInput("varSym", "Input Listed Security Symbol"),
                  actionButton("varAction", "Retrieve Information")
                ), # sidebarPanel
            mainPanel(
            plotOutput("plotCandle"),
            verbatimTextOutput("sum")
          )#mainPanel
        ) # sidebarLayout
      ), # tabPanel
    
    ############### Option Chain ###########################################
    tabPanel("Option Chain",
             basicPage(
               h2('The Option Chain'),
               dataTableOutput('myOptionChainTable')
             )
    ),
    
    ############### Option Information #####################################
    tabPanel("Option Informaton",
             sidebarLayout(
               sidebarPanel(
                textInput("optVal", "Input Option"),
                actionButton("varOptAction", "Retrieve Option Information")
               ), # sidebarPanel
              mainPanel()
             ) # sidebarLayout
            ) # tabPanel
    ) #tabsetPanel
)
