#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
data("mtcars")
varLabs <- colnames(mtcars)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Motor Trends Regression Model"),
  
  # Sidebar with a checkbox input for selection of model variables 
  sidebarLayout(
    sidebarPanel("This shiny app lets you customize a regression model by selecting
                  dependent variables to model fuel efficiency (mpg) of the cars in the sample.
                  You select model variables by checking the box for the variable and then
                  clicking on the 'Submit' button.",
      checkboxInput("cyl", varLabs[2], value = TRUE),
      checkboxInput("disp", varLabs[3], value = TRUE),
      checkboxInput("hp", varLabs[4], value = TRUE),
      checkboxInput("drat", varLabs[5], value = TRUE),
      checkboxInput("wt", varLabs[6], value = TRUE),
      checkboxInput("qsec", varLabs[7], value = TRUE),
      checkboxInput("vs", varLabs[8], value = TRUE),
      checkboxInput("am", varLabs[9], value = TRUE),
      checkboxInput("gear", varLabs[10], value = TRUE),
      checkboxInput("carb", varLabs[11], value = TRUE),
      submitButton("Submit"),
      "The output comprises (1) an ANOVA analysis that compares your model to the base model;
      (2) a residual plot of your model; (3) a residual plot of the base model; and (4) the
      regression output (coefficicients, standard errors, and p-values) for your model."
    ),
#      Your model will be created automatically and a multiple regression will be run.
#      The results are displayed as follows:
#        1.     An ANOVA analysis that compares your model to the base model
#      2.     A residual plot of your model
#      3.     A residual plot of the base model
#      4.     The regression output (coefficients and significance) for your model   ),
    # Show a plot of the generated distribution
    mainPanel(
      textOutput("text1"),
      textOutput("text2"),
      verbatimTextOutput("anovaRes"),
      plotOutput("plot1"),
      plotOutput("plot2"),
      verbatimTextOutput("summary")
    )
  ))
)
