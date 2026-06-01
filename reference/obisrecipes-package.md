# obisrecipes: Visualization and mapping tools for OBIS data

`obisrecipes` provides a curated set of reusable functions for
visualizing and mapping biodiversity data from the Ocean Biodiversity
Information System (OBIS). It is developed primarily for **internal use
by the OBIS Secretariat and OBIS nodes**, and covers three main areas:

- **ggplot2 styles** — a light theme
  ([`theme_obis()`](https://iobis.github.io/obis-recipes/reference/theme_obis.md)),
  a dark marine theme
  ([`theme_obis_dark()`](https://iobis.github.io/obis-recipes/reference/theme_obis_dark.md)),
  colorblind-safe categorical and continuous color scales, a horizontal
  colourbar guide, and a logo overlay helper.

- **Static maps** — ggplot2-based world basemaps
  ([`blank_map_s()`](https://iobis.github.io/obis-recipes/reference/blank_map_s.md),
  [`grey_map_s()`](https://iobis.github.io/obis-recipes/reference/grey_map_s.md)),
  grid converters (geohash, H3, A5), and an occurrence layer function
  for plotting species distributions.

- **Dynamic maps** — interactive WebGL maps via `mapgl`
  ([`blank_map()`](https://iobis.github.io/obis-recipes/reference/blank_map.md),
  [`grey_map()`](https://iobis.github.io/obis-recipes/reference/grey_map.md),
  [`carto_map()`](https://iobis.github.io/obis-recipes/reference/carto_map.md)),
  a DeckGL H3 hexagon widget
  ([`maplibre_h3()`](https://iobis.github.io/obis-recipes/reference/maplibre_h3.md)),
  and helpers for adding species data and map controls.

## Intended audience

This package is designed for OBIS Secretariat staff and OBIS node
managers who produce maps and data-visualization outputs using OBIS
data. The API may change without notice as internal workflows evolve.

## See also

Vignettes:

- [`vignette("ggplot-styles", package = "obisrecipes")`](https://iobis.github.io/obis-recipes/articles/ggplot-styles.md)

- [`vignette("static-maps", package = "obisrecipes")`](https://iobis.github.io/obis-recipes/articles/static-maps.md)

- [`vignette("dynamic-maps", package = "obisrecipes")`](https://iobis.github.io/obis-recipes/articles/dynamic-maps.md)

## Author

**Maintainer**: Silas Principe <s.principe@unesco.org>
([ORCID](https://orcid.org/0000-0002-8059-6304))

Authors:

- OBIS Secretariat <helpdesk@obis.org>
