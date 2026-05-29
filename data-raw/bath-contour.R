## code to prepare `bath_contour` dataset goes here
bath <- "https://erddap.bio-oracle.org/erddap/griddap/terrain_characteristics.nc?bathymetry_mean%5B(1970-01-01T00:00:00Z):1:(1970-01-01T00:00:00Z)%5D%5B(-89.975):1:(89.975)%5D%5B(-179.975):1:(179.975)%5D"

bath <- terra::rast(bath)

breaks <- c(
  -200, -500, -1000, -2000, -3000,
  -4000, -5000, -6000, -7000,
  -8000, -9000
)

bath_contour <- terra::as.contour(bath, levels = breaks)

bath_contour <- sf::st_as_sf(bath_countour)

usethis::use_data(bath_contour, overwrite = TRUE)
