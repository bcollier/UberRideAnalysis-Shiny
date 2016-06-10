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
library(ggmap)
library(lubridate)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$time_range <- renderText({
    paste("Searching for Uber Rides Between the Hours of: ", input$start, ":00 and ", input$end, ":00", sep="")
    
  })
  
  output$search_day <- renderText({
    paste("Displaying Rides for Date: 9/",input$dayofmonth, "/2014 ", sep="")
    
  })
  
  
  
  output$uberPlot <- renderPlot({
    
    uber_data <- readRDS("uber_data.rds")
    uber_data$Date.Time <- parse_date_time(uber_data$Date.Time, "m/d/Y H:M:S")
    
    start_datetime <- parse_date_time(paste("9/",input$dayofmonth, "/2014 ", input$start, ":00:00", sep=""), "m/d/Y H:M:S")
    end_datetime <- parse_date_time(paste("9/",input$dayofmonth, "/2014 ", input$end, ":00:00", sep=""), "m/d/Y H:M:S")
    
    
    # start_datetime <- parse_date_time("9/15/2014 06:00:00", "m/d/Y H:M:S")
    # end_datetime <- parse_date_time("9/15/2014 08:00:00", "m/d/Y H:M:S")
    
    plot_points <- uber_data[which(start_datetime < uber_data$Date.Time & end_datetime > uber_data$Date.Time), ]
    df <- as.data.frame(cbind(lon=plot_points$Lon,lat=plot_points$Lat))
    
    # getting the map
    # nycmap <- get_map(location = c(lon = mean(df$lon), lat = mean(df$lat)), zoom = 12, maptype = "satellite", scale = 2)
    
    nycmap <- get_map(location = c(lon = mean(df$lon), lat = mean(df$lat)), zoom = 12, maptype = "roadmap", scale = 2)
    # plotting the map with some points on it
    ggmap(nycmap) + geom_point(data = df, aes(x = lon, y = lat, fill = "red", alpha = 0.8), size = 2, shape = 21) + guides(fill=FALSE, alpha=FALSE, size=FALSE)
    
    
    
    # # generate bins based on input$bins from ui.R
    # x    <- faithful[, 2] 
    # bins <- seq(min(x), max(x), length.out = 15 + 1)
    # 
    # # draw the histogram with the specified number of bins
    # hist(x, breaks = 15, col = 'darkgray', border = 'white')
    
  })
  
})
