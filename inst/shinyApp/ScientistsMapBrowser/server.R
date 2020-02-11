server <- function(input, output){
  
  output$about_out  <- renderUI({
    includeHTML("about.html")
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
  
  
  #my_info<-renderMarkdown(file = "./data/include.md", encoding = "UTF-8")
  output$my_leaf <- renderLeaflet({
    
    leaflet() %>%
      leaflet(data = GeoScientists_df) %>%
      addProviderTiles(providers$OpenStreetMap, group='Open Street') %>%
      addProviderTiles(providers$Esri.WorldImagery, group='Satellite')%>%
      addLayersControl(
        baseGroups = c('Open Street', 'Satellite'))%>%
      #overlayGroups = c("Sachsen", "Netzwerk 1 Ord","Netzwerk 2 Ord","Säule 1 Ord","Säule 2 Ord"),
      # options = layersControlOptions(collapsed = TRUE))%>%
      #hideGroup("Säule 2 Ord")%>%
      #setView(13.169629, 50.860422,zoom = 7)%>% 
      #setMaxBounds(lng1 = max(df$lon),lat1 = max(df$lat),
      #  lng2 = min(df$lon),lat2 = min(df$lat))%>%
      addFullscreenControl()%>%
      # addControl(actionButton("zoomer","Reset view"),
      #            position="topleft")%>%
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
    
    # 
    # red_df = dplyr::filter(df_filtered(),Ordnung == 1)
    # green_df = dplyr::filter(df_filtered(),Ordnung == 2)
    # 
    proxy<-leafletProxy(mapId = "my_leaf", data = df_filtered()) %>%
      # flyToBounds(lng1 = max(df_filtered()$lon),lat1 = max(df_filtered()$lat),
      #             lng2 = min(df_filtered()$lon),lat2 = min(df_filtered()$lat))%>%
                  #options = list(minZoom = 10))%>%
      clearMarkers() %>%
      addMarkers(~lon, ~lat, 
                 popup = paste("<b><a href='",GeoScientists_df$Wikipedia_Link,"'>",
                               paste(GeoScientists_df$Name),"</a></b>",
                               "<br>",
                               paste("Date of Birth: ",GeoScientists_df$Born),"</a></b>",
                               "<br>",
                               paste("Current Country: ",GeoScientists_df$Country),"</a></b>",
                               "<br>"),
                 clusterOptions = TRUE)
    
    
    
    output$my_table<- DT::renderDataTable(DT::datatable(
      df_table_filtered(),
      options = list(pageLength = 10),
      rownames = FALSE))
  })
}

#shinyApp(ui, server)
