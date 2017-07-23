# notebook to start with features 
# First, pull in all equities from AMEX, NYSE and NASDAQ

# next, plot a candle stock chart with n day simple moving averages 
# variable naming conventions
# dfXXXXX  dataframe
# vectXXXX vector
# varXXXX  variable 
# tdfXXXXX tidyQuant tibble DF



require(quantmod)
require(dplyr)
require(reshape2)
require(tidyquant)
require(ggplot2)
require(Hmisc)

# get a list of all listed securities 
# stockSymbols gets all listed securities rom AMEX, NASDAQ and NYSE 
# returns genaral infromation about the company, including IPO year, 
# Maket Cap, Last Sale, IPO year, Sector, Inudstry, and Exchange 

dfSymbols <- stockSymbols()

tdfStockSymData <- tq_get("CBOE", get = "stock.prices", from = "2016-01-01")

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

funcPlotCandleSMA(tdfStockSymData,"CBOE")
