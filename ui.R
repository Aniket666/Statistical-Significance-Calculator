library(shiny)

shinyUI(
  fluidPage(
    titlePanel(title = "Dashboard"),
    
    sidebarLayout(
      sidebarPanel(
      
        textInput("groups", "Enter comma separated groups"),
        textInput("category", "Enter cpmma separared categories"),
        textInput("counts", "Enter comma separated counts for each category"),
        actionButton("btnTest", "Test")
        
      ),
      
      
      mainPanel(
        "Statistical Significance", textOutput("significance")
        )
      )
    )
  )
