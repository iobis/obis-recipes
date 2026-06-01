# Fit a map to bounds

Wrapper around
[`mapgl::fit_bounds()`](https://walker-data.com/mapgl/reference/fit_bounds.html)
so that mapgl does not need to be attached with
[`library(mapgl)`](https://walker-data.com/mapgl/) for the call to
resolve.

## Usage

``` r
fit_bounds(map, ...)
```

## Arguments

- map:

  A MapLibre or Mapbox map object.

- ...:

  Arguments passed to
  [`mapgl::fit_bounds()`](https://walker-data.com/mapgl/reference/fit_bounds.html).

## Value

The map object with updated bounds.
