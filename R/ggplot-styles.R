# ── Internal palette data ──────────────────────────────────────────────────────

#' @keywords internal
.palettes_cat <- list(
    okabe_ito = c(
        "#E69F00", "#56B4E9", "#009E73", "#F0E442",
        "#0072B2", "#D55E00", "#CC79A7", "#000000"
    ),
    tol = c(
        "#4477AA", "#EE6677", "#228833", "#CCBB44",
        "#66CCEE", "#AA3377", "#BBBBBB"
    )
)

#' @keywords internal
.palettes_cont <- list(
    thermal = c(
        "#042333", "#2c3e6f", "#4a69a9", "#6097c7",
        "#81c5d8", "#cde6c9", "#f1f4a0", "#f6d456",
        "#f0a120", "#da5e0e", "#b12010"
    ),
    haline = c(
        "#2a186c", "#1f4d9c", "#1f7db4", "#3badbf",
        "#67c8b8", "#a7d9a7", "#d6e59b", "#f7c843"
    ),
    deep = c(
        "#fdfecc", "#c5e8b8", "#6fc9b1", "#3d9ab5",
        "#1f5392", "#1d2e6e", "#0a0b43"
    )
)

# ── Font helper ────────────────────────────────────────────────────────────────

#' Load Roboto from Google Fonts
#'
#' Registers Roboto and Roboto Condensed via `sysfonts` and enables `showtext`
#' rendering. Call once per session before using [theme_obis()] or
#' [theme_obis_dark()].
#'
#' @return Invisible `NULL`, called for side effects.
#' @export
#'
#' @examples
#' obis_load_fonts()
obis_load_fonts <- function() {
    sysfonts::font_add_google("Roboto", "roboto")
    sysfonts::font_add_google("Roboto Condensed", "roboto_condensed")
    showtext::showtext_auto()
    invisible(NULL)
}

# ── Themes ─────────────────────────────────────────────────────────────────────

#' Light OBIS ggplot2 theme
#'
#' A clean, minimal ggplot2 theme using Roboto with a white background and
#' subtle blue-grey accent colors suited to marine data visualizations.
#' Call [obis_load_fonts()] once per session to enable the Roboto font.
#'
#' @param base_size Numeric. Base font size in pt. Default `11`.
#' @param base_family Character. Base font family. Default `"Roboto"`.
#' @param legend_position Character or `"none"`. Position of the legend passed
#'   to [ggplot2::theme()]. Default `"right"`.
#'
#' @return A [ggplot2::theme] object.
#' @export
#'
#' @examples
#' library(ggplot2)
#' ggplot(mtcars, aes(wt, mpg)) +
#'     geom_point() +
#'     theme_obis()
theme_obis <- function(
    base_size = 11,
    base_family = "roboto",
    legend_position = "right",
    corner_axis_titles = TRUE
) {
    if (corner_axis_titles) {
        axis_title_y_anlge <- 90
        axis_title_x_hjust <- axis_title_y_hjust <- 1
    } else {
        axis_title_y_anlge <- 0
        axis_title_x_hjust <- 0.5
        axis_title_y_hjust <- 0
    }

    ggplot2::theme_minimal(base_size = base_size, base_family = base_family) %+replace%
        ggplot2::theme(
            # Panel
            panel.background  = ggplot2::element_rect(fill = "white", color = NA),
            panel.grid.major.y  = ggplot2::element_line(color = "#e3e8ed", linewidth = 0.35),
            panel.grid.major.x = element_blank(),
            panel.grid.minor  = ggplot2::element_blank(),
            panel.border      = ggplot2::element_blank(),
            # Plot area
            plot.background   = ggplot2::element_rect(fill = "white", color = NA),
            plot.margin       = ggplot2::margin(12, 16, 10, 12),
            plot.title        = ggplot2::element_text(
                face = "bold", size = base_size * 1.25,
                color = "#1a2e44", margin = ggplot2::margin(b = 5),
                hjust = 0
            ),
            plot.subtitle     = ggplot2::element_text(
                size = base_size * 0.95, color = "#4a6275",
                margin = ggplot2::margin(b = 12),
                hjust = 0
            ),
            plot.caption      = ggplot2::element_text(
                size = base_size * 0.75, color = "#7a94a8",
                hjust = 1, margin = ggplot2::margin(t = 10)
            ),
            # Axes
            axis.title        = ggplot2::element_text(
                size = base_size * 0.9, color = "#2d4a5e"
            ),
            axis.title.x      = ggplot2::element_text(
                margin = ggplot2::margin(t = 8),
                hjust = axis_title_x_hjust
            ),
            axis.title.y      = ggplot2::element_text(
                margin = ggplot2::margin(r = 8),
                hjust = axis_title_y_hjust, angle = axis_title_y_anlge
            ),
            axis.text         = ggplot2::element_text(
                size = base_size * 0.85, color = "#4a6275"
            ),
            axis.ticks        = ggplot2::element_blank(),
            # Legend
            legend.position   = legend_position,
            legend.background = ggplot2::element_rect(fill = "white", color = NA),
            legend.margin     = ggplot2::margin(6, 10, 6, 10),
            legend.key        = ggplot2::element_rect(fill = "white", color = NA),
            legend.title      = ggplot2::element_text(
                size = base_size * 0.9, face = "bold", color = "#1a2e44"
            ),
            legend.text       = ggplot2::element_text(
                size = base_size * 0.85, color = "#4a6275"
            ),
            # Facet strips
            strip.background  = ggplot2::element_rect(fill = "#deeaf2", color = NA),
            strip.text        = ggplot2::element_text(
                face = "bold", size = base_size * 0.9, color = "#1a2e44",
                margin = ggplot2::margin(4, 8, 4, 8)
            ),
            complete = TRUE
        )
}

