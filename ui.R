library(shiny)
library(scales)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  h2("Modified Dietz vs. Time Weighted Return"),
  h5("Why it's possible to get negative return when you're making money"),
  a("A one-day build by Sshawn", href="https://sshawn.com", target="_blank"),
  withMathJax(),
  
  fluidRow(
    column(5,
           wellPanel(
             h4("Scenario"),
             h5('Assume starting fund value of $ 1,000'),
             sliderInput("endValue", "Ending Portfolio Value ($)", 0, 5000, 2000, step=50, pre="$"),
             sliderInput("cashDate", "Date of cash in/out", 1, 31, 19, step=1, post=" Jan"),
             sliderInput("cash", "Cash in/out ($)", -1000, 5000, 1500, step=100, pre="$"),
             sliderInput("valueOnInjection", "On cash in/out date, how much is your portfolio valued, including cash ($)", 0, 5000, 3500, step=50, pre="$")
           )),
    column(7,
           wellPanel(
             plotOutput('equity', height=250),
             # titlePanel("Your Performance: "),
             h5("Naive return:"),
             textOutput('naiveReturn'),
             h5('Modified Dietz return:'),
             textOutput('mdReturn'),
             h5('Time Weighted return:'),
             textOutput('twReturn')
           ))
  ),
  p("Reference: "),
  a("http://dailyvest.com/prr/prr_calcmethods.aspx", href="http://dailyvest.com/prr/prr_calcmethods.aspx", target="_blank")
))
