#' obisrecipes: Visualization and mapping tools for OBIS data
#'
#' @description
#' `obisrecipes` provides a curated set of reusable functions for visualizing
#' and mapping biodiversity data from the Ocean Biodiversity Information System
#' (OBIS). It is developed primarily for **internal use by the OBIS Secretariat
#' and OBIS nodes**, and covers three main areas:
#'
#' - **ggplot2 styles** — a light theme (`theme_obis()`), a dark marine theme
#'   (`theme_obis_dark()`), colorblind-safe categorical and continuous color
#'   scales, a horizontal colourbar guide, and a logo overlay helper.
#' - **Static maps** — ggplot2-based world basemaps (`blank_map_s()`,
#'   `grey_map_s()`), grid converters (geohash, H3, A5), and an occurrence
#'   layer function for plotting species distributions.
#' - **Dynamic maps** — interactive WebGL maps via `mapgl` (`blank_map()`,
#'   `grey_map()`, `carto_map()`), a DeckGL H3 hexagon widget
#'   (`maplibre_h3()`), and helpers for adding species data and map controls.
#'
#' @section Intended audience:
#' This package is designed for OBIS Secretariat staff and OBIS node managers
#' who produce maps and data-visualization outputs using OBIS data. The API
#' may change without notice as internal workflows evolve.
#'
#' @seealso
#' Vignettes:
#' \itemize{
#'   \item `vignette("ggplot-styles",  package = "obisrecipes")`
#'   \item `vignette("static-maps",    package = "obisrecipes")`
#'   \item `vignette("dynamic-maps",   package = "obisrecipes")`
#' }
#'
#' @keywords internal
"_PACKAGE"

## usethis namespace: start
## usethis namespace: end
NULL
