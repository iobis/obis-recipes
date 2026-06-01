# MapLibre GL + DeckGL H3 hexagon layer widget

Creates an interactive `htmlwidget` combining a MapLibre GL basemap
(OBIS style) with a DeckGL `H3HexagonLayer` overlay. Suitable for
visualising species richness, record counts, or any per-H3-cell metric.

## Usage

``` r
maplibre_h3(
  data,
  h3_column = "h3",
  value_column = "value",
  color_range = NULL,
  extruded = FALSE,
  elevation_scale = 1,
  pitch = NULL,
  opacity = 0.8,
  center = c(0, 25),
  zoom = 2,
  filter = list(),
  show_occurrence_layer = FALSE,
  legend = FALSE,
  width = NULL,
  height = NULL,
  elementId = NULL
)
```

## Arguments

- data:

  A data frame with at minimum a column of H3 cell index strings.
  Additional numeric columns can be used for colour/elevation mapping.

- h3_column:

  Character. Name of the column containing H3 cell index strings.
  Default: `"h3"`.

- value_column:

  Character or NULL. Name of the column used to drive fill colour (and
  optionally elevation). When `NULL` all hexagons share a single colour.
  Default: `"value"`.

- color_range:

  A list of 6 RGB triplets (each a length-3 integer vector in 0–255)
  used as the colour ramp. Defaults to a blue-to-red diverging palette.

- extruded:

  Logical. Whether to extrude hexagons as 3-D columns. Default: `FALSE`.

- elevation_scale:

  Numeric. Multiplier applied to the elevation when `extruded = TRUE`.
  Default: `1`.

- pitch:

  Numeric. Camera pitch in degrees (0 = top-down, 60 = oblique).
  Default: `45` when `extruded = TRUE`, `0` otherwise.

- opacity:

  Numeric 0–1. Fill opacity of the hexagons. Default: `0.8`.

- center:

  Numeric vector `c(longitude, latitude)`. Initial map centre. Default:
  `c(0, 25)`.

- zoom:

  Numeric. Initial zoom level. Default: `2`.

- filter:

  Named list of extra query parameters forwarded to the OBIS occurrence
  tile endpoint (e.g. `list(taxonid = "12345")`). Default:
  [`list()`](https://rdrr.io/r/base/list.html) (no filter).

- show_occurrence_layer:

  Logical. Whether to show the OBIS occurrence grid layer beneath the H3
  layer. Default: `FALSE`.

- legend:

  Logical. Whether to show a min/max colour-bar legend at the bottom of
  the widget. Default: `FALSE`.

- width, height:

  Widget dimensions (CSS string or pixels). Default: `NULL` (fills its
  container).

- elementId:

  Optional HTML element ID for the widget.

## Value

An `htmlwidget` object.

## Examples

``` r
if (FALSE) { # \dontrun{
library(h3jsr)

cells <- h3jsr::get_disk("8928308280fffff", ring_size = 5)
df <- data.frame(
  h3    = cells,
  value = runif(length(cells), 0, 500)
)

maplibre_h3(df)
maplibre_h3(df, extruded = TRUE, elevation_scale = 100)
} # }
```
