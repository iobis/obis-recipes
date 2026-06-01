#' Create a blank white world basemap
#'
#' Draws a minimal ggplot2 world map with a solid white land fill. Useful as a
#' base layer before adding occurrence data.
#'
#' @param map_scale Character. Natural Earth dataset scale passed to
#'   [rnaturalearth::ne_countries()]. One of `"small"`, `"medium"`, or
#'   `"large"`. Default `"small"`.
#' @param map_crs Numeric or character CRS accepted by [sf::st_crs()], or `NA`
#'   to use the default (WGS 84 / EPSG:4326). Default `NA`.
#' @param background_color Character. Fill color for land polygons.
#'   Default `"white"`.
#' @param land_line_color Character. Outline color for land polygons.
#'   Default `"black"`.
#' @param keep_graticule Logical. If `TRUE` applies `theme_minimal()` to
#'   retain axis labels and graticule lines; otherwise `theme_void()`.
#'   Default `FALSE`.
#' @param ... Additional arguments passed to [ggplot2::coord_sf()].
#'
#' @return A [ggplot2::ggplot] object.
#' @export
#'
#' @examples
#' blank_map_s()
#' blank_map_s(keep_graticule = TRUE)
#' blank_map_s(map_crs = "+proj=moll")
blank_map_s <- function(
    map_scale = "small",
    map_crs = NA,
    background_color = "white",
    land_line_color = "black",
    keep_graticule = FALSE,
    ...
) {
    suppressMessages(sf::sf_use_s2(FALSE))
    if (is.na(map_crs)) map_crs <- NULL

    wrld <- suppressMessages(
        rnaturalearth::ne_countries(returnclass = "sf", scale = map_scale) |>
            sf::st_union()
    )

    p <- ggplot2::ggplot() +
        ggplot2::geom_sf(data = wrld, color = land_line_color, fill = background_color) +
        ggplot2::coord_sf(
            crs = map_crs,
            expand = FALSE,
            ...
        )

    if (keep_graticule) {
        p <- p + ggplot2::theme_minimal()
    } else {
        p <- p + ggplot2::theme_void()
    }

    return(p)
}

#' Create a grey world basemap with optional bathymetry
#'
#' Draws a ggplot2 world map styled after the OBIS taxon page: grey ocean
#' background, white land, and an optional semi-transparent bathymetry overlay.
#'
#' @param map_scale Character. Natural Earth dataset scale. One of `"small"`,
#'   `"medium"`, or `"large"`. Default `"small"`.
#' @param map_crs Numeric or character CRS, or `NA` for WGS 84. Default `NA`.
#' @param background_color Character. Fill color for the ocean/panel background.
#'   Default `"#dbdbdc"`.
#' @param land_background Character. Fill color for land polygons.
#'   Default `"white"`.
#' @param land_line_color Character or `NA`. Outline color for land polygons.
#'   Default `NA` (no outline).
#' @param add_bathymetry Logical. If `TRUE`, overlays the bundled `bath_contour`
#'   dataset as a semi-transparent layer. Default `TRUE`.
#' @param bathymetry_color Character. Color for bathymetry contour lines.
#'   Default `"#044062"`.
#' @param bathymetry_opacity Numeric in `[0, 1]`. Opacity of the bathymetry
#'   layer. Default `0.06`.
#' @param plot_xlim Numeric vector of length 2, or `NULL`. Longitude limits
#'   passed to [ggplot2::coord_sf()]. Default `NULL`.
#' @param plot_ylim Numeric vector of length 2, or `NULL`. Latitude limits
#'   passed to [ggplot2::coord_sf()]. Default `NULL`.
#' @param keep_graticule Logical. Retain axis labels and graticule lines.
#'   Default `FALSE`.
#' @param ... Additional arguments passed to [ggplot2::coord_sf()].
#'
#' @return A [ggplot2::ggplot] object.
#' @export
#'
#' @examples
#' grey_map_s()
#' grey_map_s(add_bathymetry = FALSE)
#' grey_map_s(plot_xlim = c(-30, 40), plot_ylim = c(35, 70))
grey_map_s <- function(
    map_scale = "small",
    map_crs = NA,
    background_color = "#dbdbdc",
    land_background = "white",
    land_line_color = NA,
    add_bathymetry = TRUE,
    bathymetry_color = "#044062",
    bathymetry_opacity = 0.06,
    plot_xlim = NULL,
    plot_ylim = NULL,
    keep_graticule = FALSE,
    ...
) {
    suppressMessages(sf::sf_use_s2(FALSE))
    if (is.na(map_crs)) map_crs <- NULL
    data(bath_contour)

    wrld <- suppressMessages(
        rnaturalearth::ne_countries(returnclass = "sf", scale = map_scale) |>
            sf::st_union()
    )

    p <- ggplot2::ggplot() +
        ggplot2::geom_sf(data = wrld, color = land_line_color, fill = land_background)

    if (keep_graticule) {
        p <- p + ggplot2::theme_minimal() +
            ggplot2::theme(
                panel.background = element_rect(fill = background_color)
            )
    } else {
        p <- p + ggplot2::theme_void() +
            ggplot2::theme(
                panel.background = element_rect(fill = background_color)
            )
    }

    if (add_bathymetry) {
        p <- p +
            ggplot2::geom_sf(data = bath_contour, color = bathymetry_color, alpha = bathymetry_opacity)
    }

    p <- p  +
        ggplot2::coord_sf(
            xlim = plot_xlim,
            ylim = plot_ylim,
            crs = map_crs,
            expand = FALSE,
            ...
        )

    return(p)
}

