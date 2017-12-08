library(shiny)
library(gtools)

shinyServer(
  function(input, output){
   
    
    
    SignificanceTest <- eventReactive(input$btnTest, {
      groupString <- input$groups
      categoryString <- input$category
      countsString <- input$counts
      
      
      #group calculations
      groupString <- strsplit(groupString, ",")
      allGroups <- groupString[[1]]
      
      #category calculation
      allCat <- vector()
      categoryString <- strsplit(categoryString, ",")
      
      for(i in 1:length(groupString[[1]])){
        allCat <- c(allCat, categoryString[[1]])
      }
      
      combos <- nrow(combinations(n = length(allCat), r = length(allGroups)))
      #counts calculation
      allCounts <- vector()
      countsString <- strsplit(countsString, ",")
      for(i in 1:length(groupString[[1]])){
        allCounts <- c(allCounts, countsString[[1]])
      }
      allCounts <- as.numeric(allCounts)
      
      EntireReportData <- data.frame(allGroups, allCat, allCounts)
      EntireReportTest <- xtabs(allCounts~allGroups+allCat, data = EntireReportData)
      EntireReportTestchi <- chisq.test(EntireReportTest,correct = F)
      
      if(EntireReportTestchi$p.value < (0.05 / combos)){
        Result <- "Statistically Significant"
      } else {
        Result <- "Statistically insignificant"
      }
      
    })
      
      
    output$significance <- renderText(SignificanceTest())
    })