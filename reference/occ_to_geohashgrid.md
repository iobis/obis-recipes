# Convert occurrence records to a geohash grid

Groups a data frame of occurrence records into geohash cells and returns
an sf polygon layer with the record count per cell.

## Usage

``` r
occ_to_geohashgrid(occ, grid_res = 3)
```

## Arguments

- occ:

  Data frame with columns `decimalLongitude` and `decimalLatitude`.

- grid_res:

  Integer. Geohash precision level (1–9). Higher values produce smaller
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
occ_to_geohashgrid(occ, grid_res = 3)
#> Simple feature collection with 5 features and 2 fields
#> Geometry type: POLYGON
#> Dimension:     XY
#> Bounding box:  xmin: -123.75 ymin: -35.15625 xmax: 151.875 ymax: 49.21875
#> Geodetic CRS:  +proj=longlat +datum=WGS84 +no_defs
#>     ID                       geometry records
#> 9q5  1 POLYGON ((-119.5312 33.75, ...       1
#> 9q8  2 POLYGON ((-123.75 36.5625, ...       1
#> dp3  3 POLYGON ((-88.59375 40.7812...       1
#> r3g  4 POLYGON ((150.4688 -35.1562...       1
#> u09  5 POLYGON ((1.40625 47.8125, ...       1
```
