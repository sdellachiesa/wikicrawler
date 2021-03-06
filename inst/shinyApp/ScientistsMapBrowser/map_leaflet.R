# ---- Load Libraries
library(leaflet)
library(leaflet.providers)
library(leaflet.extras)
library(readxl)
library(ggmap)
library(ggplot2)
library(tmap)
library(tmaptools)

#---- Load data
GeoScientists_df<-read.csv("C:/Users/SDellaChiesa/OneDrive - Scientific Network South Tyrol/00_R/09_wikicrawler/data/GeoScientists.csv")

# ---- Plot points



leaflet(data = GeoScientists_df) %>% addTiles() %>%
  addMarkers(~lon, ~lat, 
             popup = paste("<b><a href='",GeoScientists_df$Wikipedia_Link,"'>",
                           paste(GeoScientists_df$Name),"</a></b>",
                           "<br>",
                           paste("Date of Birth: ",GeoScientists_df$Born),"</a></b>",
                           "<br>",
                           paste("Current Country: ",GeoScientists_df$Country),"</a></b>",
                           "<br>"),
             clusterOptions = TRUE)