#' Convert occurrence records to a geohash grid
#'
#' Groups a data frame of occurrence records into geohash cells and returns an
#' sf polygon layer with the record count per cell.
#'
#' @param occ Data frame with columns `decimalLongitude` and `decimalLatitude`.
#' @param grid_res Integer. Geohash precision level (1–9). Higher values produce
#'   smaller cells. Default `3`.
#'
#' @return An [sf::sf] object with one row per occupied cell and a `records`
#'   column containing the occurrence count.
#' @export
#'
#' @examples
#' occ <- data.frame(
#'     decimalLongitude = c(-122.4, -118.2, -87.6, 2.3, 151.2),
#'     decimalLatitude  = c(37.8, 34.1, 41.9, 48.9, -33.9)
#' )
#' occ_to_geohashgrid(occ, grid_res = 3)
occ_to_geohashgrid <- function(occ, grid_res = 3) {
    occ$grid <- geohashTools::gh_encode(
        occ$decimalLatitude,
        occ$decimalLongitude,
        as.integer(grid_res)
    )

    occ_grouped <- occ |>
        dplyr::group_by(grid) |>
        dplyr::summarise(records = dplyr::n())

    grid_vec <- geohashTools::gh_to_sf(occ_grouped$grid)
    grid_vec$records <- occ_grouped$records

    return(grid_vec)
}

#' Convert occurrence records to an H3 hexagonal grid
#'
#' Groups a data frame of occurrence records into Uber H3 hexagonal cells and
#' returns an sf polygon layer with the record count per cell.
#'
#' @param occ Data frame with columns `decimalLongitude` and `decimalLatitude`.
#' @param grid_res Integer. H3 resolution (0–15). Higher values produce smaller
#'   hexagons. Default `3`.
#'
#' @return An [sf::sf] object with one row per occupied cell and a `records`
#'   column containing the occurrence count.
#' @export
#'
#' @examples
#' occ <- data.frame(
#'     decimalLongitude = c(-122.4, -118.2, -87.6, 2.3, 151.2),
#'     decimalLatitude  = c(37.8, 34.1, 41.9, 48.9, -33.9)
#' )
#' occ_to_h3grid(occ, grid_res = 3)
occ_to_h3grid <- function(occ, grid_res = 3) {
    occ_sf <- sf::st_as_sf(
        occ,
        coords = c("decimalLongitude", "decimalLatitude"),
        crs = 4326
    )

    occ$grid <- h3jsr::point_to_cell(occ_sf, res = as.integer(grid_res))

    occ_grouped <- occ |>
        dplyr::group_by(grid) |>
        dplyr::summarise(records = dplyr::n())

    grid_vec <- sf::st_sf(
        records = occ_grouped$records,
        geometry = h3jsr::cell_to_polygon(occ_grouped$grid)
    )

    return(grid_vec)
}

#' Convert occurrence records to an A5 pentagonal grid
#'
#' Groups a data frame of occurrence records into A5 equal-area pentagonal cells
#' and returns an sf polygon layer with the record count per cell.
#'
#' @param occ Data frame with columns `decimalLongitude` and `decimalLatitude`.
#' @param grid_res Integer. A5 resolution level (0–30). Higher values produce
#'   smaller cells. Default `3`.
#'
#' @return An [sf::sf] object with one row per occupied cell and a `records`
#'   column containing the occurrence count.
#' @export
#'
#' @examples
#' occ <- data.frame(
#'     decimalLongitude = c(-122.4, -118.2, -87.6, 2.3, 151.2),
#'     decimalLatitude  = c(37.8, 34.1, 41.9, 48.9, -33.9)
#' )
#' occ_to_a5grid(occ, grid_res = 3)
occ_to_a5grid <- function(occ, grid_res = 3) {
    occ$grid <- a5R::a5_lonlat_to_cell(
        occ$decimalLongitude,
        occ$decimalLatitude,
        resolution = as.integer(grid_res)
    )

    occ_grouped <- occ |>
        dplyr::group_by(grid) |>
        dplyr::summarise(records = dplyr::n())

    grid_vec <- sf::st_sf(
        records = occ_grouped$records,
        geometry = sf::st_as_sfc(a5R::a5_cell_to_boundary(occ_grouped$grid))
    )

    return(grid_vec)
}

