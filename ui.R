library(shiny)

shinyUI(fluidPage(
  # Application title
  titlePanel("Prediction of Miles Per Gallon"),
  
  # Sidebar with controls to select the prediction variable to create a prediction model to predict mpg.
  sidebarLayout(sidebarPanel(
    selectInput(
      "variable", "Predictor Variable:",
      c(
        "Cylinders" = "cyl",
        "Transmission" = "am",
        "Gears" = "gear",
        "Horse Power" = "hp",
        "Weight" = "wt"
      )
    ),
    p(
      "This shiny application works with the R built-in mtcars data frame.
      Select a predictor variable from the input widget above and the shiny app creates a linear prediction model for predicting mpg given the chosen predictor variable. Then in the tab Plot the observed mpgs (blue colored dots) are printed along with the predicted mpg (red colored line). In tab Summary the summary of the prediction model is printed. In the tab Table the data frame mtcars is listed for the user's reference."
    )
    
    ),
    
    # create a main panel with tabs for the plot, the prediction model summary and the data table of mtcars data frame.
    
    mainPanel(
      tabsetPanel(
        type = "tabs",
        tabPanel("Plot", plotOutput("mpgPlot")),
        tabPanel("Summary", verbatimTextOutput("summary")),
        tabPanel("Table", tableOutput("table"))
      )
    ))
))