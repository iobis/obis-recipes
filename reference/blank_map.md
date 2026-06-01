# Create a blank OBIS-style basemap

Renders a MapLibre GL or Mapbox GL map with a solid-colour background
and OBIS land tiles, matching the style of the OBIS website homepage.

## Usage

``` r
blank_map(
  type = "maplibre",
  projection = "globe",
  background_color = "white",
  land_line_color = "black",
  ...
)
```

## Arguments

- type:

  Character. Map renderer: `"maplibre"` (default) or `"mapboxgl"`.

- projection:

  Character. Map projection passed to the renderer. One of `"globe"`
  (default), `"mercator"`, `"none"`, etc.

- background_color:

  Character. CSS colour for the ocean/background. Default: `"white"`.

- land_line_color:

  Character. CSS colour for the land polygon outline. Default:
  `"black"`.

- ...:

  Additional arguments forwarded to `maplibre()` or `mapboxgl()`.

## Value

A `maplibre` or `mapboxgl` map object.

## Examples

``` r
if (FALSE) { # \dontrun{
blank_map()
blank_map(projection = "mercator", background_color = "#eaeaea")
} # }
```
