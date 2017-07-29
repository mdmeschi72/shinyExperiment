#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)


function(input, output) {
  # function to take data and product a candlestick chart with 20, 50, 100 day moving averages 
  funcPlotCandleSMA <- function(inDf, inSym){
    
    gp <- inDf %>% ggplot(aes(x = date, y = close)) +
      geom_barchart(aes(open = open, high = high, low = low, close = close)) +
      geom_ma(ma_fun = SMA, n = 20, color = "green", linetype = 5, size = 1.25) +
      geom_ma(ma_fun = SMA, n = 50, linetype = 5, size = 1.25) +
      geom_ma(ma_fun = SMA, n = 200, color = "red", size = 1.25) + 
      labs(title = sprintf("%s Candlestick Chart", inSym), subtitle = "20, 50 and 200-Day SMA", y = "Closing Price", x = "Date") + 
      coord_x_date(xlim = c(max(inDf$date) - weeks(48), max(inDf$date)), ylim = c(min(inDf$low), max(inDf$high))) +
      theme_tq() 
    
    return(gp)
    
  }
  
  # get the data using tidyquant (may have to switch to quantMod if USDP does not upgrade to R version 3)
  # embed into reactive function to get symbol after the event button is pressed on the UI 
  tdfStockSymData <- eventReactive( input$varAction, {tq_get(input$varSym, get = "stock.prices", from = "2016-01-01")} )
  # create output candlestick chart 
  output$plotCandle <- renderPlot({
    funcPlotCandleSMA(tdfStockSymData(), input$varSym)
  })
  
  # print output data TODO - tidy this up 
  output$sum <- renderPrint({
    summary(tdfStockSymData())
  })
  
  listOptionChain <- eventReactive( input$varAction, {getOptionChain(input$varSym, Exp = NULL)})
  
}


