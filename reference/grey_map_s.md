# Create a grey world basemap with optional bathymetry

Draws a ggplot2 world map styled after the OBIS taxon page: grey ocean
background, white land, and an optional semi-transparent bathymetry
overlay.

## Usage

``` r
grey_map_s(
  map_scale = "small",
  map_crs = NA,
  background_color = "#dbdbdc",
  land_background = "white",
  land_line_color = NA,
  add_bathymetry = TRUE,
  bathymetry_color = "#044062",
  bathymetry_opacity = 0.06,
  plot_xlim = NULL,
  plot_ylim = NULL,
  keep_graticule = FALSE,
  ...
)
```

## Arguments

- map_scale:

  Character. Natural Earth dataset scale. One of `"small"`, `"medium"`,
  or `"large"`. Default `"small"`.

- map_crs:

  Numeric or character CRS, or `NA` for WGS 84. Default `NA`.

- background_color:

  Character. Fill color for the ocean/panel background. Default
  `"#dbdbdc"`.

- land_background:

  Character. Fill color for land polygons. Default `"white"`.

- land_line_color:

  Character or `NA`. Outline color for land polygons. Default `NA` (no
  outline).

- add_bathymetry:

  Logical. If `TRUE`, overlays the bundled `bath_contour` dataset as a
  semi-transparent layer. Default `TRUE`.

- bathymetry_color:

  Character. Color for bathymetry contour lines. Default `"#044062"`.

- bathymetry_opacity:

  Numeric in `[0, 1]`. Opacity of the bathymetry layer. Default `0.06`.

- plot_xlim:

  Numeric vector of length 2, or `NULL`. Longitude limits passed to
  [`ggplot2::coord_sf()`](https://ggplot2.tidyverse.org/reference/ggsf.html).
  Default `NULL`.

- plot_ylim:

  Numeric vector of length 2, or `NULL`. Latitude limits passed to
  [`ggplot2::coord_sf()`](https://ggplot2.tidyverse.org/reference/ggsf.html).
  Default `NULL`.

- keep_graticule:

  Logical. Retain axis labels and graticule lines. Default `FALSE`.

- ...:

  Additional arguments passed to
  [`ggplot2::coord_sf()`](https://ggplot2.tidyverse.org/reference/ggsf.html).

## Value

A [ggplot2::ggplot](https://ggplot2.tidyverse.org/reference/ggplot.html)
object.

## Examples

``` r
grey_map_s()
#> Error in element_rect(fill = background_color): could not find function "element_rect"
grey_map_s(add_bathymetry = FALSE)
#> Error in element_rect(fill = background_color): could not find function "element_rect"
grey_map_s(plot_xlim = c(-30, 40), plot_ylim = c(35, 70))
#> Error in element_rect(fill = background_color): could not find function "element_rect"
```
