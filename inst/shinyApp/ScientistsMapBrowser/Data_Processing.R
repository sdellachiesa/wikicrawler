library(leaflet)
library(leaflet.providers)
library(leaflet.extras)
library(readxl)
library(ggmap)
library(ggplot2)
library(tmap)
library(tmaptools)

# ---- Load data and preprocessing
Scientists_df <- read_excel("data/Scientists_list.xlsx")
Scientists_df <- as.data.frame(Scientists)

# Add id
Scientists_df$id <- 1:nrow(Scientists_df)


#locations_df <- geocode_OSM(Scientists_df$Country[1],as.data.frame = TRUE )

# ---- Geocoding base on Open Street Map
# time delay to avoid web request shut down
for (i in 1:length(Scientists_df$id))
{
  locations_df[i,] <- geocode_OSM(Scientists_df$Country[i],as.data.frame = TRUE )
  print (i)
  date_time<-Sys.time()
  while((as.numeric(Sys.time()) - as.numeric(date_time))<0.1){} #dummy while loop
}

# Add id for merging
locations_df$id <- 1:nrow(locations_df)
GeoScientists_df<-merge.data.frame(Scientists_df,locations_df,by="id")

write.csv(GeoScientists_df,file = "./data/GeoScientists.csv")



