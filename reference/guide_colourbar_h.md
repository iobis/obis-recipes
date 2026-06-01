# Horizontal colourbar guide

Returns a
[`ggplot2::guide_colorbar()`](https://ggplot2.tidyverse.org/reference/guide_colourbar.html)
pre-configured as a thin horizontal bar, styled similarly to
matplotlib's default colorbar. Intended for use with continuous fill or
color scales via the `guide` argument or
[`ggplot2::guides()`](https://ggplot2.tidyverse.org/reference/guides.html).

## Usage

``` r
guide_colourbar_h(
  title = ggplot2::waiver(),
  barwidth = grid::unit(12, "lines"),
  barheight = grid::unit(0.4, "lines"),
  title_position = "top",
  title_hjust = 0.5,
  label_position = "bottom",
  ...
)
```

## Arguments

- title:

  Character or
  [`ggplot2::waiver()`](https://ggplot2.tidyverse.org/reference/waiver.html).
  Guide title. Default
  [`ggplot2::waiver()`](https://ggplot2.tidyverse.org/reference/waiver.html)
  (inherits from scale name).

- barwidth:

  A [`grid::unit()`](https://rdrr.io/r/grid/unit.html) object
  controlling the bar width. Default `grid::unit(12, "lines")`.

- barheight:

  A [`grid::unit()`](https://rdrr.io/r/grid/unit.html) object
  controlling the bar height. Default `grid::unit(0.4, "lines")`.

- title_position:

  Character. Where to place the title relative to the bar. One of
  `"top"`, `"bottom"`, `"left"`, `"right"`. Default `"top"`.

- title_hjust:

  Numeric in `[0, 1]`. Horizontal justification of the title. Default
  `0.5` (centered).

- label_position:

  Character. Where to place tick labels. One of `"top"`, `"bottom"`.
  Default `"bottom"`.

- ...:

  Additional arguments passed to
  [`ggplot2::guide_colorbar()`](https://ggplot2.tidyverse.org/reference/guide_colourbar.html).

## Value

A ggplot2 guide object.

## Examples

``` r
library(ggplot2)
ggplot(faithfuld, aes(waiting, eruptions, fill = density)) +
    geom_tile() +
    scale_fill_obis_cont("thermal") +
    guides(fill = guide_colourbar_h(title = "Density")) +
    theme_obis(legend_position = "bottom")
```