#' Fetch OBIS occurrences and convert to a spatial grid
#'
#' Retrieves occurrence records from OBIS via [robis::occurrence()] and
#' aggregates them into a spatial grid using one of three grid systems:
#' geohash, H3, or A5.
#'
#' @param taxonid Integer. OBIS taxon ID. Default `141438` (whale shark).
#' @param startdate Character or `NULL`. Earliest date to include, in
#'   `"YYYY-MM-DD"` format. Default `NULL`.
#' @param enddate Character or `NULL`. Latest date to include, in
#'   `"YYYY-MM-DD"` format. Default `NULL`.
#' @param type_grid Character. Grid system to use: `"geohash"`, `"h3"`, or
#'   `"a5"`. Default `"geohash"`.
#' @param grid_res Integer. Grid resolution passed to the corresponding
#'   converter ([occ_to_geohashgrid()], [occ_to_h3grid()], or
#'   [occ_to_a5grid()]). Default `3`.
#'
#' @return An [sf::sf] object with one row per occupied cell and a `records`
#'   column containing the occurrence count.
#' @export
#'
#' @examples
#' \dontrun{
#' # Geohash grid at resolution 3
#' get_occ_gridded(taxonid = 141438, type_grid = "geohash", grid_res = 3)
#'
#' # H3 hexagonal grid with date filter
#' get_occ_gridded(
#'     taxonid   = 141438,
#'     startdate = "2010-01-01",
#'     type_grid = "h3",
#'     grid_res  = 3
#' )
#'
#' # A5 pentagonal grid
#' get_occ_gridded(taxonid = 141438, type_grid = "a5", grid_res = 3)
#' }
get_occ_gridded <- function(
    taxonid = 141438,
    startdate = NULL,
    enddate = NULL,
    type_grid = "geohash",
    grid_res = 3
) {
    occ <- robis::occurrence(
        taxonid = taxonid,
        startdate = startdate,
        enddate = enddate
    )

    if (type_grid == "geohash") {
        occ_to_geohashgrid(occ, grid_res)
    } else if (type_grid == "h3") {
        occ_to_h3grid(occ, grid_res)
    } else if (type_grid == "a5") {
        occ_to_a5grid(occ, grid_res)
    }
}

#' Fetch pre-gridded occurrence tiles from the OBIS API
#'
#' Queries the OBIS occurrence grid endpoint, which returns geohash cells
#' pre-aggregated server-side. This is faster than downloading raw records
#' for large taxa.
#'
#' @param taxonid Integer. OBIS taxon ID. Default `141438` (whale shark).
#' @param startdate Character or `NULL`. Earliest date to include, in
#'   `"YYYY-MM-DD"` format. Default `NULL`.
#' @param enddate Character or `NULL`. Latest date to include, in
#'   `"YYYY-MM-DD"` format. Default `NULL`.
#' @param grid_res Integer. Geohash precision level (1–9). Default `3`.
#'
#' @return An [sf::sf] object (GeoJSON FeatureCollection) with one row per
#'   occupied geohash cell and a `records` column. A warning is issued if the
#'   result contains exactly 100,000 features, indicating the API limit may
#'   have been reached and results could be truncated.
#' @export
#'
#' @examples
#' \dontrun{
#' # All records for whale shark at geohash resolution 3
#' get_occ_tiles(taxonid = 141438, grid_res = 3)
#'
#' # With date filter
#' get_occ_tiles(
#'     taxonid   = 141438,
#'     startdate = "2020-01-01",
#'     enddate   = "2024-12-31",
#'     grid_res  = 3
#' )
#' }
get_occ_tiles <- function(
    taxonid = 141438,
    startdate = NULL,
    enddate = NULL,
    grid_res = 3
) {
    url <- paste0(
        "https://api.obis.org/v3/occurrence/grid/",
        as.integer(grid_res),
        "?taxonid=", taxonid
    )

    if (!is.null(startdate)) url <- paste0(url, "&startdate=", startdate)
    if (!is.null(enddate))   url <- paste0(url, "&enddate=", enddate)

    grid_vec <- sf::read_sf(url)

    if (nrow(grid_vec) == 100000L) {
        warning("Result contains exactly 100,000 features, which is the OBIS API limit. Results may be truncated.")
    }

    dplyr::rename(grid_vec, records = "n")
}

