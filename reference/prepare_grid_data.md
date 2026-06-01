# Bin a numeric grid column into labelled factor levels for plotting

Cuts a numeric column in an sf grid object into ordered factor bins
using the same break scheme as
[`obis_scale()`](https://iobis.github.io/obis-recipes/reference/obis_scale.md).
The result is a new column named `<column>_binned` ready for use with
[`ggplot2::aes()`](https://ggplot2.tidyverse.org/reference/aes.html).

## Usage

``` r
prepare_grid_data(
  grid_data,
  column = "records",
  breaks = c(1, 10, 100, 1000, 10000)
)
```

## Arguments

- grid_data:

  An [sf::sf](https://r-spatial.github.io/sf/reference/sf.html) object
  containing the column to bin.

- column:

  Character. Name of the numeric column to bin. Default `"records"`.

- breaks:

  Numeric vector of bin boundaries (same as
  [`obis_scale()`](https://iobis.github.io/obis-recipes/reference/obis_scale.md)).
  Default `c(1, 10, 100, 1000, 10000)`.

## Value

The input `grid_data` with an additional `<column>_binned` factor
column.

## Examples

``` r
occ <- data.frame(
    decimalLongitude = c(-122.4, -118.2, -87.6, 2.3, 151.2),
    decimalLatitude  = c(37.8, 34.1, 41.9, 48.9, -33.9)
)
grid <- occ_to_geohashgrid(occ)
prepare_grid_data(grid)
#> Simple feature collection with 5 features and 3 fields
#> Geometry type: POLYGON
#> Dimension:     XY
#> Bounding box:  xmin: -123.75 ymin: -35.15625 xmax: 151.875 ymax: 49.21875
#> Geodetic CRS:  +proj=longlat +datum=WGS84 +no_defs
#>     ID                       geometry records records_binned
#> 9q5  1 POLYGON ((-119.5312 33.75, ...       1             10
#> 9q8  2 POLYGON ((-123.75 36.5625, ...       1             10
#> dp3  3 POLYGON ((-88.59375 40.7812...       1             10
#> r3g  4 POLYGON ((150.4688 -35.1562...       1             10
#> u09  5 POLYGON ((1.40625 47.8125, ...       1             10
```
