library(shiny)
library(googleVis)
library(shinydashboard)
library(maps)
library(dplyr)
library(leaflet)
library(sp)
library(data.table)



shinyServer(function(input,output) {
  
  output$world_map <- renderLeaflet({
    world_filter = restdf %>% 
      filter(., country == input$select)
    
  leaflet(world_filter) %>% 
    addProviderTiles(providers$Esri.NatGeoWorldMap) %>% 
    addMarkers(~longitude, ~latitude,
               popup = ~paste('<b> Name:</b>',restaurant_name,'<br>',
                              '<b>Cuisine: </b>', cuisines, '<br>', 
                              '<b>Adress:</b>',address,'<br>',
                              '<b>Rating: </b>', aggregate_rating))
  })
  output$world <- renderLeaflet({leaflet(restdf) %>% 
      addTiles() %>% 
      addProviderTiles(providers$Esri.NatGeoWorldMap) %>% 
      setView(lng = 10.21, lat = 25.173380, zoom = 3) %>% 
      addMarkers(data=restdf, lng = ~longitude, lat = ~latitude, 
                 clusterOptions = markerClusterOptions(),
                 popup = ~paste('<b> Name:</b>',restaurant_name,'<br>',
                                '<b>Cuisine: </b>', cuisines, '<br>', 
                                '<b>Adress:</b>', address,'<br>',
                                '<b>Rating: </b>', aggregate_rating))
    })
  
  output$chart1 <- renderPlot({
    ggplot(data = restdf[restdf$country == input$select,], aes(x=aggregate_rating)) + geom_bar() +
      ggtitle('Overall Aggregate Ratings') + xlab('Aggregate Rating') + ylab('Count')
  })
  output$table = renderDataTable({
    datatable(rest_table, options = list(scrollX = T))
  })
  })