#' OBIS-style binned color scale for ggplot2
#'
#' Returns a list of two ggplot2 components — a [ggplot2::scale_fill_manual()]
#' with labelled break bins and a [ggplot2::theme()] that styles the legend —
#' matching the visual style used on the OBIS taxon pages.
#'
#' @param breaks Numeric vector of bin boundaries. The last value is used as
#'   the label for the open-ended top bin. Default `c(1, 10, 100, 1000, 10000)`.
#' @param colors Character vector of hex colors, one per bin. Must be the same
#'   length as `breaks`. Default is a blue-to-red diverging palette.
#' @param legend_title Character. Title shown above the legend. Default
#'   `"Records"`.
#' @param na_color Character. Fill color for `NA` values. Default `"grey80"`.
#' @param key_spacing Numeric. Vertical spacing between legend keys in points.
#'   Default `4`.
#'
#' @return A list of two ggplot2 objects that can be added to a plot with `+`.
#' @export
#'
#' @examples
#' \dontrun{
#' grey_map_s() |>
#'     add_species_data_s(grid_data = get_occ_tiles(141438)) +
#'     obis_scale(breaks = c(1, 10, 100, 1000, 10000))
#' }
obis_scale <- function(
    breaks = c(1, 10, 100, 1000, 10000),
    colors = c("#2c7bb6", "#abd9e9", "#ffffbf", "#fdae61", "#d7191c"),
    legend_title = "Records",
    na_color = "grey80",
    key_spacing = 4
) {
  labels <- c(
    scales::comma(breaks[-length(breaks)]),
    paste0(">", scales::comma(breaks[length(breaks) - 1]))
  )

  named_colors <- stats::setNames(colors, labels)

  list(
    ggplot2::scale_fill_manual(
      name     = legend_title,
      values   = named_colors,
      drop     = FALSE,          # keep unused levels in legend
      na.value = na_color,
      guide    = ggplot2::guide_legend(
        title.position = "top",
        title.hjust    = 0,
        reverse        = FALSE,   # 1 at bottom, >10,000 at top — matches OBIS
        override.aes   = list(size = 5, colour = "#ffffff00")
      )
    ),
    ggplot2::theme(
      legend.background = ggplot2::element_rect(fill = "white", color = NA),
      legend.margin     = ggplot2::margin(10, 14, 10, 14),
      legend.title      = ggplot2::element_text(face = "bold", size = 11),
      legend.text       = ggplot2::element_text(size = 10),
      legend.key.size   = ggplot2::unit(1.2, "lines"),
      legend.key.spacing.y  = ggplot2::unit(key_spacing, "pt")
    )
  )
}

#' Bin a numeric grid column into labelled factor levels for plotting
#'
#' Cuts a numeric column in an sf grid object into ordered factor bins using
#' the same break scheme as [obis_scale()]. The result is a new column named
#' `<column>_binned` ready for use with [ggplot2::aes()].
#'
#' @param grid_data An [sf::sf] object containing the column to bin.
#' @param column Character. Name of the numeric column to bin. Default
#'   `"records"`.
#' @param breaks Numeric vector of bin boundaries (same as [obis_scale()]).
#'   Default `c(1, 10, 100, 1000, 10000)`.
#'
#' @return The input `grid_data` with an additional `<column>_binned` factor
#'   column.
#' @export
#'
#' @examples
#' occ <- data.frame(
#'     decimalLongitude = c(-122.4, -118.2, -87.6, 2.3, 151.2),
#'     decimalLatitude  = c(37.8, 34.1, 41.9, 48.9, -33.9)
#' )
#' grid <- occ_to_geohashgrid(occ)
#' prepare_grid_data(grid)
prepare_grid_data <- function(
    grid_data,
    column = "records",
    breaks = c(1, 10, 100, 1000, 10000)
) {
  labels <- c(
    scales::comma(breaks[-length(breaks)]),
    paste0(">", scales::comma(breaks[length(breaks) - 1]))
  )

  # Build break boundaries: 0, 1, 10, 100, 1000, Inf
  bin_breaks <- c(0, breaks[-length(breaks)], Inf)

  grid_data[[paste0(column, "_binned")]] <- factor(
    cut(
      grid_data[[column]],
      breaks    = bin_breaks,
      labels    = labels,
      include.lowest = TRUE,
      right     = FALSE          # [1,10), [10,100), …
    ),
    levels = labels              # keep all levels even if unused
  )

  grid_data
}

