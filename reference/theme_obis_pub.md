# Publication-quality ggplot2 theme for OBIS

A minimal, journal-ready theme following the visual conventions of top
scientific publications (Nature, Science, Cell, One Earth). Key
characteristics: clean L-shaped axes with outward tick marks, no
background grid, and a compact layout suited to single- and multi-panel
figures. Call
[`obis_load_fonts()`](https://iobis.github.io/obis-recipes/reference/obis_load_fonts.md)
once per session to enable the Roboto font.

## Usage

``` r
theme_obis_pub(
  base_size = 11,
  base_family = "roboto",
  legend_position = "right",
  grid = c("none", "y", "xy")
)
```

## Arguments

- base_size:

  Numeric. Base font size in pt. Default `11`. Reduce to 7–8 pt when
  exporting at narrow journal column widths (≤ 3.5 in), or use
  [`obis_ggsave()`](https://iobis.github.io/obis-recipes/reference/obis_ggsave.md)
  to handle scaling automatically.

- base_family:

  Character. Base font family. Default `"roboto"`. Swap for
  `"helvetica"` or `"arial"` if those are available on your system.

- legend_position:

  Character or `"none"`. Position of the legend. Default `"right"`.

- grid:

  Character. Reference lines to draw: `"none"` (default, typical for
  Nature / Science), `"y"` for subtle major y-axis lines only, or `"xy"`
  for both axes.

## Value

A [ggplot2::theme](https://ggplot2.tidyverse.org/reference/theme.html)
object.

## Details

The default `base_size` of `11` is comfortable for screen use and for
figures saved at standard dimensions (≈ 7 × 5 in). When targeting the
narrow column widths of print journals (e.g. 3.5 in single-column),
either reduce `base_size` to 7–8 or use
[`obis_ggsave()`](https://iobis.github.io/obis-recipes/reference/obis_ggsave.md),
which rescales all elements proportionally to the output dimensions.

## Examples

``` r
library(ggplot2)
ggplot(mtcars, aes(wt, mpg)) +
    geom_point(size = 1.5) +
    labs(title = "Fuel efficiency", x = "Weight (1000 lbs)", y = "MPG") +
    theme_obis_pub()
```