#' Dark marine ggplot2 theme
#'
#' A deep-ocean dark theme using Roboto with a dark navy background. Pairs
#' well with the `"mako"`, `"thermal"`, and `"haline"` continuous scales.
#' Call [obis_load_fonts()] once per session to enable the Roboto font.
#'
#' @param base_size Numeric. Base font size in pt. Default `11`.
#' @param base_family Character. Base font family. Default `"Roboto"`.
#' @param legend_position Character or `"none"`. Legend position. Default
#'   `"right"`.
#'
#' @return A [ggplot2::theme] object.
#' @export
#'
#' @examples
#' library(ggplot2)
#' ggplot(mtcars, aes(wt, mpg)) +
#'     geom_point(color = "#56B4E9") +
#'     theme_obis_dark()
theme_obis_dark <- function(
    base_size = 11,
    base_family = "roboto",
    legend_position = "right"
) {
    bg       <- "#0d1b2a"
    panel_bg <- "#12263a"
    grid_col <- "#1e3a52"
    text_hi  <- "#cdd9e5"
    text_lo  <- "#7a99b0"

    ggplot2::theme_minimal(base_size = base_size, base_family = base_family) %+replace%
        ggplot2::theme(
            # Panel
            panel.background  = ggplot2::element_rect(fill = panel_bg, color = NA),
            panel.grid.major  = ggplot2::element_line(color = grid_col, linewidth = 0.35),
            panel.grid.minor  = ggplot2::element_blank(),
            panel.border      = ggplot2::element_blank(),
            # Plot area
            plot.background   = ggplot2::element_rect(fill = bg, color = NA),
            plot.margin       = ggplot2::margin(12, 16, 10, 12),
            plot.title        = ggplot2::element_text(
                face = "bold", size = base_size * 1.25,
                color = text_hi, margin = ggplot2::margin(b = 5)
            ),
            plot.subtitle     = ggplot2::element_text(
                size = base_size * 0.95, color = text_lo,
                margin = ggplot2::margin(b = 12)
            ),
            plot.caption      = ggplot2::element_text(
                size = base_size * 0.75, color = text_lo,
                hjust = 1, margin = ggplot2::margin(t = 10)
            ),
            # Axes
            axis.title        = ggplot2::element_text(size = base_size * 0.9, color = text_lo),
            axis.title.x      = ggplot2::element_text(margin = ggplot2::margin(t = 8)),
            axis.title.y      = ggplot2::element_text(margin = ggplot2::margin(r = 8)),
            axis.text         = ggplot2::element_text(size = base_size * 0.85, color = text_lo),
            axis.ticks        = ggplot2::element_blank(),
            # Legend
            legend.position   = legend_position,
            legend.background = ggplot2::element_rect(fill = bg, color = NA),
            legend.margin     = ggplot2::margin(6, 10, 6, 10),
            legend.key        = ggplot2::element_rect(fill = bg, color = NA),
            legend.title      = ggplot2::element_text(
                size = base_size * 0.9, face = "bold", color = text_hi
            ),
            legend.text       = ggplot2::element_text(size = base_size * 0.85, color = text_lo),
            # Facet strips
            strip.background  = ggplot2::element_rect(fill = "#1e3a52", color = NA),
            strip.text        = ggplot2::element_text(
                face = "bold", size = base_size * 0.9, color = text_hi,
                margin = ggplot2::margin(4, 8, 4, 8)
            ),
            complete = TRUE
        )
}

