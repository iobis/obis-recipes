# Create a grey OBIS-style basemap

Renders a MapLibre GL or Mapbox GL map with a grey background, white
land fill, and optional GEBCO bathymetry contour lines — matching the
style of OBIS taxon pages (e.g. <https://obis.org/taxon/126436>).

## Usage

``` r
grey_map(
  type = "maplibre",
  projection = "globe",
  background_color = "#dbdbdc",
  land_background = "white",
  land_line_color = NULL,
  add_bathymetry = TRUE,
  bathymetry_color = "#044062",
  bathymetry_opacity = 0.06,
  ...
)
```

## Arguments

- type:

  Character. Map renderer: `"maplibre"` (default) or `"mapboxgl"`.

- projection:

  Character. Map projection. Default: `"globe"`.

- background_color:

  Character. CSS colour for the ocean/background. Default: `"#dbdbdc"`.

- land_background:

  Character. CSS fill colour for land polygons. Default: `"white"`.

- land_line_color:

  Character or NULL. CSS colour for the land polygon outline. Default:
  `NULL` (no outline).

- add_bathymetry:

  Logical. Whether to overlay GEBCO filtered bathymetry contour lines.
  Default: `TRUE`.

- bathymetry_color:

  Character. CSS colour for bathymetry lines. Default: `"#044062"`.

- bathymetry_opacity:

  Numeric 0–1. Opacity of bathymetry lines. Default: `0.06`.

- ...:

  Additional arguments forwarded to `maplibre()` or `mapboxgl()`.

## Value

A `maplibre` or `mapboxgl` map object.

## Examples

``` r
if (FALSE) { # \dontrun{
grey_map()
grey_map(add_bathymetry = FALSE)
} # }
```
