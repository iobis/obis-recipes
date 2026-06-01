# Colorblind-safe continuous color scale

Maps a continuous variable to a perceptually uniform, colorblind-safe
color gradient. Nine palettes are available:

## Usage

``` r
scale_color_obis_cont(palette = "mako", direction = 1, ...)

scale_fill_obis_cont(palette = "mako", direction = 1, ...)
```

## Arguments

- palette:

  Character. One of `"mako"`, `"cividis"`, `"thermal"`, `"haline"`,
  `"deep"`, `"rdbu"`, `"prgn"`, `"blues"`, or `"greens"`. Default
  `"mako"`.

- direction:

  Numeric. `1` for the palette as-is, `-1` to reverse. Default `1`.

- ...:

  Additional arguments passed to the underlying scale function.

## Value

A ggplot2 scale object.

## Details

|             |             |                                            |
|-------------|-------------|--------------------------------------------|
| Palette     | Origin      | Recommended for                            |
| `"mako"`    | viridis     | abundance, density                         |
| `"cividis"` | viridis     | general-purpose (optimized for CVD)        |
| `"thermal"` | cmocean     | sea surface temperature                    |
| `"haline"`  | cmocean     | salinity                                   |
| `"deep"`    | cmocean     | depth / bathymetry                         |
| `"rdbu"`    | ColorBrewer | diverging: blue → white → red              |
| `"prgn"`    | ColorBrewer | diverging: purple → white → green          |
| `"blues"`   | ColorBrewer | single-hue sequential (light → dark blue)  |
| `"greens"`  | ColorBrewer | single-hue sequential (light → dark green) |

## Examples

``` r
library(ggplot2)
ggplot(faithfuld, aes(waiting, eruptions, color = density)) +
    geom_point() +
    scale_color_obis_cont("thermal")

library(ggplot2)
ggplot(faithfuld, aes(waiting, eruptions, fill = density)) +
    geom_tile() +
    scale_fill_obis_cont("haline")
```