# ── Publication theme ──────────────────────────────────────────────────────────

#' Publication-quality ggplot2 theme for OBIS
#'
#' A minimal, journal-ready theme following the visual conventions of top
#' scientific publications (Nature, Science, Cell, One Earth). Key
#' characteristics: clean L-shaped axes with outward tick marks, no background
#' grid, and a compact layout suited to single- and multi-panel figures. Call
#' [obis_load_fonts()] once per session to enable the Roboto font.
#'
#' The default `base_size` of `11` is comfortable for screen use and for
#' figures saved at standard dimensions (≈ 7 × 5 in). When targeting the
#' narrow column widths of print journals (e.g. 3.5 in single-column), either
#' reduce `base_size` to 7–8 or use [obis_ggsave()], which rescales all
#' elements proportionally to the output dimensions.
#'
#' @param base_size Numeric. Base font size in pt. Default `11`. Reduce to
#'   7–8 pt when exporting at narrow journal column widths (≤ 3.5 in), or use
#'   [obis_ggsave()] to handle scaling automatically.
#' @param base_family Character. Base font family. Default `"roboto"`. Swap for
#'   `"helvetica"` or `"arial"` if those are available on your system.
#' @param legend_position Character or `"none"`. Position of the legend.
#'   Default `"right"`.
#' @param grid Character. Reference lines to draw: `"none"` (default, typical
#'   for Nature / Science), `"y"` for subtle major y-axis lines only, or
#'   `"xy"` for both axes.
#'
#' @return A [ggplot2::theme] object.
#' @export
#'
#' @examples
#' library(ggplot2)
#' ggplot(mtcars, aes(wt, mpg)) +
#'     geom_point(size = 1.5) +
#'     labs(title = "Fuel efficiency", x = "Weight (1000 lbs)", y = "MPG") +
#'     theme_obis_pub()
theme_obis_pub <- function(
    base_size = 11,
    base_family = "roboto",
    legend_position = "right",
    grid = c("none", "y", "xy")
) {
    grid <- match.arg(grid)

    grid_line <- ggplot2::element_line(color = "#d0d0d0", linewidth = 0.25)

    t <- ggplot2::theme_classic(base_size = base_size, base_family = base_family) %+replace%
        ggplot2::theme(
            # Panel
            panel.background  = ggplot2::element_rect(fill = "white", color = NA),
            panel.grid.major  = ggplot2::element_blank(),
            panel.grid.minor  = ggplot2::element_blank(),
            # Plot area
            plot.background   = ggplot2::element_rect(fill = "white", color = NA),
            plot.margin       = ggplot2::margin(6, 8, 6, 6),
            plot.title        = ggplot2::element_text(
                face = "bold", size = base_size * 1.1, color = "black",
                margin = ggplot2::margin(b = 3), hjust = 0
            ),
            plot.subtitle     = ggplot2::element_text(
                size = base_size, color = "#444444",
                margin = ggplot2::margin(b = 4), hjust = 0
            ),
            plot.caption      = ggplot2::element_text(
                size = base_size * 0.9, color = "#555555",
                hjust = 0, margin = ggplot2::margin(t = 5)
            ),
            # Axes — black L-frame with outward ticks
            axis.line         = ggplot2::element_line(color = "black", linewidth = 0.4),
            axis.ticks        = ggplot2::element_line(color = "black", linewidth = 0.3),
            axis.ticks.length = ggplot2::unit(3, "pt"),
            axis.title        = ggplot2::element_text(size = base_size, color = "black"),
            axis.title.x      = ggplot2::element_text(
                margin = ggplot2::margin(t = 5), hjust = 0.5
            ),
            axis.title.y      = ggplot2::element_text(
                margin = ggplot2::margin(r = 5), hjust = 0.5, angle = 90
            ),
            axis.text         = ggplot2::element_text(
                size = base_size * 0.9, color = "black"
            ),
            axis.text.x       = ggplot2::element_text(margin = ggplot2::margin(t = 3)),
            axis.text.y       = ggplot2::element_text(margin = ggplot2::margin(r = 3)),
            # Legend — no box, tight spacing
            legend.position   = legend_position,
            legend.background = ggplot2::element_blank(),
            legend.key        = ggplot2::element_blank(),
            legend.key.size   = ggplot2::unit(0.75, "lines"),
            legend.margin     = ggplot2::margin(2, 2, 2, 2),
            legend.title      = ggplot2::element_text(
                size = base_size, face = "bold", color = "black"
            ),
            legend.text       = ggplot2::element_text(
                size = base_size * 0.9, color = "black"
            ),
            legend.spacing.y  = ggplot2::unit(1.5, "pt"),
            # Facet strips — no colored box, label above panel
            strip.background  = ggplot2::element_blank(),
            strip.text        = ggplot2::element_text(
                face = "bold", size = base_size, color = "black",
                margin = ggplot2::margin(b = 3)
            ),
            complete = TRUE
        )

    if (grid == "y") {
        t <- t + ggplot2::theme(panel.grid.major.y = grid_line)
    } else if (grid == "xy") {
        t <- t + ggplot2::theme(
            panel.grid.major.y = grid_line,
            panel.grid.major.x = grid_line
        )
    }

    t
}

