library(shiny)
library(mlbench)
data("BostonHousing2")
shinyServer(function(input, output) {
  BostonHousing2$mpgsp <- ifelse(BostonHousing2$crim - 20 > 0, BostonHousing2$crim - 20, 0)
  model1 <- lm(medv ~ crim, data = BostonHousing2)
  model2 <- lm(medv ~ crim + mpgsp, data = BostonHousing2)

  model1pred <- reactive({
    mpgInput <- input$sliderMPG
    predict(model1, newdata = data.frame(crim = mpgInput))
  })

  model2pred <- reactive({
    mpgInput <- input$sliderMPG
    predict(model2, newdata =
              data.frame(crim = mpgInput,
                         mpgsp = ifelse(mpgInput - 20 > 0,
                                        mpgInput - 20, 0)))
  })

  output$plot1 <- renderPlot({
    mpgInput <- input$sliderMPG

    plot(BostonHousing2$medv, BostonHousing2$crim, xlab = "Per Capita Crime Rate",
         ylab = "House Price", bty = "n", pch = 16,
         xlim = c(1, 100), ylim = c(5, 50))
    if(input$showModel1){
      abline(model1, col = "red", lwd = 2)
    }
    if(input$showModel2){
      model2lines <- predict(model2, newdata = data.frame(
        crim = 1:100, mpgsp = ifelse(1:100 - 20 > 0, 1:100 - 20, 0)
      ))
      lines(1:100, model2lines, col = "blue", lwd = 2)
    }
    legend(25, 250, c("Model 1 Prediction", "Model 2 Prediction"), pch = 16,
           col = c("red", "blue"), bty = "n", cex = 1.2)
    points(mpgInput, model1pred(), col = "red", pch = 16, cex = 2)
    points(mpgInput, model2pred(), col = "blue", pch = 16, cex = 2)
  })

  output$pred1 <- renderText({
    model1pred()*1000
  })

  output$pred2 <- renderText({
    model2pred()*1000
  })
})
