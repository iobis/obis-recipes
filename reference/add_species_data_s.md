# Add a gridded species occurrence layer to a basemap

Overlays a spatial grid of occurrence counts (from
[`get_occ_gridded()`](https://iobis.github.io/obis-recipes/reference/get_occ_gridded.md),
[`get_occ_tiles()`](https://iobis.github.io/obis-recipes/reference/get_occ_tiles.md),
or any of the `occ_to_*grid()` converters) onto an existing ggplot2
basemap.

## Usage

``` r
add_species_data_s(
  map,
  grid_data,
  limit_by_bbox = TRUE,
  plot_xlim = NULL,
  plot_ylim = NULL,
  map_crs = NA,
  auto_breaks = FALSE,
  breaks = c(1, 10, 100, 1000, 10000),
  colors = c("#2c7bb6", "#abd9e9", "#ffffbf", "#fdae61", "#d7191c"),
  legend = TRUE,
  ...
)
```

## Arguments

- map:

  A
  [ggplot2::ggplot](https://ggplot2.tidyverse.org/reference/ggplot.html)
  basemap, typically from
  [`blank_map_s()`](https://iobis.github.io/obis-recipes/reference/blank_map_s.md)
  or
  [`grey_map_s()`](https://iobis.github.io/obis-recipes/reference/grey_map_s.md).

- grid_data:

  An [sf::sf](https://r-spatial.github.io/sf/reference/sf.html) object
  with a `records` column, as returned by the grid functions in this
  package.

- limit_by_bbox:

  Logical. If `TRUE`, zooms the map to the bounding box of `grid_data`.
  Default `TRUE`.

- plot_xlim:

  Numeric vector of length 2, or `NULL`. Manual longitude limits used
  when `limit_by_bbox = FALSE`. Default `NULL`.

- plot_ylim:

  Numeric vector of length 2, or `NULL`. Manual latitude limits used
  when `limit_by_bbox = FALSE`. Default `NULL`.

- map_crs:

  Numeric or character CRS, or `NA` for WGS 84. Default `NA`.

- auto_breaks:

  Logical. If `TRUE`, uses
  [`ggplot2::scale_fill_binned()`](https://ggplot2.tidyverse.org/reference/scale_colour_continuous.html)
  with automatic breaks instead of
  [`obis_scale()`](https://iobis.github.io/obis-recipes/reference/obis_scale.md).
  Default `FALSE`.

- breaks:

  Numeric vector of bin boundaries passed to
  [`obis_scale()`](https://iobis.github.io/obis-recipes/reference/obis_scale.md)
  and
  [`prepare_grid_data()`](https://iobis.github.io/obis-recipes/reference/prepare_grid_data.md).
  Default `c(1, 10, 100, 1000, 10000)`.

- colors:

  Character vector of fill colors, one per bin. Default is the OBIS
  blue-to-red palette.

- legend:

  Logical. Show the fill legend. Default `TRUE`.

- ...:

  Additional arguments passed to
  [`ggplot2::coord_sf()`](https://ggplot2.tidyverse.org/reference/ggsf.html).

## Value

A [ggplot2::ggplot](https://ggplot2.tidyverse.org/reference/ggplot.html)
object.

## Examples

``` r
if (FALSE) { # \dontrun{
# Geohash grid on a blank map, zoomed to data extent
grid <- get_occ_tiles(taxonid = 141438)
blank_map_s() |> add_species_data_s(grid_data = grid)

# Global view on a grey map with automatic breaks
grey_map_s() |>
    add_species_data_s(
        grid_data   = grid,
        limit_by_bbox = FALSE,
        auto_breaks = TRUE
    )

# Custom breaks and colors, no legend
blank_map_s() |>
    add_species_data_s(
        grid_data = grid,
        breaks    = c(1, 5, 50, 500),
        colors    = c("#f7fbff", "#6baed6", "#2171b5", "#084594"),
        legend    = FALSE
    )
} # }
```
