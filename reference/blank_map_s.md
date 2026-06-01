# Create a blank white world basemap

Draws a minimal ggplot2 world map with a solid white land fill. Useful
as a base layer before adding occurrence data.

## Usage

``` r
blank_map_s(
  map_scale = "small",
  map_crs = NA,
  background_color = "white",
  land_line_color = "black",
  keep_graticule = FALSE,
  ...
)
```

## Arguments

- map_scale:

  Character. Natural Earth dataset scale passed to
  [`rnaturalearth::ne_countries()`](https://docs.ropensci.org/rnaturalearth/reference/ne_countries.html).
  One of `"small"`, `"medium"`, or `"large"`. Default `"small"`.

- map_crs:

  Numeric or character CRS accepted by
  [`sf::st_crs()`](https://r-spatial.github.io/sf/reference/st_crs.html),
  or `NA` to use the default (WGS 84 / EPSG:4326). Default `NA`.

- background_color:

  Character. Fill color for land polygons. Default `"white"`.

- land_line_color:

  Character. Outline color for land polygons. Default `"black"`.

- keep_graticule:

  Logical. If `TRUE` applies `theme_minimal()` to retain axis labels and
  graticule lines; otherwise `theme_void()`. Default `FALSE`.

- ...:

  Additional arguments passed to
  [`ggplot2::coord_sf()`](https://ggplot2.tidyverse.org/reference/ggsf.html).

## Value

A [ggplot2::ggplot](https://ggplot2.tidyverse.org/reference/ggplot.html)
object.

## Examples

``` r
blank_map_s()

blank_map_s(keep_graticule = TRUE)

blank_map_s(map_crs = "+proj=moll")
```
