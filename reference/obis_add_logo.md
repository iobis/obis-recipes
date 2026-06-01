# Add OBIS and IOC logos to a ggplot

Overlays the OBIS and IOC logos at a chosen corner of a finished ggplot
using
[`cowplot::ggdraw()`](https://wilkelab.org/cowplot/reference/ggdraw.html).
The logos are placed side by side matching the style used on the OBIS
website (IOC left, OBIS right).

## Usage

``` r
obis_add_logo(
  plot,
  position = c("bottomright", "bottomleft", "topright", "topleft"),
  logo_size = 0.07,
  padding = 0.015,
  fig_asp = 7/5
)
```

## Arguments

- plot:

  A ggplot2 object.

- position:

  Character. Corner for the logos. One of `"bottomright"`,
  `"bottomleft"`, `"topright"`, or `"topleft"`. Default `"bottomright"`.

- logo_size:

  Numeric in `(0, 1)`. Height of the IOC logo as a fraction of the
  figure height. Default `0.07`.

- padding:

  Numeric in `(0, 1)`. Margin from the figure edge, as a fraction of the
  figure height. Default `0.015`.

- fig_asp:

  Numeric. Figure width / height ratio used to correct the logo aspect
  ratios in normalised coordinates. Default `7 / 5`.

## Value

A `ggdraw` object that prints and saves like a ggplot.

## Details

Because logo width in normalised figure coordinates depends on the
physical aspect ratio of the output, pass `fig_asp = width / height` to
match the dimensions you plan to use in
[`ggplot2::ggsave()`](https://ggplot2.tidyverse.org/reference/ggsave.html).
The default (`7 / 5`) works well for the standard 7 × 5 inch ggplot
figure.

## Examples

``` r
library(ggplot2)
p <- ggplot(mtcars, aes(wt, mpg)) +
    geom_point(color = "#0072B2", size = 2) +
    labs(title = "Fuel efficiency", x = "Weight (1000 lbs)", y = "MPG") +
    theme_obis()
obis_add_logo(p)
```
