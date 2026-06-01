# Convert occurrence records to an H3 hexagonal grid

Groups a data frame of occurrence records into Uber H3 hexagonal cells
and returns an sf polygon layer with the record count per cell.

## Usage

``` r
occ_to_h3grid(occ, grid_res = 3)
```

## Arguments

- occ:

  Data frame with columns `decimalLongitude` and `decimalLatitude`.

- grid_res:

  Integer. H3 resolution (0–15). Higher values produce smaller hexagons.
  Default `3`.

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
occ_to_h3grid(occ, grid_res = 3)
#> Simple feature collection with 5 features and 1 field
#> Geometry type: POLYGON
#> Dimension:     XY
#> Bounding box:  xmin: -122.9976 ymin: -34.45959 xmax: 152.6023 ymax: 49.80503
#> Geodetic CRS:  WGS 84
#>   records                       geometry
#> 1       1 POLYGON ((1.882244 49.80503...
#> 2       1 POLYGON ((-87.52625 42.1529...
#> 3       1 POLYGON ((-121.7645 37.6756...
#> 4       1 POLYGON ((-118.0404 33.9461...
#> 5       1 POLYGON ((152.6023 -33.997,...
```
