server <- function(input, output){
  
  output$about_out  <- renderUI({
    includeHTML("./www/about.html")
    #includeMarkdown("README.md")
  })
  output$data  <- renderMenu({
    sidebarMenu(
      menuItem("Map&Data", tabName = "data")
    )
  })
  
  output$about  <- renderMenu({
    sidebarMenu(
      menuItem("About",tabName = "about")
    )
  })
  
  
  
  
  
  ##  filter data
  
  df_filtered <- reactive({
    GeoScientists_df[GeoScientists_df$Born >= input$slider[1] & GeoScientists_df$Born <= input$slider[2] , ]
  }
  )
  df_table_filtered <- reactive({
    GeoTable_df[GeoTable_df$Born >= input$slider[1] & GeoTable_df$Born <= input$slider[2] , ]
  }
  )
  
 
  
  observe({
    proxy<-leafletProxy(mapId = "my_leaf", data = df_filtered()) %>%
      flyToBounds(lng1 = max(df_filtered()$lon),lat1 = max(df_filtered()$lat),
                  lng2 = min(df_filtered()$lon),lat2 = min(df_filtered()$lat),
                  options = list(minZoom = 14))%>%
          addMarkers(lng =df_filtered()$lon, lat = df_filtered()$lat, 
                 popup = paste("<b><a href='",df_filtered()$Wikipedia_link,"'>",
                               paste(df_filtered()$Name),"</a></b>",
                               "<br>",
                               paste("Date of Birth: ",df_filtered()$Born),"</a></b>",
                               "<br>",
                               paste("Current Country: ",df_filtered()$Country),"</a></b>",
                               "<br>"),
                 clusterOptions = TRUE)%>%
    clearMarkers()
    
    output$my_leaf <- renderLeaflet({
      
      leaflet() %>% addTiles() %>%
        addProviderTiles(providers$OpenStreetMap, group='Open Street') %>%
        addFullscreenControl()%>%
        #      clearMarkers()%>%
        addEasyButton(
          easyButton(
            position = "topleft",
            icon = "fa-crosshairs",
            title = "Locate Me",
            onClick = JS(
              c(
                "function(btn,  map){map.locate({setView:true,enableHighAccuracy: true })}"
              )
            )
          )
        ) 
      
      
    }) 
    
    output$my_table<- DT::renderDataTable(DT::datatable(
      df_table_filtered(),
      options = list(pageLength = 10),
      rownames = FALSE))
  })
}

#shinyApp(ui, server)
