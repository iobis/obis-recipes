# Convert occurrence records to an A5 pentagonal grid

Groups a data frame of occurrence records into A5 equal-area pentagonal
cells and returns an sf polygon layer with the record count per cell.

## Usage

``` r
occ_to_a5grid(occ, grid_res = 3)
```

## Arguments

- occ:

  Data frame with columns `decimalLongitude` and `decimalLatitude`.

- grid_res:

  Integer. A5 resolution level (0–30). Higher values produce smaller
  cells. Default `3`.

## Value

An [sf::sf](https://r-spatial.github.io/sf/reference/sf.html) object
with one row per occupied cell and a `records` column containing the
occurrence count.

## Examples

``` r
occ <- data.frame(
    decimalLongitude = c(-122.4, -118.2, -87.6, 2.3, 151.2),
    decimalLatitude  = c(37.8, 34.1, 41.9, 48.9, -33.9)
)
occ_to_a5grid(occ, grid_res = 3)
#> Simple feature collection with 5 features and 1 field
#> Geometry type: POLYGON
#> Dimension:     XY
#> Bounding box:  xmin: -132.3253 ymin: -36.13236 xmax: 152.5101 ymax: 56.87074
#> Geodetic CRS:  WGS 84 (CRS84)
#>   records                       geometry
#> 1       1 POLYGON ((-84.19662 44.4558...
#> 2       1 POLYGON ((-129 31.83236, -1...
#> 3       1 POLYGON ((-125.7545 36.2401...
#> 4       1 POLYGON ((-1.522731 56.8707...
#> 5       1 POLYGON ((146.3633 -36.1323...
```
