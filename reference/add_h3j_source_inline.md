# Add an inline H3J source to a MapLibre map

Encodes a data frame of H3 cells as an H3J JSON blob, base64-encodes it
as a `data:` URI, and adds it as a vector source via `add_h3j_source()`.
This avoids the need for a separate file or server.

## Usage

``` r
add_h3j_source_inline(map, id, df, h3_col = "h3")
```

## Arguments

- map:

  A map object (e.g. from
  [`blank_map()`](https://iobis.github.io/obis-recipes/reference/blank_map.md)).

- id:

  Character. Source identifier used when referencing the layer.

- df:

  A data frame with at least one column of H3 cell index strings. All
  other columns are included as properties on each cell feature.

- h3_col:

  Character. Name of the column containing H3 cell indices. Default:
  `"h3"`.

## Value

The input `map` object with the H3J vector source attached.

## Examples

``` r
if (FALSE) { # \dontrun{
library(duckdb)
library(h3jsr)
library(dplyr)

con <- dbConnect(duckdb())
df <- dbGetQuery(con, "
  SELECT records, cell
  FROM read_parquet('s3://obis-products/speciesgrids/h3_7/*')
  WHERE species = 'Minuca rapax'
")
df <- df |>
  mutate(h3 = h3jsr::get_parent(cell, 3)) |>
  group_by(h3) |>
  summarise(value = sum(records))

blank_map(projection = "mercator") |>
  add_h3j_source_inline("h3source", df = df, h3_col = "h3") |>
  add_fill_layer(
    id           = "h3layer",
    source       = "h3source",
    fill_color   = interpolate(
      column = "value",
      values = c(0, 5, 10, 15, 20),
      stops  = c("#2c7bb6", "#abd9e9", "#ffffbf", "#fdae61", "#d7191c")
    ),
    fill_opacity = 0.8
  ) |>
  fit_bounds(get_species_extent(taxonid = 955271))
} # }
```
