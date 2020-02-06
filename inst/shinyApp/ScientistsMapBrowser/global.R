library(shiny)
library(shinydashboard)
library(shinyjs)
library(leaflet)
library(leaflet.providers)
library(magrittr)
library(leaflet.extras)
library(dplyr)
library(rgdal)
library(utf8)
library(sf)
library(htmltools)
library(xml2)
library(pediarr)
library(stringr)
library(readxl)
library(ggmap)
library(ggplot2)
library(tmap)
library(tmaptools)

#getwd()
setwd("C:/Users/SDellaChiesa/OneDrive - Scientific Network South Tyrol/00_R/09_wikicrawler/inst/shinyApp/ScientistsMapBrowser/")
# ---- Load preprocessed data
GeoScientists_df <- read.csv("C:/Users/SDellaChiesa/OneDrive - Scientific Network South Tyrol/00_R/09_wikicrawler/data/GeoScientists.csv")
GeoScientists_df <- as.data.frame(GeoScientists_df)

GeoTable_df<-GeoScientists_df[c(4:7)]

