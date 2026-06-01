# Light OBIS ggplot2 theme

A clean, minimal ggplot2 theme using Roboto with a white background and
subtle blue-grey accent colors suited to marine data visualizations.
Call
[`obis_load_fonts()`](https://iobis.github.io/obis-recipes/reference/obis_load_fonts.md)
once per session to enable the Roboto font.

## Usage

``` r
theme_obis(
  base_size = 11,
  base_family = "roboto",
  legend_position = "right",
  corner_axis_titles = TRUE
)
```

## Arguments

- base_size:

  Numeric. Base font size in pt. Default `11`.

- base_family:

  Character. Base font family. Default `"Roboto"`.

- legend_position:

  Character or `"none"`. Position of the legend passed to
  [`ggplot2::theme()`](https://ggplot2.tidyverse.org/reference/theme.html).
  Default `"right"`.

## Value

A [ggplot2::theme](https://ggplot2.tidyverse.org/reference/theme.html)
object.

## Examples

``` r
library(ggplot2)
ggplot(mtcars, aes(wt, mpg)) +
    geom_point() +
    theme_obis()
```
