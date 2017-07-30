install.packages('Hmisc')
install.packages('RCurl')
install.packages('jsonlite')

library(RCurl)
library(jsonlite)
library(quantmod)


optionsSymbols <- getOptionChain("AAPL", Exp = NULL)

#TODO - fix loop code to do the following
#         1 - Try with equities other than AAPL
for(i in seq_along(optionsSymbols)) {
  dfLoopSampleCalls <- optionsSymbols[[i]]$calls
  dfLoopSampleCallsNames <- data.frame(row.names(dfLoopSampleCalls), stringsAsFactors = FALSE)
  colnames(dfLoopSampleCallsNames) <- "OptionSym"
  dfCalls <- bind_cols(dfLoopSampleCallsNames,dfLoopSampleCalls)
  if (i == 1)
  {
    dfCallsToBind <- dfCalls
  }
  else
  {
    dfCallsToBind <- bind_rows(dfCalls,dfCallsToBind)
  }
  
  dfLoopSamplePuts <- optionsSymbols[[i]]$puts
  dfLoopSamplePutsNames <- data.frame(row.names(dfLoopSamplePuts), stringsAsFactors = FALSE)
  colnames(dfLoopSamplePutsNames) <- "OptionSym"
  dfPuts <- bind_cols(dfLoopSamplePutsNames, dfLoopSamplePuts)
  
  if (i==1)
  {
    dfPutsToBind <- dfPuts
  }
  else
  {
    dfPutsToBind <- bind_rows(dfPuts,dfPutsToBind)
  }
  
 
}

dfOut <- bind_rows(dfCallsToBind,dfPutsToBind)

dfOut <- separate(bind_rows(dfCallsToBind,dfPutsToBind), 'OptionSym', c('ClassSym', 'Expiry', 'P/C','Strike1'), c(4,10,11,19), convert = TRUE)

dfSep <- separate(dfOut, 'OptionSym', c('ClassSym', 'Expiry', 'PutCall', 'Strikes'), c(4,10,11,19) )

dfOut2 <- select(dfOut, -'NA')


convertOptionChain <- function(inList) {
  
  for(i in seq_along(inList)) {
    dfLoopSampleCalls <- inList[[i]]$calls
    dfLoopSampleCallsNames <- data.frame(row.names(dfLoopSampleCalls), stringsAsFactors = FALSE)
    colnames(dfLoopSampleCallsNames) <- "OptionSym"
    dfCalls <- bind_cols(dfLoopSampleCallsNames,dfLoopSampleCalls)
    if (i == 1)
    {
      dfCallsToBind <- dfCalls
    }
    else
    {
      dfCallsToBind <- bind_rows(dfCalls,dfCallsToBind)
    }
    
    dfLoopSamplePuts <- inList[[i]]$puts
    dfLoopSamplePutsNames <- data.frame(row.names(dfLoopSamplePuts), stringsAsFactors = FALSE)
    colnames(dfLoopSamplePutsNames) <- "OptionSym"
    dfPuts <- bind_cols(dfLoopSamplePutsNames, dfLoopSamplePuts)
    
    if (i==1)
    {
      dfPutsToBind <- dfPuts
    }
    else
    {
      dfPutsToBind <- bind_rows(dfPuts,dfPutsToBind)
    }
    
    
  }
  
  dfOut <- bind_rows(dfCallsToBind,dfPutsToBind)
  

  return(dfOut)
}