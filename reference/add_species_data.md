# Add OBIS species occurrence data to a map

Fetches OBIS occurrence tiles for a given taxon and adds a colour-scaled
fill layer (and optional record-count labels) to an existing map.

## Usage

``` r
add_species_data(
  map,
  taxonid = 126436,
  startdate = NULL,
  enddate = NULL,
  breaks = c(0, 10, 100, 1000, 10000),
  colors = c("#2c7bb6", "#abd9e9", "#ffffbf", "#fdae61", "#d7191c"),
  palette = NULL,
  legend = FALSE
)
```

## Arguments

- map:

  A map object returned by
  [`blank_map()`](https://iobis.github.io/obis-recipes/reference/blank_map.md),
  [`grey_map()`](https://iobis.github.io/obis-recipes/reference/grey_map.md),
  [`carto_map()`](https://iobis.github.io/obis-recipes/reference/carto_map.md),
  or any compatible `maplibre`/`mapboxgl` object.

- taxonid:

  Integer or character. OBIS taxon identifier. Default: `126436`.

- startdate:

  Character or NULL. ISO 8601 start date filter (e.g. `"2000-01-01"`).
  Default: `NULL` (no filter).

- enddate:

  Character or NULL. ISO 8601 end date filter. Default: `NULL`.

- breaks:

  Numeric vector. Breakpoints for the colour scale. Default:
  `c(0, 10, 100, 1000, 10000)`.

- colors:

  Character vector of CSS colours, one per break. Ignored when `palette`
  is set. Default: a blue-to-red diverging palette.

- palette:

  Character or `NULL`. Name of an OBIS palette passed to
  [`obis_pal()`](https://iobis.github.io/obis-recipes/reference/obis_pal.md)
  to generate `length(breaks)` colours automatically. Accepts any name
  supported by
  [`scale_fill_obis_cont()`](https://iobis.github.io/obis-recipes/reference/scale_color_obis_cont.md)
  (e.g. `"thermal"`, `"rdbu"`, `"blues"`) or
  [`scale_color_obis_cat()`](https://iobis.github.io/obis-recipes/reference/scale_color_obis_cat.md)
  (e.g. `"okabe_ito"`). When `NULL` (default) the `colors` argument is
  used as-is.

- legend:

  Logical. Whether to add a categorical legend. Default: `FALSE`.

## Value

The input `map` object with the species occurrence layer added.

## Examples

``` r
if (FALSE) { # \dontrun{
blank_map() |> add_species_data()

grey_map() |>
  add_species_data(
    taxonid  = 955271,
    breaks   = c(0, 5, 50, 500, 5000),
    legend   = TRUE
  )

# Use a named OBIS palette
grey_map() |>
  add_species_data(taxonid = 126436, palette = "thermal")

blank_map() |>
  add_species_data(taxonid = 126436, palette = "mako",
                   breaks = c(0, 10, 100, 1000))
} # }
```