# ── Categorical color scales ───────────────────────────────────────────────────

#' Colorblind-safe categorical color scale
#'
#' Applies a discrete, colorblind-safe palette to the `color` aesthetic.
#' Two palettes are available:
#' - `"okabe_ito"` — the Okabe-Ito 8-color palette (default), widely
#'   recommended for colorblind accessibility.
#' - `"tol"` — Paul Tol's 7-color bright scheme, a good alternative.
#'
#' @param palette Character. One of `"okabe_ito"` or `"tol"`.
#'   Default `"okabe_ito"`.
#' @param ... Additional arguments passed to [ggplot2::scale_color_manual()].
#'
#' @return A ggplot2 scale object.
#' @export
#'
#' @examples
#' library(ggplot2)
#' ggplot(iris, aes(Sepal.Length, Petal.Length, color = Species)) +
#'     geom_point() +
#'     scale_color_obis_cat()
scale_color_obis_cat <- function(palette = "okabe_ito", ...) {
    colors <- .palettes_cat[[palette]]
    if (is.null(colors)) {
        stop("Unknown palette '", palette, "'. Choose 'okabe_ito' or 'tol'.")
    }
    ggplot2::scale_color_manual(values = colors, ...)
}

#' @rdname scale_color_obis_cat
#' @export
#'
#' @examples
#' library(ggplot2)
#' ggplot(iris, aes(Sepal.Length, Petal.Length, fill = Species)) +
#'     geom_point(shape = 21, size = 3) +
#'     scale_fill_obis_cat()
scale_fill_obis_cat <- function(palette = "okabe_ito", ...) {
    colors <- .palettes_cat[[palette]]
    if (is.null(colors)) {
        stop("Unknown palette '", palette, "'. Choose 'okabe_ito' or 'tol'.")
    }
    ggplot2::scale_fill_manual(values = colors, ...)
}

# ── Continuous color scales ────────────────────────────────────────────────────

