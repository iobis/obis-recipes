# Add UI controls to a map

Adds fullscreen, globe-projection toggle, and scale bar controls to an
existing map object. Each control can be toggled on or off
independently.

## Usage

``` r
add_map_controls(
  map,
  fullscreen = TRUE,
  globe = TRUE,
  scale = TRUE,
  fullscreen_position = "bottom-left",
  globe_position = "bottom-left",
  scale_position = "bottom-left"
)
```

## Arguments

- map:

  A map object (e.g. from
  [`blank_map()`](https://iobis.github.io/obis-recipes/reference/blank_map.md)).

- fullscreen:

  Logical. Add a fullscreen button. Default: `TRUE`.

- globe:

  Logical. Add a globe-projection toggle button. Default: `TRUE`.

- scale:

  Logical. Add a scale bar. Default: `TRUE`.

- fullscreen_position:

  Character. Corner position of the fullscreen button. Default:
  `"bottom-left"`.

- globe_position:

  Character. Corner position of the globe toggle. Default:
  `"bottom-left"`.

- scale_position:

  Character. Corner position of the scale bar. Default: `"bottom-left"`.

## Value

The input `map` object with the requested controls added.

## Examples

``` r
if (FALSE) { # \dontrun{
blank_map(projection = "none") |> add_map_controls()

grey_map() |>
  add_map_controls(globe = FALSE, scale_position = "bottom-right")
} # }
```
