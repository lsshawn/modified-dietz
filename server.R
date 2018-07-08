#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

startValue = 1000
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  df = reactive({
    data.frame(date = c(1, as.numeric(input$cashDate), 31),
               value = c(startValue, input$valueOnInjection, input$endValue)) 
  })
  
  naiveReturn = reactive({
    # assume 1000 starting value
    percent((input$endValue - startValue) / startValue)
  })
  
  mdReturn = reactive({
    denominator = startValue + ((31 - input$cashDate) / 31) * input$cash
    numerator = input$endValue - startValue - input$cash
    
    percent(numerator / denominator)
  })
  
  twReturn = reactive({
    firstPeriod = (input$valueOnInjection - input$cash - startValue) / startValue
    secondPeriod = (input$endValue - input$valueOnInjection) / input$valueOnInjection
    
    percent((1 + firstPeriod) * (1 + secondPeriod) - 1)
  })
  
  output$naiveReturn = naiveReturn
  output$mdReturn = mdReturn
  output$twReturn = twReturn
  output$equity = renderPlot({
    ggplot(data=df(), aes(x=date, y=value, group=1)) +
      geom_area(fill="dodgerblue", alpha=0.7) +
      scale_x_continuous(expand = c(0, 0), limits = c(1, 31)) +
      xlab('Date') + ylab('Portfolio ($)') +
      theme(axis.text.x = element_blank(),
            axis.ticks = element_blank(),
            panel.grid.major = element_blank()) +
    theme_minimal()
  })
})
