# Get the geographic extent of a species from OBIS

Queries the OBIS API occurrence grid endpoint and returns an `sf` object
that can be passed to
[`fit_bounds()`](https://iobis.github.io/obis-recipes/reference/fit_bounds.md)
to zoom a map to the species range.

## Usage

``` r
get_species_extent(taxonid, startdate = NULL, enddate = NULL, precision = 2)
```

## Arguments

- taxonid:

  Integer or character. OBIS taxon identifier.

- startdate:

  Character or NULL. ISO 8601 start date filter. Default: `NULL`.

- enddate:

  Character or NULL. ISO 8601 end date filter. Default: `NULL`.

- precision:

  Integer. H3 resolution used for the grid query (1–15). Default: `2`.

## Value

An `sf` object with the occurrence grid polygons.

## Examples

``` r
if (FALSE) { # \dontrun{
ext <- get_species_extent(taxonid = 955271)

blank_map(projection = "mercator") |>
  add_species_data(taxonid = 955271) |>
  fit_bounds(ext)
} # }
```
