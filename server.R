library(shiny)
library(datasets)
library(caret)

# create a global variables holding the data frame
mpgData <- mtcars

# Define server logic required to plot various variables against
# mpg
shinyServer(function(input, output) {
  # create a global variable with a html rendered data frame
  output$table <- renderTable(mpgData)
  
  # Create a reactive expression for training a prediction model .
  # Recalculation will be triggered if input$variable is changed by user.
  modFit <- reactive({
    modFit <-
      train(subset(mpgData, select = input$variable),mpgData$mpg,method = "lm")
  })
  
  # Create a reactive expression for the summary of the prediction model.
  # Recalculation is triggered if the prediction model modFit is changed.
  output$summary <- renderPrint({
    summary(modFit())
  })
  
  # Create a reactive expression for the plot of the prediction model
  # It is triggered by the change of input$variable and prediction model
  # fit modFit.
  output$mpgPlot <- renderPlot({
    yhat <-
      predict(modFit(),newdata = subset(mpgData, select = input$variable))
    predcol <- subset(mpgData, select = input$variable)
    df <- cbind(predcol,mpgData$mpg)
    plot(df,col = "blue", main = paste("mpg ~", input$variable))
    df_pred <- cbind(predcol,yhat)
    lines(df_pred,col = "red")
  })
  
})