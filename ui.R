library(shiny)
library(mlbench)
data("BostonHousing2")
shinyUI(fluidPage(
  titlePanel("Predicting House Price in Boston from Per Capita Crime Rate"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("sliderMPG", "What is the per capita crime rate in the area?", 1, 100, value = 20),
      checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
      checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE)
    ),
    mainPanel(
      plotOutput("plot1"),
      h3("Predicted DOllar Price from Model 1:"),
      textOutput("pred1"),
      h3("Predicted DollarPrice from Model 2:"),
      textOutput("pred2")
    )
  )
))