#' Add a gridded species occurrence layer to a basemap
#'
#' Overlays a spatial grid of occurrence counts (from [get_occ_gridded()],
#' [get_occ_tiles()], or any of the `occ_to_*grid()` converters) onto an
#' existing ggplot2 basemap.
#'
#' @param map A [ggplot2::ggplot] basemap, typically from [blank_map_s()] or
#'   [grey_map_s()].
#' @param grid_data An [sf::sf] object with a `records` column, as returned by
#'   the grid functions in this package.
#' @param limit_by_bbox Logical. If `TRUE`, zooms the map to the bounding box
#'   of `grid_data`. Default `TRUE`.
#' @param plot_xlim Numeric vector of length 2, or `NULL`. Manual longitude
#'   limits used when `limit_by_bbox = FALSE`. Default `NULL`.
#' @param plot_ylim Numeric vector of length 2, or `NULL`. Manual latitude
#'   limits used when `limit_by_bbox = FALSE`. Default `NULL`.
#' @param map_crs Numeric or character CRS, or `NA` for WGS 84. Default `NA`.
#' @param auto_breaks Logical. If `TRUE`, uses [ggplot2::scale_fill_binned()]
#'   with automatic breaks instead of `obis_scale()`. Default `FALSE`.
#' @param breaks Numeric vector of bin boundaries passed to `obis_scale()` and
#'   [prepare_grid_data()]. Default `c(1, 10, 100, 1000, 10000)`.
#' @param colors Character vector of fill colors, one per bin. Default is the
#'   OBIS blue-to-red palette.
#' @param legend Logical. Show the fill legend. Default `TRUE`.
#' @param ... Additional arguments passed to [ggplot2::coord_sf()].
#'
#' @return A [ggplot2::ggplot] object.
#' @export
#'
#' @examples
#' \dontrun{
#' # Geohash grid on a blank map, zoomed to data extent
#' grid <- get_occ_tiles(taxonid = 141438)
#' blank_map_s() |> add_species_data_s(grid_data = grid)
#'
#' # Global view on a grey map with automatic breaks
#' grey_map_s() |>
#'     add_species_data_s(
#'         grid_data   = grid,
#'         limit_by_bbox = FALSE,
#'         auto_breaks = TRUE
#'     )
#'
#' # Custom breaks and colors, no legend
#' blank_map_s() |>
#'     add_species_data_s(
#'         grid_data = grid,
#'         breaks    = c(1, 5, 50, 500),
#'         colors    = c("#f7fbff", "#6baed6", "#2171b5", "#084594"),
#'         legend    = FALSE
#'     )
#' }
add_species_data_s <- function(
    map,
    grid_data,
    limit_by_bbox = TRUE,
    plot_xlim = NULL,
    plot_ylim = NULL,
    map_crs = NA,
    auto_breaks = FALSE,
    breaks = c(1, 10, 100, 1000, 10000),
    colors = c("#2c7bb6", "#abd9e9", "#ffffbf", "#fdae61", "#d7191c"),
    legend = TRUE,
    ...
) {

    if (is.na(map_crs)) map_crs <- NULL

    if (auto_breaks) {
        p <- map +
            ggplot2::geom_sf(
                data = grid_data, ggplot2::aes(fill = records),
                show.legend = TRUE,
                color = NA
            ) +
            ggplot2::scale_fill_binned()
    } else {
        p <- map +
            ggplot2::geom_sf(
                data = prepare_grid_data(grid_data, breaks = breaks),
                    ggplot2::aes(fill = records_binned),
                show.legend = TRUE,
                color = NA
            ) +
            obis_scale(breaks = breaks, colors = colors)
    }

    if (limit_by_bbox) {
        p <- p +
            ggplot2::coord_sf(
                xlim = sf::st_bbox(grid_data)[c(1,3)],
                ylim = sf::st_bbox(grid_data)[c(2,4)],
                expand = TRUE
            )
    } else {
        p <- p +
            ggplot2::coord_sf(
                xlim = plot_xlim,
                ylim = plot_ylim,
                crs = map_crs,
                expand = ifelse(
                    !is.null(plot_xlim) | !is.null(plot_ylim),
                    TRUE, FALSE
                )
            )
    }

    if (!legend) {
        p <- p +
                ggplot2::theme(
                    legend.position = "none"
                )
    }

    return(p)
}