#' Colorblind-safe continuous color scale
#'
#' Maps a continuous variable to a perceptually uniform, colorblind-safe
#' color gradient. Five palettes are available:
#'
#' | Palette | Origin | Recommended for |
#' |---------|--------|-----------------|
#' | `"mako"` | viridis | abundance, density |
#' | `"cividis"` | viridis | general-purpose (optimized for CVD) |
#' | `"thermal"` | cmocean | sea surface temperature |
#' | `"haline"` | cmocean | salinity |
#' | `"deep"` | cmocean | depth / bathymetry |
#'
#' @param palette Character. One of `"mako"`, `"cividis"`, `"thermal"`,
#'   `"haline"`, or `"deep"`. Default `"mako"`.
#' @param direction Numeric. `1` for the palette as-is, `-1` to reverse.
#'   Default `1`.
#' @param ... Additional arguments passed to the underlying scale function.
#'
#' @return A ggplot2 scale object.
#' @export
#'
#' @examples
#' library(ggplot2)
#' ggplot(faithfuld, aes(waiting, eruptions, color = density)) +
#'     geom_point() +
#'     scale_color_obis_cont("thermal")
scale_color_obis_cont <- function(palette = "mako", direction = 1, ...) {
    .obis_cont_scale("color", palette, direction, ...)
}

#' @rdname scale_color_obis_cont
#' @export
#'
#' @examples
#' library(ggplot2)
#' ggplot(faithfuld, aes(waiting, eruptions, fill = density)) +
#'     geom_tile() +
#'     scale_fill_obis_cont("haline")
scale_fill_obis_cont <- function(palette = "mako", direction = 1, ...) {
    .obis_cont_scale("fill", palette, direction, ...)
}

#' @keywords internal
.obis_cont_scale <- function(aesthetic, palette, direction, ...) {
    viridis_opts <- c("mako", "cividis", "viridis", "plasma", "inferno", "magma", "rocket", "turbo")

    if (palette %in% viridis_opts) {
        fn <- if (aesthetic == "fill") {
            ggplot2::scale_fill_viridis_c
        } else {
            ggplot2::scale_color_viridis_c
        }
        fn(option = palette, direction = direction, ...)
    } else {
        colors <- .palettes_cont[[palette]]
        if (is.null(colors)) {
            stop(
                "Unknown palette '", palette, "'. Choose from: ",
                paste(c(viridis_opts, names(.palettes_cont)), collapse = ", "), "."
            )
        }
        if (direction == -1) colors <- rev(colors)
        fn <- if (aesthetic == "fill") {
            ggplot2::scale_fill_gradientn
        } else {
            ggplot2::scale_color_gradientn
        }
        fn(colors = colors, ...)
    }
}

# ── Colourbar guide ────────────────────────────────────────────────────────────

#' Horizontal colourbar guide
#'
#' Returns a [ggplot2::guide_colorbar()] pre-configured as a thin horizontal
#' bar, styled similarly to matplotlib's default colorbar. Intended for use
#' with continuous fill or color scales via the `guide` argument or
#' [ggplot2::guides()].
#'
#' @param title Character or [ggplot2::waiver()]. Guide title. Default
#'   `ggplot2::waiver()` (inherits from scale name).
#' @param barwidth A [grid::unit()] object controlling the bar width.
#'   Default `grid::unit(12, "lines")`.
#' @param barheight A [grid::unit()] object controlling the bar height.
#'   Default `grid::unit(0.4, "lines")`.
#' @param title_position Character. Where to place the title relative to the
#'   bar. One of `"top"`, `"bottom"`, `"left"`, `"right"`. Default `"top"`.
#' @param title_hjust Numeric in `[0, 1]`. Horizontal justification of the
#'   title. Default `0.5` (centered).
#' @param label_position Character. Where to place tick labels. One of
#'   `"top"`, `"bottom"`. Default `"bottom"`.
#' @param ... Additional arguments passed to [ggplot2::guide_colorbar()].
#'
#' @return A ggplot2 guide object.
#' @export
#'
#' @examples
#' library(ggplot2)
#' ggplot(faithfuld, aes(waiting, eruptions, fill = density)) +
#'     geom_tile() +
#'     scale_fill_obis_cont("thermal") +
#'     guides(fill = guide_colourbar_h(title = "Density")) +
#'     theme_obis(legend_position = "bottom")
guide_colourbar_h <- function(
    title = ggplot2::waiver(),
    barwidth = grid::unit(12, "lines"),
    barheight = grid::unit(0.4, "lines"),
    title_position = "top",
    title_hjust = 0.5,
    label_position = "bottom",
    ...
) {
    ggplot2::guide_colorbar(
        title          = title,
        direction      = "horizontal",
        barwidth       = barwidth,
        barheight      = barheight,
        title.position = title_position,
        title.hjust    = title_hjust,
        label.position = label_position,
        frame.colour   = NA,
        ticks.colour   = NA,
        ...
    )
}

