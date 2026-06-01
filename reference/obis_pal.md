# Generate a colour vector from a named OBIS palette

Interpolates or samples exactly `n` hex colours from any palette
available in
[`scale_fill_obis_cont()`](https://iobis.github.io/obis-recipes/reference/scale_color_obis_cont.md)
or
[`scale_color_obis_cat()`](https://iobis.github.io/obis-recipes/reference/scale_color_obis_cat.md).
Useful for passing OBIS palettes to functions that expect a plain
character vector of colours, such as
[`add_species_data()`](https://iobis.github.io/obis-recipes/reference/add_species_data.md)
in the dynamic-map helpers.

## Usage

``` r
obis_pal(name, n, direction = 1)
```

## Arguments

- name:

  Character. Palette name — any value accepted by
  [`scale_fill_obis_cont()`](https://iobis.github.io/obis-recipes/reference/scale_color_obis_cont.md)
  (excluding viridis options) or
  [`scale_color_obis_cat()`](https://iobis.github.io/obis-recipes/reference/scale_color_obis_cat.md).

- n:

  Integer. Number of colours to return.

- direction:

  Numeric. `1` for the palette as-is, `-1` to reverse. Default `1`.

## Value

A character vector of `n` hex colour codes.

## Details

Continuous palettes (`"thermal"`, `"haline"`, `"deep"`, `"rdbu"`,
`"prgn"`, `"blues"`, `"greens"`) are interpolated with
[`grDevices::colorRampPalette()`](https://rdrr.io/r/grDevices/colorRamp.html),
so any value of `n` is valid. Categorical palettes (`"okabe_ito"`,
`"tol"`, `"ibm"`) are sampled from the first `n` colours; requesting
more colours than the palette contains raises an error.

## Examples

``` r
obis_pal("thermal", 5)
#> [1] "#042333" "#5580B8" "#CDE6C9" "#F3BA3B" "#B12010"
obis_pal("rdbu", 7)
#> [1] "#053061" "#3783BB" "#A6CFE3" "#F7F7F7" "#F7B799" "#CA4841" "#67001F"
obis_pal("blues", 3, direction = -1)
#> [1] "#08306B" "#6BAED6" "#F7FBFF"
obis_pal("okabe_ito", 3)
#> [1] "#E69F00" "#56B4E9" "#009E73"
```
