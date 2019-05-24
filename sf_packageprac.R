# Practicing use with the sf package
#created 23 may 2019
library(sf)
# Create sfg objects with coordinates of Los Angeles and Amsterdam
la_sfg <- st_point(c(-118.2615805, 34.1168926))
amsterdam_sfg <- st_point(c(4.8979755, 52.3745403))

# Print sfg POINT objects
la_sfg

# Structure of a sfg POINT object
str(la_sfg)

# Coordinates of a sfg object
st_coordinates(la_sfg)

#########################################################################################################
################ potentially useful for defor project
#########################################################################################################
# Matrix of points
rbind(c(-118.2615805, 34.1168926), c(4.8979755, 52.3745403))


# Create MULTIPOINT and LINESTRING sfg objects through matrix of points
multipoint_sfg <- st_multipoint(rbind(c(-118.2615805, 34.1168926), c(4.8979755, 52.3745403)))
linestring_sfg <- st_linestring(rbind(c(-118.2615805, 34.1168926), c(4.8979755, 52.3745403)))

linestring_sfg
multipoint_sfg


par(mar = c(0, 1, 2, 1),
    mfrow = c(1, 2))
plot(multipoint_sfg, main = "MULTIPOINT")
plot(linestring_sfg, main = "LINESTRING")

# Distance on sfg objects does not have real-world meaning
st_distance(la_sfg, amsterdam_sfg)

# st_distance and stats::dist the same for sfg objects
dist(rbind(c(-118.2615805, 34.1168926), c(4.8979755, 52.3745403)))

# Create sfc object with default crs
st_sfc(multipoint_sfg)

# Create sfc object with multiple sfg objects
#the EPSG code 4326 to identify longitude and latitude coordinates on the WGS84 ellipsoid for the CRS
points_sfc <- st_sfc(la_sfg, amsterdam_sfg, crs = 4326)
points_sfc

# Attributes of sfc object
attributes(points_sfc)
#we can clearly see that points_sfc is of class sfc and subclass sfc_POINT

# crs attribute is of class crs
class(st_crs(points_sfc))

# Access crs attribute of sfc object
st_crs(points_sfc)



# Create a data frame of attributes for the two points
data <- data.frame(name = c("Los Angeles", "Amsterdam"),
                   language = c("English", "Dutch"),
                   weather = c("sunny", "rainy/cold"))

#########################################################################################################
################ potentially useful for defor project
#########################################################################################################

# Create data frame with list column then make sf object
st_sf(cbind(data, points_sfc))


# Make sf object from separate data frame and sfc objects
st_sf(data, geometry = points_sfc)



points_sf <- st_sf(data, geometry = points_sfc)