# ── Logo overlay ───────────────────────────────────────────────────────────────

#' Add OBIS and IOC logos to a ggplot
#'
#' Overlays the OBIS and IOC logos at a chosen corner of a finished ggplot using
#' [cowplot::ggdraw()]. The logos are placed side by side matching the style
#' used on the OBIS website (IOC left, OBIS right).
#'
#' Because logo width in normalised figure coordinates depends on the physical
#' aspect ratio of the output, pass `fig_asp = width / height` to match the
#' dimensions you plan to use in [ggplot2::ggsave()]. The default (`7 / 5`)
#' works well for the standard 7 × 5 inch ggplot figure.
#'
#' @param plot A ggplot2 object.
#' @param position Character. Corner for the logos. One of `"bottomright"`,
#'   `"bottomleft"`, `"topright"`, or `"topleft"`. Default `"bottomright"`.
#' @param logo_size Numeric in `(0, 1)`. Height of the IOC logo as a fraction
#'   of the figure height. Default `0.07`.
#' @param padding Numeric in `(0, 1)`. Margin from the figure edge, as a
#'   fraction of the figure height. Default `0.015`.
#' @param fig_asp Numeric. Figure width / height ratio used to correct the logo
#'   aspect ratios in normalised coordinates. Default `7 / 5`.
#'
#' @return A `ggdraw` object that prints and saves like a ggplot.
#' @export
#'
#' @examples
#' library(ggplot2)
#' p <- ggplot(mtcars, aes(wt, mpg)) +
#'     geom_point(color = "#0072B2", size = 2) +
#'     labs(title = "Fuel efficiency", x = "Weight (1000 lbs)", y = "MPG") +
#'     theme_obis()
#' obis_add_logo(p)
obis_add_logo <- function(
    plot,
    position  = c("bottomright", "bottomleft", "topright", "topleft"),
    logo_size = 0.07,
    padding   = 0.015,
    fig_asp   = 7 / 5
) {
    position <- match.arg(position)

    ioc_arr  <- png::readPNG(rsvg::rsvg_png(logos$ioc,  file = NULL, height = 200L))
    obis_arr <- png::readPNG(logos$obis)

    # Pixel aspect ratios (width / height)
    ioc_px_asp  <- ncol(ioc_arr)  / nrow(ioc_arr)
    obis_px_asp <- ncol(obis_arr) / nrow(obis_arr)

    # Heights in npc (fraction of figure height).
    # Website proportions: IOC at 40 px, OBIS at 30 px.
    ioc_h  <- logo_size
    obis_h <- logo_size * 0.75

    # Widths in npc: convert pixel aspect to figure-coordinate aspect by
    # dividing by fig_asp (so a wide figure doesn't squish the logos).
    ioc_w  <- ioc_h  * ioc_px_asp  / fig_asp
    obis_w <- obis_h * obis_px_asp / fig_asp

    gap     <- padding * 0.5
    total_w <- ioc_w + gap + obis_w

    # Corner positions
    right  <- position %in% c("bottomright", "topright")
    bottom <- position %in% c("bottomright", "bottomleft")

    # Strip of canvas reserved for the logos (fraction of figure height)
    reserve <- logo_size + 2 * padding

    x_ioc  <- if (right)  1 - padding / fig_asp - total_w else padding / fig_asp
    y_base <- if (bottom) padding                          else 1 - padding - ioc_h
    x_obis <- x_ioc + ioc_w + gap
    y_ioc  <- y_base
    y_obis <- y_base + (ioc_h - obis_h) / 2   # vertically centred with IOC logo

    ioc_grob  <- grid::rasterGrob(ioc_arr,  interpolate = TRUE)
    obis_grob <- grid::rasterGrob(obis_arr, interpolate = TRUE)

    # Detect background fill so the reserved strip matches the plot
    bg <- tryCatch({
        th   <- plot$theme
        if (!isTRUE(attr(th, "complete"))) th <- ggplot2::theme_get() + th
        fill <- th$plot.background$fill
        if (is.null(fill) || is.na(fill) || inherits(fill, "waiver")) "white" else fill
    }, error = function(e) "white")

    # Shrink the plot to leave an unobstructed strip for the logos.
    # suppressWarnings: cowplot's layout phase triggers C_textBounds for grid
    # text metrics using the PostScript font fallback, even though showtext
    # handles rendering correctly. The warnings are benign.
    suppressWarnings(
        cowplot::ggdraw() +
            ggplot2::theme(plot.background = ggplot2::element_rect(fill = bg, color = NA)) +
            cowplot::draw_plot(
                plot,
                x = 0, y = if (bottom) reserve else 0,
                width = 1, height = 1 - reserve
            ) +
            cowplot::draw_grob(ioc_grob,  x = x_ioc,  y = y_ioc,  width = ioc_w,  height = ioc_h) +
            cowplot::draw_grob(obis_grob, x = x_obis, y = y_obis, width = obis_w, height = obis_h)
    )
}

