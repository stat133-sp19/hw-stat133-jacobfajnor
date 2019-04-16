library(shiny)
library(ggplot2)
library(reshape2)
#' @title: Future Value Function
#' @description: gives the future value of an asset under a fixed interest rate.
#' @param: amount = inital dollar amount 
#' @param: rate = interest rate
#' @param: years = years amount has been in the account.
#' @return: future_value

future_value <- function(amount, rate, years) {
  future_value <- amount*((1 + rate)^years)
  return(future_value)
}


## Future Value of Annuity

#' @title: Future Value Function of Annuity
#' @description: gives the future value of an asset under a fixed interest rate given intervals of adding outside funds.
#' @param: contrib = interval contribution amount.
#' @param: rate = interest rate
#' @param: years = years amount has been in the account.
#' @return: annuity

annuity <- function(contrib, rate, years) {
  annuity <- contrib*((((1+rate)^years)-1)/rate)
  return(annuity)
}

## Future Value of Growing Annuity

#' @title: Future Value Function of Growing Annuity
#' @description: gives the future value of an asset under a fixed interest rate given intervals of adding outside funds at an increasing rate.
#' @param: contrib = contribution amount.
#' @param: rate = interest rate
#' @param: growth = annual growth rate
#' @param: years = years amount has been in the account.
#' @return: growing_annuity 

growing_annuity <- function(contrib, rate, growth, years) {
  growing_annuity <- contrib*((((1+rate)^years)-((1+growth)^years))/(rate-growth))
  return(growing_annuity)
}

ui <- fluidPage(
  
  # App title ----
  titlePanel("Financial Modalities"),
  

    
    # options
    fluidRow(
      
      column(4, 
      
      # Input: Initial Amount
       sliderInput("initial", "Principal:",
                  min = 0, max = 100000,
                  value = 1000, step = 500),
      
      # Input: annual contribution
      sliderInput("contrib", "Annual Contribution",
                  min = 0, max = 50000,
                  value = 2000, step = 500)
      ),
      column(4, offset = 0.4, 
      # Input: return rate
      sliderInput("rate", "Return Rate:",
                  min = 0, max = 20,
                  value = .05, step = .1),
      
      
      # Input: growth rate
      sliderInput("grate", "Growth Rate:",
                  min = 0, max = 20,
                  value = 5, step = .1)
      ),
      column(4,
    # Input: Years
        sliderInput("years", "Years:",
                  min = 0, max = 50,
                  value = 20, step = 1),
    # Input Facet
    selectInput("facet", "Facet?:",
                choices = c("Yes", "No"))
      ),
 
    
    # output
    
      
      # Output: graph
    mainPanel(hr(),
    h4("Timeline Graph"),
      plotOutput("return_plot"),
    h4("Balances"),
      verbatimTextOutput("table")
      
   )))



# Define server logic for slider examples ----
server <- function(input, output) {
  
  # Reactive expression to create data frame of all input values ----
  # R code goes here
  balances <- reactive({
    balances <- data.frame(
      years = 0:input$years,
      no_contrib = rep(1000, input$years + 1), 
      fixed_contrib = rep(1000, input$years + 1),
      growing_contrib = rep(1000, input$years + 1)
    )
    
    for (i in 1:input$years) {
      balances$no_contrib[i + 1] <- future_value(input$initial, input$rate/100, i + 1)
    }
   
    for (i in 1:input$years) {
      balances$fixed_contrib[i + 1] <- future_value(input$initial, input$rate/100, i + 1) + annuity(input$contrib, input$rate/100, i)
    }
    
    for (i in 1:input$years) {
      balances$growing_contrib[i + 1] <- future_value(input$initial, input$rate/100, i + 1) + growing_annuity(input$contrib, input$rate/100, input$grate/100, i)
    }
    
    balances
  })
      
  
  output$return_plot <- renderPlot({
    melt_balances <- melt(data = balances(), id.vars = "years")
   plot <- ggplot(melt_balances, aes(x = years, y = value)) +
      geom_point(aes(color = variable)) +
      geom_line(aes(color = variable)) +
      labs(title = "Timeline Graph of Savings Modalities", x = "Years", y = "Prsent Value")
   if (input$facet == "No") {
     plot + scale_fill_manual(name = "Financial Growth plans", labels(c("no contribution", 'fixed contribution', 'growing contribution')))
   } else {
     plot + facet_grid(~variable) + geom_area(alpha = .5, aes(fill = variable))
   }
  })
  output$table <- renderPrint(print(balances(), print.gap = 2))
    
}

  
  # generate app

 
  
shinyApp(ui, server)
