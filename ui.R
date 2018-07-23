library(shinydashboard)
library(leaflet)
library(sp)
library(data.table)


header <- dashboardHeader(title = 'Restaurant Discovery')



sidebar <- dashboardSidebar(
    sidebarUserPanel('Richie Bui'),
    sidebarMenu(
      # menuItem('Introduction', tabName = 'intro', icon = icon('align-center')),
      menuItem('Map By Country', tabName = 'worldmap', icon = icon('globe')),
      menuItem('World Map', tabName = 'cluster', icon = icon('braille')),
      menuItem('Dataset', tabName = 'dataset', icon = icon('file'))
    ))

body <- dashboardBody(
    tabItems(
      tabItem(tabName = 'worldmap',
              fluidPage(
                box(leafletOutput('world_map'), background = 'blue'),
                box(selectInput(inputId='select',
                                label= "Select Country...",
                                choices= unique(restdf$country),selected = 1), status='success', background = 'blue'),
                box(plotOutput('chart1'), background = 'blue')
              )),
       tabItem(tabName = 'cluster',
               fluidPage(
                 leafletOutput('world')
       )),
       tabItem(tabName = 'dataset',
              dataTableOutput('table'))
    ))

dashboardPage(header, sidebar, body)
