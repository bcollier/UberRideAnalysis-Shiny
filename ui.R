#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Uber Ride Analysis for Manhatten: September 2014"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("start",
                   "Start Time (24 Hour Time):",
                   min = 0,
                   max = 24,
                   value = 7),
       
       sliderInput("end",
                   "End Time (24 Hour Time):",
                   min = 0,
                   max = 24,
                   value = 9),
       sliderInput("dayofmonth",
                   "Day of Month (1=First, 30=Last):",
                   min = 0,
                   max = 30,
                   value = 1)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabPanel(p(icon("table"), "Instructions"),
               h4("Choose the Date and Time Range to Analyze on the Left"),
               h5("Please be patient, there is a lot of data here so it can take a few moments to load")
      ),
      tabPanel(p(icon("table"), "Summary"),
               h5(textOutput("search_day")),
               h5(textOutput("time_range"))
      ),
       plotOutput("uberPlot")
    )
    
  )
))

