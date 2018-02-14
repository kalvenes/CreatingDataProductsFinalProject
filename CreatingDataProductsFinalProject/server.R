#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to create regression model
shinyServer(function(input, output) {
  data("mtcars")
  depVars <- reactive("mpg~")
  depVars1 <- reactive({ifelse(input$cyl == TRUE, paste(depVars(),"cyl",sep=""),depVars())})
  depVars2 <- reactive({ifelse(input$disp == TRUE, paste(depVars1(),"+disp",sep=""),depVars1())})
  depVars3 <- reactive({ifelse(input$hp == TRUE, paste(depVars2(),"+hp",sep=""),depVars2())})
  depVars4 <- reactive({ifelse(input$drat == TRUE, paste(depVars3(),"+drat",sep=""),depVars3())})
  depVars5 <- reactive({ifelse(input$wt == TRUE, paste(depVars4(),"+wt",sep=""),depVars4())})
  depVars6 <- reactive({ifelse(input$qsec == TRUE, paste(depVars5(),"+qsec",sep=""),depVars5())})
  depVars7 <- reactive({ifelse(input$vs == TRUE, paste(depVars6(),"+factor(vs)",sep=""),depVars6())})
  depVars8 <- reactive({ifelse(input$am == TRUE, paste(depVars7(),"+factor(am)",sep=""),depVars7())})
  depVars9 <- reactive({ifelse(input$gear == TRUE, paste(depVars8(),"+gear",sep=""),depVars8())})
  depVars10 <- reactive({ifelse(input$carb == TRUE, paste(depVars9(),"+carb",sep=""),depVars9())})
  output$text1 <- renderText(paste("Base Model: mpg~factor(am)+wt+qsec"))
  output$text2 <- renderText(paste("Your Model: ",depVars10()))
  baseFit <- lm(mpg~factor(am)+wt+qsec,data=mtcars)
  output$summary <- renderPrint({
    custMod <- lm(depVars10(),data=mtcars)
    summary(custMod)
  })
  output$anovaRes <- renderPrint({
    anova(baseFit,lm(depVars10(),data=mtcars))
  })
  output$plot1 <- renderPlot({
    custMod <-lm(depVars10(),data=mtcars)
    plot(custMod, which=c(1:1), title("Residual Plot of Your Model"))
  })
  output$plot2 <- renderPlot({
    plot(baseFit, which=c(1:1), title("Residual Plot of Base Model"))
  })
})
