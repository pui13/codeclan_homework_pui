
 
library(tidyverse)
library(janitor)
 



 
# 1. Read the data into R

meteorite_landings <- read_csv("data/meteorite_landings.csv")
 

 
# 2. Change the name of the variables to follow our naming standards

meteorite_landings <- clean_names(meteorite_landings)

# 3. Split in column [GeoLocation] into latitude and longitude, the new latitude and longitude columns should be numeric.

meteorite_landings <- meteorite_landings %>%
  separate(geo_location, c("latitude", "longitude"), ", ")

meteorite_landings <- meteorite_landings %>%
  mutate(latitude = str_replace_all(latitude, "\\(","")) %>%
  mutate(longitude = str_replace_all(longitude, "\\)","") )
 

meteorite_landings$latitude <- as.numeric(as.character(meteorite_landings$latitude))
meteorite_landings$longitude <- as.numeric(as.character(meteorite_landings$longitude))

# 4. Replace any missing values in latitude and longitude with zeros.

meteorite_landings <- meteorite_landings%>%
  mutate(latitude = coalesce(latitude, 0)) %>%
  mutate(longitude = coalesce(longitude, 0))

sum(is.na(meteorite_landings$latitude & meteorite_landings$longitude))

# 5. Remove meteorites less than 1000g in weight from the data.

meteorite_landings <- meteorite_landings %>%
  filter(mass_g > 999)

#6. Order the data by the year of discovery.

meteorite_landings <- meteorite_landings %>%
  arrange(year)

meteorite_landings
 






