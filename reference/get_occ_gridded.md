# Fetch OBIS occurrences and convert to a spatial grid

Retrieves occurrence records from OBIS via
[`robis::occurrence()`](https://rdrr.io/pkg/robis/man/occurrence.html)
and aggregates them into a spatial grid using one of three grid systems:
geohash, H3, or A5.

## Usage

``` r
get_occ_gridded(
  taxonid = 141438,
  startdate = NULL,
  enddate = NULL,
  type_grid = "geohash",
  grid_res = 3
)
```

## Arguments

- taxonid:

  Integer. OBIS taxon ID. Default `141438` (whale shark).

- startdate:

  Character or `NULL`. Earliest date to include, in `"YYYY-MM-DD"`
  format. Default `NULL`.

- enddate:

  Character or `NULL`. Latest date to include, in `"YYYY-MM-DD"` format.
  Default `NULL`.

- type_grid:

  Character. Grid system to use: `"geohash"`, `"h3"`, or `"a5"`. Default
  `"geohash"`.

- grid_res:

  Integer. Grid resolution passed to the corresponding converter
  ([`occ_to_geohashgrid()`](https://iobis.github.io/obis-recipes/reference/occ_to_geohashgrid.md),
  [`occ_to_h3grid()`](https://iobis.github.io/obis-recipes/reference/occ_to_h3grid.md),
  or
  [`occ_to_a5grid()`](https://iobis.github.io/obis-recipes/reference/occ_to_a5grid.md)).
  Default `3`.

## Value

An [sf::sf](https://r-spatial.github.io/sf/reference/sf.html) object
with one row per occupied cell and a `records` column containing the
occurrence count.

## Examples

``` r
if (FALSE) { # \dontrun{
# Geohash grid at resolution 3
get_occ_gridded(taxonid = 141438, type_grid = "geohash", grid_res = 3)

# H3 hexagonal grid with date filter
get_occ_gridded(
    taxonid   = 141438,
    startdate = "2010-01-01",
    type_grid = "h3",
    grid_res  = 3
)

# A5 pentagonal grid
get_occ_gridded(taxonid = 141438, type_grid = "a5", grid_res = 3)
} # }
```
