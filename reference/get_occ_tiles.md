# Fetch pre-gridded occurrence tiles from the OBIS API

Queries the OBIS occurrence grid endpoint, which returns geohash cells
pre-aggregated server-side. This is faster than downloading raw records
for large taxa.

## Usage

``` r
get_occ_tiles(taxonid = 141438, startdate = NULL, enddate = NULL, grid_res = 3)
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

- grid_res:

  Integer. Geohash precision level (1–9). Default `3`.

## Value

An [sf::sf](https://r-spatial.github.io/sf/reference/sf.html) object
(GeoJSON FeatureCollection) with one row per occupied geohash cell and a
`records` column. A warning is issued if the result contains exactly
100,000 features, indicating the API limit may have been reached and
results could be truncated.

## Examples

``` r
if (FALSE) { # \dontrun{
# All records for whale shark at geohash resolution 3
get_occ_tiles(taxonid = 141438, grid_res = 3)

# With date filter
get_occ_tiles(
    taxonid   = 141438,
    startdate = "2020-01-01",
    enddate   = "2024-12-31",
    grid_res  = 3
)
} # }
```
