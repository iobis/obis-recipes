# Save a ggplot with proportionally scaled text

A wrapper around
[`ggplot2::ggsave()`](https://ggplot2.tidyverse.org/reference/ggsave.html)
that keeps all theme elements (text, lines, points, legend keys) at the
same *apparent* size regardless of the output dimensions. It works by
rendering the plot at a reference size and then letting `ggsave` scale
the raster to the target dimensions, so a figure intended for a 3.5 ×
2.5 in journal column looks identical whether saved at that size or at 7
× 5 in for a slide.

## Usage

``` r
obis_ggsave(
  filename,
  plot = ggplot2::last_plot(),
  width = 7,
  height = 5,
  ref_width = 7,
  ref_height = 5,
  units = "in",
  dpi = 300,
  bg = "white",
  ...
)
```

## Arguments

- filename:

  File path for the output (extension determines format).

- plot:

  A ggplot2 (or cowplot) object. Defaults to the last plot displayed
  ([`ggplot2::last_plot()`](https://ggplot2.tidyverse.org/reference/get_last_plot.html)).

- width, height:

  Numeric. Target output dimensions in `units`.

- ref_width, ref_height:

  Numeric. Reference dimensions at which the plot was designed. Defaults
  match
  [`ggplot2::ggsave()`](https://ggplot2.tidyverse.org/reference/ggsave.html)
  defaults (`7` × `5` in). Adjust if you authored the plot at a
  different preview size.

- units:

  Character. Units for `width`, `height`, `ref_width`, and `ref_height`.
  One of `"in"` (default), `"cm"`, `"mm"`, or `"px"`.

- dpi:

  Numeric. Output resolution. Default `300` (publication quality).

- bg:

  Character. Background colour. Default `"white"`.

- ...:

  Additional arguments passed to
  [`ggplot2::ggsave()`](https://ggplot2.tidyverse.org/reference/ggsave.html).

## Value

The `filename` path, invisibly (same as
[`ggplot2::ggsave()`](https://ggplot2.tidyverse.org/reference/ggsave.html)).

## Details

The scaling factor is computed as \\\sqrt{(w \times h) / (w\_\text{ref}
\times h\_\text{ref})}\\, the geometric mean of the area ratio, so both
dimensions are treated equally.

## Examples

``` r
if (FALSE) { # \dontrun{
library(ggplot2)
p <- ggplot(mtcars, aes(wt, mpg)) +
    geom_point(size = 1.5) +
    labs(x = "Weight (1000 lbs)", y = "MPG") +
    theme_obis_pub()

# Single-column journal figure (3.5 × 2.5 in) — text scales down
obis_ggsave("fig1_single.pdf", p, width = 3.5, height = 2.5)

# Double-column figure (7 × 5 in) — same apparent text size
obis_ggsave("fig1_double.pdf", p, width = 7, height = 5)

# Poster panel (14 × 10 in) — text scales up
obis_ggsave("fig1_poster.pdf", p, width = 14, height = 10)
} # }
```