# ── Scaling-aware save ─────────────────────────────────────────────────────────

#' Save a ggplot with proportionally scaled text
#'
#' A wrapper around [ggplot2::ggsave()] that keeps all theme elements (text,
#' lines, points, legend keys) at the same *apparent* size regardless of the
#' output dimensions. It works by rendering the plot at a reference size and
#' then letting `ggsave` scale the raster to the target dimensions, so a figure
#' intended for a 3.5 × 2.5 in journal column looks identical whether saved at
#' that size or at 7 × 5 in for a slide.
#'
#' The scaling factor is computed as
#' \eqn{\sqrt{(w \times h) / (w_\text{ref} \times h_\text{ref})}}{sqrt((w*h)/(ref_w*ref_h))},
#' the geometric mean of the area ratio, so both dimensions are treated equally.
#'
#' @param filename File path for the output (extension determines format).
#' @param plot A ggplot2 (or cowplot) object. Defaults to the last plot
#'   displayed ([ggplot2::last_plot()]).
#' @param width,height Numeric. Target output dimensions in `units`.
#' @param ref_width,ref_height Numeric. Reference dimensions at which the plot
#'   was designed. Defaults match [ggplot2::ggsave()] defaults (`7` × `5` in).
#'   Adjust if you authored the plot at a different preview size.
#' @param units Character. Units for `width`, `height`, `ref_width`, and
#'   `ref_height`. One of `"in"` (default), `"cm"`, `"mm"`, or `"px"`.
#' @param dpi Numeric. Output resolution. Default `300` (publication quality).
#' @param bg Character. Background colour. Default `"white"`.
#' @param ... Additional arguments passed to [ggplot2::ggsave()].
#'
#' @return The `filename` path, invisibly (same as [ggplot2::ggsave()]).
#' @export
#'
#' @examples
#' \dontrun{
#' library(ggplot2)
#' p <- ggplot(mtcars, aes(wt, mpg)) +
#'     geom_point(size = 1.5) +
#'     labs(x = "Weight (1000 lbs)", y = "MPG") +
#'     theme_obis_pub()
#'
#' # Single-column journal figure (3.5 × 2.5 in) — text scales down
#' obis_ggsave("fig1_single.pdf", p, width = 3.5, height = 2.5)
#'
#' # Double-column figure (7 × 5 in) — same apparent text size
#' obis_ggsave("fig1_double.pdf", p, width = 7, height = 5)
#'
#' # Poster panel (14 × 10 in) — text scales up
#' obis_ggsave("fig1_poster.pdf", p, width = 14, height = 10)
#' }
obis_ggsave <- function(
    filename,
    plot      = ggplot2::last_plot(),
    width     = 7,
    height    = 5,
    ref_width  = 7,
    ref_height = 5,
    units     = "in",
    dpi       = 300,
    bg        = "white",
    ...
) {
    # Geometric-mean scale factor: > 1 for larger outputs, < 1 for smaller
    scale <- sqrt((width * height) / (ref_width * ref_height))

    # Render at ref dimensions, then let ggsave scale the canvas to target size.
    # Output file ends up at exactly width × height because:
    #   (width / scale) * scale == width  (and same for height)
    ggplot2::ggsave(
        filename = filename,
        plot     = plot,
        width    = width  / scale,
        height   = height / scale,
        scale    = scale,
        units    = units,
        dpi      = dpi,
        bg       = bg,
        ...
    )
}
