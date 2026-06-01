# Create a Carto basemap

Renders a MapLibre GL or Mapbox GL map using a Carto tile style.

## Usage

``` r
carto_map(type = "maplibre", projection = "globe", carto_map = "positron", ...)
```

## Arguments

- type:

  Character. Map renderer: `"maplibre"` (default) or `"mapboxgl"`.

- projection:

  Character. Map projection. Default: `"globe"`.

- carto_map:

  Character. Carto style name passed to `carto_style()`. Common values:
  `"positron"` (default), `"dark-matter"`, `"voyager"`.

- ...:

  Additional arguments forwarded to `maplibre()` or `mapboxgl()`.

## Value

A `maplibre` or `mapboxgl` map object.

## Examples

``` r
if (FALSE) { # \dontrun{
carto_map()
carto_map(carto_map = "dark-matter")
} # }
```
