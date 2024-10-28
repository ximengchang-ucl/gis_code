library(sf)
library(dplyr)
library(ggplot2)

# read csv data
data<-read.csv("/Users/ximeng/Desktop/GIS/wk4/pra/HDR23-24_Composite_indices_complete_time_series.csv")

# Check data structure
head(data)
colnames(data)

# Create Gender inequality disparity column
data <- data %>%
  mutate(gender_inequality_difference_2010_2019 = gii_2019 - gii_2010)

# read GeoJSON data
geo_data <- st_read("/Users/ximeng/Desktop/GIS/wk4/pra/World_Countries_(Generalized)_9029012925078512962.geojson")

# Merge CSV data and GeoJSON data
geo_data <- geo_data %>%
  left_join(data, by = c("COUNTRY"="country"))
print(geo_data)

# Visualize the gender inequality gap
library(colorspace)
gii_plot <- ggplot(data = geo_data) +
  geom_sf(aes(fill = gender_inequality_difference_2010_2019)) +
  scale_fill_viridis_c(option = "plasma") +
  labs(title = "GII Difference (2019 vs 2010)", fill = "Difference (2019-2010)") +
  theme(plot.title = element_text(hjust = 0.5))

# print the plot
print(gii_plot)
