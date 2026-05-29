

<!-- README.md is generated from README.qmd. Please edit that file -->

# obisrecipes

> **Internal use only.** This package is developed for the [OBIS
> Secretariat](https://obis.org) and OBIS nodes. The API may change
> without notice as internal workflows evolve.

`obisrecipes` is an R package of reusable visualization and mapping
functions for [Ocean Biodiversity Information System
(OBIS)](https://obis.org) data. It covers three areas:

- **ggplot2 styles** — a light theme, a dark marine theme,
  colorblind-safe color scales, a horizontal colourbar guide, and an
  OBIS/IOC logo overlay.
- **Static maps** — ggplot2-based world basemaps, grid converters
  (geohash, H3, A5), and an occurrence layer for plotting species
  distributions.
- **Dynamic maps** — interactive WebGL maps via `mapgl`, a DeckGL H3
  hexagon widget, and helpers for adding species data and map controls.

## Installation

Install the development version from GitHub:

``` r
# install.packages("pak")
pak::pak("iobis/obis-recipes")
```

## Quick start

### ggplot2 styles

``` r
library(obisrecipes)
library(ggplot2)

ggplot(iris, aes(Sepal.Length, Petal.Length, color = Species)) +
    geom_point(size = 2.5) +
    scale_color_obis_cat() +
    labs(title = "Iris measurements by species",
         x = "Sepal length", y = "Petal length") +
    theme_obis(legend_position = "bottom")
```

<img src="man/figures/README-ggplot-example-1.png"
style="width:100.0%" />

### Colorbars

``` r
ggplot(faithfuld, aes(waiting, eruptions, fill = density)) +
    geom_tile() +
    scale_fill_obis_cont("thermal") +
    guides(fill = guide_colourbar_h(title = "Density")) +
    labs(title = "Old Faithful eruption density",
         x = "Waiting time (min)", y = "Eruption duration (min)") +
    theme_obis(legend_position = "bottom")
```

<img src="man/figures/README-colorbar-light-1.png"
style="width:100.0%" />

``` r
ggplot(faithfuld, aes(waiting, eruptions, fill = density)) +
    geom_tile() +
    scale_fill_obis_cont("mako") +
    guides(fill = guide_colourbar_h(title = "Density",
                                    barwidth = grid::unit(14, "lines"))) +
    labs(title = "Old Faithful eruption density",
         x = "Waiting time (min)", y = "Eruption duration (min)") +
    theme_obis_dark(legend_position = "bottom")
```

<img src="man/figures/README-colorbar-dark-1.png"
style="width:100.0%" />

### Static maps

``` r
grey_map_s()
```

<img src="man/figures/README-static-basemap-1.png"
style="width:100.0%" />

Focused regional view with gridded occurrence data:

``` r
occ <- robis::occurrence(taxonid = 126983, startdate = "2010-01-01")
#> 
Retrieved 5000 records of approximately 10940 (45%)
Retrieved 10000 records of
#> approximately 10940 (91%)
Retrieved 10940 records of approximately 10940 (100%)

grey_map_s(plot_xlim = c(-95, 15), plot_ylim = c(10, 70)) |>
    add_species_data(
        grid_data     = occ_to_geohashgrid(occ, grid_res = 3),
        limit_by_bbox = FALSE,
        plot_xlim     = c(-95, 15),
        plot_ylim     = c(10, 70)
    )
#> Coordinate system already present.
#> ℹ Adding new coordinate system, which will replace the existing one.
```

<img src="man/figures/README-static-species-1.png"
style="width:100.0%" />

### Dynamic maps

Dynamic maps require an internet connection and render as interactive
widgets. Run interactively in RStudio or embed in R Markdown / Quarto
documents:

``` r
grey_map() |>
    add_species_data(taxonid = 126436, legend = TRUE)
```

## Vignettes

| Vignette | Topic |
|----|----|
| `vignette("ggplot-styles",  package = "obisrecipes")` | Themes, color scales, colourbar guide, logo overlay |
| `vignette("static-maps",    package = "obisrecipes")` | Basemaps, grid converters, offline and API-based plotting |
| `vignette("dynamic-maps",   package = "obisrecipes")` | Interactive WebGL maps and the H3 widget |

## Development

``` r
# Load all functions without installing
devtools::load_all(".")

# Render README
devtools::build_readme()

# Build vignettes
devtools::build_vignettes()
```

------------------------------------------------------------------------

Developed by the [OBIS Secretariat](https://obis.org) · Hosted under the
[Intergovernmental Oceanographic Commission
(IOC)](https://www.ioc.unesco.org) of UNESCO.
