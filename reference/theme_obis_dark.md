# Dark marine ggplot2 theme

A deep-ocean dark theme using Roboto with a dark navy background. Pairs
well with the `"mako"`, `"thermal"`, and `"haline"` continuous scales.
Call
[`obis_load_fonts()`](https://iobis.github.io/obis-recipes/reference/obis_load_fonts.md)
once per session to enable the Roboto font.

## Usage

``` r
theme_obis_dark(
  base_size = 11,
  base_family = "roboto",
  legend_position = "right"
)
```

## Arguments

- base_size:

  Numeric. Base font size in pt. Default `11`.

- base_family:

  Character. Base font family. Default `"Roboto"`.

- legend_position:

  Character or `"none"`. Legend position. Default `"right"`.

## Value

A [ggplot2::theme](https://ggplot2.tidyverse.org/reference/theme.html)
object.

## Examples

``` r
library(ggplot2)
ggplot(mtcars, aes(wt, mpg)) +
    geom_point(color = "#56B4E9") +
    theme_obis_dark()
```
