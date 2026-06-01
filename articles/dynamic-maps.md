# Dynamic Maps

``` r

library(obisrecipes)
```

The dynamic-map functions produce interactive WebGL maps (via `mapgl`)
that render in the RStudio viewer, R Markdown documents, and Shiny apps.
The workflow mirrors the static-map approach:

1.  Create a basemap with
    [`blank_map()`](https://iobis.github.io/obis-recipes/reference/blank_map.md),
    [`grey_map()`](https://iobis.github.io/obis-recipes/reference/grey_map.md),
    or
    [`carto_map()`](https://iobis.github.io/obis-recipes/reference/carto_map.md).
2.  Add species occurrence data with
    [`add_species_data()`](https://iobis.github.io/obis-recipes/reference/add_species_data.md).
3.  Optionally add UI controls with
    [`add_map_controls()`](https://iobis.github.io/obis-recipes/reference/add_map_controls.md).

> **Note:** All examples in this vignette require an internet connection
> because the map tiles and OBIS occurrence data are fetched at render
> time. The code chunks are marked `eval = FALSE` to allow offline
> builds; run them interactively to see the output.

## Basemaps

### Blank white basemap

``` r

blank_map()
```

Switch to a flat Mercator projection:

``` r

blank_map(projection = "mercator")
```

### Grey OBIS-style basemap

[`grey_map()`](https://iobis.github.io/obis-recipes/reference/grey_map.md)
matches the style used on OBIS taxon pages: grey ocean, white land,
optional GEBCO bathymetry overlay.

``` r

grey_map()
```

``` r

grey_map(add_bathymetry = FALSE)
```

### Carto basemaps

``` r

carto_map()
```

``` r

carto_map(carto_map = "dark-matter")
```

## Species occurrence layer

[`add_species_data()`](https://iobis.github.io/obis-recipes/reference/add_species_data.md)
fetches OBIS occurrence tiles for a taxon and adds a colour-scaled fill
layer to the map.

Default species (taxonid 126436) on a blank map:

``` r

blank_map() |> add_species_data()
```

Custom species with custom breaks and a legend:

``` r

grey_map() |>
    add_species_data(
        taxonid = 955271,
        breaks  = c(0, 5, 50, 500, 5000),
        legend  = TRUE
    )
```

Fit the map view to the species extent after adding the layer:

``` r

ext <- get_species_extent(taxonid = 955271)

blank_map(projection = "mercator") |>
    add_species_data(taxonid = 955271) |>
    fit_bounds(ext)
```

### Using OBIS palettes

Pass any named OBIS palette via the `palette` argument and
[`add_species_data()`](https://iobis.github.io/obis-recipes/reference/add_species_data.md)
will call
[`obis_pal()`](https://iobis.github.io/obis-recipes/reference/obis_pal.md)
internally to generate one colour per break. This works with all
palettes from
[`scale_fill_obis_cont()`](https://iobis.github.io/obis-recipes/reference/scale_color_obis_cont.md)
and
[`scale_color_obis_cat()`](https://iobis.github.io/obis-recipes/reference/scale_color_obis_cat.md).

``` r

grey_map() |> add_species_data(taxonid = 126436, palette = "thermal")
```

``` r

grey_map() |> add_species_data(taxonid = 126436, palette = "blues")
```

Pair fewer breaks with a diverging palette:

``` r

blank_map() |>
    add_species_data(
        taxonid = 126436,
        breaks  = c(0, 10, 100, 1000),
        palette = "rdbu",
        legend  = TRUE
    )
```

[`obis_pal()`](https://iobis.github.io/obis-recipes/reference/obis_pal.md)
can also be called directly to preview colours or pass them to other
`mapgl` layer functions:

``` r

obis_pal("thermal", 5)
#> [1] "#042333" "#4a69a9" "#cde6c9" "#f0a120" "#b12010"

obis_pal("rdbu", 7)
obis_pal("blues", 4, direction = -1)  # reversed: dark → light
```

## Map controls

[`add_map_controls()`](https://iobis.github.io/obis-recipes/reference/add_map_controls.md)
adds fullscreen, globe-projection toggle, and scale bar controls to any
map.

``` r

blank_map(projection = "none") |> add_map_controls()
```

Disable the globe toggle and move the scale bar:

``` r

grey_map() |>
    add_map_controls(globe = FALSE, scale_position = "bottom-right")
```

## Inline H3J source (requires duckdb, h3jsr, dplyr)

[`add_h3j_source_inline()`](https://iobis.github.io/obis-recipes/reference/add_h3j_source_inline.md)
encodes a data frame of H3 cells as a `data:` URI and registers it as a
vector source — no file or tile server needed. Use it with any `mapgl`
layer function
(e.g. [`mapgl::add_fill_layer()`](https://walker-data.com/mapgl/reference/add_fill_layer.html)).

``` r

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
    mapgl::add_fill_layer(
        id           = "h3layer",
        source       = "h3source",
        fill_color   = mapgl::interpolate(
            column = "value",
            values = c(0, 5, 10, 15, 20),
            stops  = c("#2c7bb6", "#abd9e9", "#ffffbf", "#fdae61", "#d7191c")
        ),
        fill_opacity = 0.8
    ) |>
    mapgl::fit_bounds(get_species_extent(taxonid = 955271))
```

## DeckGL H3 widget — `maplibre_h3()`

[`maplibre_h3()`](https://iobis.github.io/obis-recipes/reference/maplibre_h3.md)
creates a self-contained htmlwidget combining a MapLibre GL basemap with
a DeckGL `H3HexagonLayer`. Suitable for species richness, record counts,
or any per-H3-cell metric.

``` r

# df from the duckdb query above
maplibre_h3(df, center = c(3.5, 55), zoom = 4)
```

Enable 3-D extrusion with `extruded = TRUE`:

``` r

maplibre_h3(df, extruded = TRUE, elevation_scale = 1000)
```
