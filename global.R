library(tidyverse)
library(ggplot2)
library(shiny)
library(shinydashboard)
library(maps)
library(leaflet)
library(sp)
library(DT)

?leaflet


restdf <- read.csv('rest_df.csv')
restdf <- restdf[complete.cases(restdf),]

rest_table <- data.table::data.table(restdf) 
rest_table


Intro <- 'Welcome to the world of restaurants that we have yet to discover. There is so much to adventure off too, that what we know
so far about food has barely begun to scratch the surface. Thankfully, due to Zomato. A online database that helps inform us of all
restaurants around the globe. Its like yelp, but international. They are not as popular in the states, but to those who are interested
get a sense of wonder of what has left to be discovered. Also Yelp, required a NDA which I was not down to do...'

info <- 'In this shiny app, I have composed a interactive map that allows you to see separately each country and their aggregate ratings.
Please keep in mind, that zomato (the online website) was created in India. As you will see in a moment, the information is quite prevalent
more so than other places around the world. Enjoy.'





world <- leaflet(restdf) %>% 
 addTiles() %>% 
 addProviderTiles(providers$Esri.NatGeoWorldMap) %>% 
  setView(lng = 10.21, lat = 25.173380, zoom = 3) %>% 
  addMarkers(data=restdf, lng = ~longitude, lat = ~latitude, clusterOptions = markerClusterOptions(),
            popup = ~paste('<b> Name:</b>',restaurant_name,'<br>',
                           '<b>Cuisine: </b>', cuisines, '<br>', 
                           '<b>Adress:</b>', address,'<br>',
                           '<b>Rating: </b>', aggregate_rating))

world






