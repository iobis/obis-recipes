# OBIS-style binned color scale for ggplot2

Returns a list of two ggplot2 components — a
[`ggplot2::scale_fill_manual()`](https://ggplot2.tidyverse.org/reference/scale_manual.html)
with labelled break bins and a
[`ggplot2::theme()`](https://ggplot2.tidyverse.org/reference/theme.html)
that styles the legend — matching the visual style used on the OBIS
taxon pages.

## Usage

``` r
obis_scale(
  breaks = c(1, 10, 100, 1000, 10000),
  colors = c("#2c7bb6", "#abd9e9", "#ffffbf", "#fdae61", "#d7191c"),
  legend_title = "Records",
  na_color = "grey80",
  key_spacing = 4
)
```

## Arguments

- breaks:

  Numeric vector of bin boundaries. The last value is used as the label
  for the open-ended top bin. Default `c(1, 10, 100, 1000, 10000)`.

- colors:

  Character vector of hex colors, one per bin. Must be the same length
  as `breaks`. Default is a blue-to-red diverging palette.

- legend_title:

  Character. Title shown above the legend. Default `"Records"`.

- na_color:

  Character. Fill color for `NA` values. Default `"grey80"`.

- key_spacing:

  Numeric. Vertical spacing between legend keys in points. Default `4`.

## Value

A list of two ggplot2 objects that can be added to a plot with `+`.

## Examples

``` r
if (FALSE) { # \dontrun{
grey_map_s() |>
    add_species_data_s(grid_data = get_occ_tiles(141438)) +
    obis_scale(breaks = c(1, 10, 100, 1000, 10000))
} # }
```
