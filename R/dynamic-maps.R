# =============================================================================
# Basemap constructors
# =============================================================================

#' Create a blank OBIS-style basemap
#'
#' Renders a MapLibre GL or Mapbox GL map with a solid-colour background and
#' OBIS land tiles, matching the style of the OBIS website homepage.
#'
#' @param type Character. Map renderer: \code{"maplibre"} (default) or
#'   \code{"mapboxgl"}.
#' @param projection Character. Map projection passed to the renderer. One of
#'   \code{"globe"} (default), \code{"mercator"}, \code{"none"}, etc.
#' @param background_color Character. CSS colour for the ocean/background.
#'   Default: \code{"white"}.
#' @param land_line_color Character. CSS colour for the land polygon outline.
#'   Default: \code{"black"}.
#' @param ... Additional arguments forwarded to \code{maplibre()} or
#'   \code{mapboxgl()}.
#'
#' @return A \code{maplibre} or \code{mapboxgl} map object.
#'
#' @examples
#' \dontrun{
#' blank_map()
#' blank_map(projection = "mercator", background_color = "#eaeaea")
#' }
#'
#' @export
blank_map <- function(
    type = "maplibre",
    projection = "globe",
    background_color = "white",
    land_line_color = "black",
    ...
) {
    if (type == "maplibre") {
        m <- mapgl::maplibre(
            style = mapgl::basemap_style(color = background_color),
            projection = projection,
            attributionControl = FALSE,
            ...
        )
    } else {
        m <- mapgl::mapboxgl(
            style = mapgl::basemap_style(color = background_color),
            projection = projection,
            ...
        )
    }

    m <- m |>
        mapgl::add_vector_source(
            id = "lands",
            tiles = "https://tiles.obis.org/land_tiles/{z}/{x}/{y}.pbf"
        ) |>
        mapgl::add_fill_layer(
            id = "lands",
            source = "lands",
            source_layer = "land",
            fill_color = "white",
            fill_outline_color = land_line_color
        )

    return(m)
}


#' Create a grey OBIS-style basemap
#'
#' Renders a MapLibre GL or Mapbox GL map with a grey background, white land
#' fill, and optional GEBCO bathymetry contour lines — matching the style of
#' OBIS taxon pages (e.g. \url{https://obis.org/taxon/126436}).
#'
#' @param type Character. Map renderer: \code{"maplibre"} (default) or
#'   \code{"mapboxgl"}.
#' @param projection Character. Map projection. Default: \code{"globe"}.
#' @param background_color Character. CSS colour for the ocean/background.
#'   Default: \code{"#dbdbdc"}.
#' @param land_background Character. CSS fill colour for land polygons.
#'   Default: \code{"white"}.
#' @param land_line_color Character or NULL. CSS colour for the land polygon
#'   outline. Default: \code{NULL} (no outline).
#' @param add_bathymetry Logical. Whether to overlay GEBCO filtered bathymetry
#'   contour lines. Default: \code{TRUE}.
#' @param bathymetry_color Character. CSS colour for bathymetry lines.
#'   Default: \code{"#044062"}.
#' @param bathymetry_opacity Numeric 0–1. Opacity of bathymetry lines.
#'   Default: \code{0.06}.
#' @param ... Additional arguments forwarded to \code{maplibre()} or
#'   \code{mapboxgl()}.
#'
#' @return A \code{maplibre} or \code{mapboxgl} map object.
#'
#' @examples
#' \dontrun{
#' grey_map()
#' grey_map(add_bathymetry = FALSE)
#' }
#'
#' @export
grey_map <- function(
    type = "maplibre",
    projection = "globe",
    background_color = "#dbdbdc",
    land_background = "white",
    land_line_color = NULL,
    add_bathymetry = TRUE,
    bathymetry_color = "#044062",
    bathymetry_opacity = 0.06,
    ...
) {
    if (type == "maplibre") {
        m <- mapgl::maplibre(
            style = mapgl::basemap_style(color = background_color),
            projection = projection,
            attributionControl = FALSE,
            ...
        )
    } else {
        m <- mapgl::mapboxgl(
            style = mapgl::basemap_style(color = background_color),
            projection = projection,
            ...
        )
    }

    m <- m |>
        mapgl::add_vector_source(
            id = "lands",
            tiles = "https://tiles.obis.org/land_tiles/{z}/{x}/{y}.pbf"
        ) |>
        mapgl::add_fill_layer(
            id = "lands",
            source = "lands",
            source_layer = "land",
            fill_color = land_background,
            fill_outline_color = land_line_color
        )

    if (add_bathymetry) {
        m <- m |>
            mapgl::add_vector_source(
                id = "gebco_filtered",
                tiles = "https://tiles.obis.org/gebco_filtered_tiles/{z}/{x}/{y}.pbf"
            ) |>
            mapgl::add_line_layer(
                id = "gebco_filtered",
                source = "gebco_filtered",
                source_layer = "gebco_filtered",
                line_color = bathymetry_color,
                line_opacity = bathymetry_opacity
            )
    }

    return(m)
}


#' Create a Carto basemap
#'
#' Renders a MapLibre GL or Mapbox GL map using a Carto tile style.
#'
#' @param type Character. Map renderer: \code{"maplibre"} (default) or
#'   \code{"mapboxgl"}.
#' @param projection Character. Map projection. Default: \code{"globe"}.
#' @param carto_map Character. Carto style name passed to \code{carto_style()}.
#'   Common values: \code{"positron"} (default), \code{"dark-matter"},
#'   \code{"voyager"}.
#' @param ... Additional arguments forwarded to \code{maplibre()} or
#'   \code{mapboxgl()}.
#'
#' @return A \code{maplibre} or \code{mapboxgl} map object.
#'
#' @examples
#' \dontrun{
#' carto_map()
#' carto_map(carto_map = "dark-matter")
#' }
#'
#' @export
carto_map <- function(
    type = "maplibre",
    projection = "globe",
    carto_map = "positron",
    ...
) {
    if (type == "maplibre") {
        m <- mapgl::maplibre(
            style = mapgl::carto_style(carto_map),
            projection = projection,
            attributionControl = FALSE,
            ...
        )
    } else {
        m <- mapgl::mapboxgl(
            style = mapgl::carto_style(carto_map),
            projection = projection,
            ...
        )
    }

    return(m)
}


# =============================================================================
# Map layers
# =============================================================================

#' Add OBIS species occurrence data to a map
#'
#' Fetches OBIS occurrence tiles for a given taxon and adds a colour-scaled
#' fill layer (and optional record-count labels) to an existing map.
#'
#' @param map A map object returned by \code{blank_map()}, \code{grey_map()},
#'   \code{carto_map()}, or any compatible \code{maplibre}/\code{mapboxgl}
#'   object.
#' @param taxonid Integer or character. OBIS taxon identifier.
#'   Default: \code{126436}.
#' @param startdate Character or NULL. ISO 8601 start date filter
#'   (e.g. \code{"2000-01-01"}). Default: \code{NULL} (no filter).
#' @param enddate Character or NULL. ISO 8601 end date filter. Default:
#'   \code{NULL}.
#' @param breaks Numeric vector. Breakpoints for the colour scale.
#'   Default: \code{c(0, 10, 100, 1000, 10000)}.
#' @param colors Character vector of CSS colours, one per break.
#'   Default: a blue-to-red diverging palette.
#' @param legend Logical. Whether to add a categorical legend. Default:
#'   \code{FALSE}.
#'
#' @return The input \code{map} object with the species occurrence layer added.
#'
#' @examples
#' \dontrun{
#' blank_map() |> add_species_data()
#'
#' grey_map() |>
#'   add_species_data(
#'     taxonid  = 955271,
#'     breaks   = c(0, 5, 50, 500, 5000),
#'     legend   = TRUE
#'   )
#' }
#'
#' @export
add_species_data <- function(
    map,
    taxonid = 126436,
    startdate = NULL,
    enddate = NULL,
    breaks = c(0, 10, 100, 1000, 10000),
    colors = c("#2c7bb6", "#abd9e9", "#ffffbf", "#fdae61", "#d7191c"),
    legend = FALSE
) {
    params <- list(
        taxonid = as.character(taxonid),
        startdate = startdate,
        enddate = enddate
    )

    params <- params[!vapply(params, is.null, logical(1))]

    query <- paste(
        names(params),
        vapply(params, URLencode, character(1), reserved = TRUE),
        sep = "=",
        collapse = "&"
    )

    m <- map |>
        mapgl::add_vector_source(
            id = "taxon",
            tiles = paste0(
                "https://api.obis.org/v3/occurrence/tile/{x}/{y}/{z}.mvt?",
                query
            )
        ) |>
        mapgl::add_fill_layer(
            id = "taxon",
            source = "taxon",
            source_layer = "grid",
            fill_color = mapgl::interpolate(
                column = "doc_count",
                values = breaks,
                stops = colors
            )
        ) |>
        mapgl::add_symbol_layer(
            id = "number-of-records",
            source = "taxon",
            source_layer = "grid",
            text_field = c("get", "doc_count"),
            text_color = "black",
            text_anchor = "center",
            text_size = 10,
            text_halo_color = "white",
            text_halo_width = 1,
            text_halo_blur = 0
        )

    if (legend) {
        m <- m |> mapgl::add_categorical_legend(
            legend_title = "Records",
            values = breaks,
            colors = colors,
            position = "bottom-right"
        )
    }

    return(m)
}


#' Add UI controls to a map
#'
#' Adds fullscreen, globe-projection toggle, and scale bar controls to an
#' existing map object. Each control can be toggled on or off independently.
#'
#' @param map A map object (e.g. from \code{blank_map()}).
#' @param fullscreen Logical. Add a fullscreen button. Default: \code{TRUE}.
#' @param globe Logical. Add a globe-projection toggle button. Default:
#'   \code{TRUE}.
#' @param scale Logical. Add a scale bar. Default: \code{TRUE}.
#' @param fullscreen_position Character. Corner position of the fullscreen
#'   button. Default: \code{"bottom-left"}.
#' @param globe_position Character. Corner position of the globe toggle.
#'   Default: \code{"bottom-left"}.
#' @param scale_position Character. Corner position of the scale bar.
#'   Default: \code{"bottom-left"}.
#'
#' @return The input \code{map} object with the requested controls added.
#'
#' @examples
#' \dontrun{
#' blank_map(projection = "none") |> add_map_controls()
#'
#' grey_map() |>
#'   add_map_controls(globe = FALSE, scale_position = "bottom-right")
#' }
#'
#' @export
add_map_controls <- function(
    map,
    fullscreen = TRUE,
    globe = TRUE,
    scale = TRUE,
    fullscreen_position = "bottom-left",
    globe_position = "bottom-left",
    scale_position = "bottom-left"
) {
    if (fullscreen) {
        map <- map |>
            mapgl::add_fullscreen_control(position = fullscreen_position)
    }

    if (globe) {
        map <- map |>
            mapgl::add_globe_control(position = globe_position)
    }

    if (scale) {
        map <- map |>
            mapgl::add_scale_control(position = scale_position)
    }

    return(map)
}


# =============================================================================
# Helpers
# =============================================================================

#' Get the geographic extent of a species from OBIS
#'
#' Queries the OBIS API occurrence grid endpoint and returns an \code{sf}
#' object that can be passed to \code{fit_bounds()} to zoom a map to the
#' species range.
#'
#' @param taxonid Integer or character. OBIS taxon identifier.
#' @param startdate Character or NULL. ISO 8601 start date filter. Default:
#'   \code{NULL}.
#' @param enddate Character or NULL. ISO 8601 end date filter. Default:
#'   \code{NULL}.
#' @param precision Integer. H3 resolution used for the grid query (1–15).
#'   Default: \code{2}.
#'
#' @return An \code{sf} object with the occurrence grid polygons.
#'
#' @examples
#' \dontrun{
#' ext <- get_species_extent(taxonid = 955271)
#'
#' blank_map(projection = "mercator") |>
#'   add_species_data(taxonid = 955271) |>
#'   fit_bounds(ext)
#' }
#'
#' @export
get_species_extent <- function(taxonid, startdate = NULL, enddate = NULL, precision = 2) {
    resp <- httr2::request("https://api.obis.org") |>
        httr2::req_url_path_append("v3", "occurrence", "grid", as.character(precision)) |>
        httr2::req_url_query(
            taxonid = taxonid,
            startdate = startdate,
            enddate = enddate
        ) |>
        httr2::req_perform()

    resp |>
        httr2::resp_body_string() |>
        sf::st_read(quiet = TRUE)
}


#' Add an inline H3J source to a MapLibre map
#'
#' Encodes a data frame of H3 cells as an H3J JSON blob, base64-encodes it
#' as a \code{data:} URI, and adds it as a vector source via
#' \code{add_h3j_source()}. This avoids the need for a separate file or server.
#'
#' @param map A map object (e.g. from \code{blank_map()}).
#' @param id Character. Source identifier used when referencing the layer.
#' @param df A data frame with at least one column of H3 cell index strings.
#'   All other columns are included as properties on each cell feature.
#' @param h3_col Character. Name of the column containing H3 cell indices.
#'   Default: \code{"h3"}.
#'
#' @return The input \code{map} object with the H3J vector source attached.
#'
#' @examples
#' \dontrun{
#' library(duckdb)
#' library(h3jsr)
#' library(dplyr)
#'
#' con <- dbConnect(duckdb())
#' df <- dbGetQuery(con, "
#'   SELECT records, cell
#'   FROM read_parquet('s3://obis-products/speciesgrids/h3_7/*')
#'   WHERE species = 'Minuca rapax'
#' ")
#' df <- df |>
#'   mutate(h3 = h3jsr::get_parent(cell, 3)) |>
#'   group_by(h3) |>
#'   summarise(value = sum(records))
#'
#' blank_map(projection = "mercator") |>
#'   add_h3j_source_inline("h3source", df = df, h3_col = "h3") |>
#'   add_fill_layer(
#'     id           = "h3layer",
#'     source       = "h3source",
#'     fill_color   = interpolate(
#'       column = "value",
#'       values = c(0, 5, 10, 15, 20),
#'       stops  = c("#2c7bb6", "#abd9e9", "#ffffbf", "#fdae61", "#d7191c")
#'     ),
#'     fill_opacity = 0.8
#'   ) |>
#'   fit_bounds(get_species_extent(taxonid = 955271))
#' }
#'
#' @export
add_h3j_source_inline <- function(map, id, df, h3_col = "h3") {
    cells <- lapply(seq_len(nrow(df)), function(i) {
        row <- as.list(df[i, , drop = FALSE])
        names(row)[names(row) == h3_col] <- "h3id"
        row
    })
    h3j <- list(metadata = list(version = "1.0"), cells = cells)

    json     <- jsonlite::toJSON(h3j, auto_unbox = TRUE)
    data_uri <- paste0("data:application/json;base64,",
                       jsonlite::base64_enc(json))

    mapgl::add_h3j_source(map, id = id, url = data_uri)
}


# =============================================================================
# DeckGL H3 widget
# =============================================================================

#' MapLibre GL + DeckGL H3 hexagon layer widget
#'
#' Creates an interactive \code{htmlwidget} combining a MapLibre GL basemap
#' (OBIS style) with a DeckGL \code{H3HexagonLayer} overlay. Suitable for
#' visualising species richness, record counts, or any per-H3-cell metric.
#'
#' @param data A data frame with at minimum a column of H3 cell index strings.
#'   Additional numeric columns can be used for colour/elevation mapping.
#' @param h3_column Character. Name of the column containing H3 cell index
#'   strings. Default: \code{"h3"}.
#' @param value_column Character or NULL. Name of the column used to drive fill
#'   colour (and optionally elevation). When \code{NULL} all hexagons share a
#'   single colour. Default: \code{"value"}.
#' @param color_range A list of 6 RGB triplets (each a length-3 integer vector
#'   in 0–255) used as the colour ramp. Defaults to a blue-to-red diverging
#'   palette.
#' @param extruded Logical. Whether to extrude hexagons as 3-D columns.
#'   Default: \code{FALSE}.
#' @param elevation_scale Numeric. Multiplier applied to the elevation when
#'   \code{extruded = TRUE}. Default: \code{1}.
#' @param pitch Numeric. Camera pitch in degrees (0 = top-down, 60 = oblique).
#'   Default: \code{45} when \code{extruded = TRUE}, \code{0} otherwise.
#' @param opacity Numeric 0–1. Fill opacity of the hexagons. Default:
#'   \code{0.8}.
#' @param center Numeric vector \code{c(longitude, latitude)}. Initial map
#'   centre. Default: \code{c(0, 25)}.
#' @param zoom Numeric. Initial zoom level. Default: \code{2}.
#' @param filter Named list of extra query parameters forwarded to the OBIS
#'   occurrence tile endpoint (e.g. \code{list(taxonid = "12345")}).
#'   Default: \code{list()} (no filter).
#' @param show_occurrence_layer Logical. Whether to show the OBIS occurrence
#'   grid layer beneath the H3 layer. Default: \code{FALSE}.
#' @param width,height Widget dimensions (CSS string or pixels). Default:
#'   \code{NULL} (fills its container).
#' @param elementId Optional HTML element ID for the widget.
#'
#' @return An \code{htmlwidget} object.
#'
#' @examples
#' \dontrun{
#' library(h3jsr)
#'
#' cells <- h3jsr::get_disk("8928308280fffff", ring_size = 5)
#' df <- data.frame(
#'   h3    = cells,
#'   value = runif(length(cells), 0, 500)
#' )
#'
#' maplibre_h3(df)
#' maplibre_h3(df, extruded = TRUE, elevation_scale = 100)
#' }
#'
#' @importFrom htmlwidgets createWidget sizingPolicy
#' @importFrom htmltools htmlDependency
#' @importFrom jsonlite toJSON
#' @export
maplibre_h3 <- function(
    data,
    h3_column             = "h3",
    value_column          = "value",
    color_range           = NULL,
    extruded              = FALSE,
    elevation_scale       = 1,
    pitch                 = NULL,
    opacity               = 0.8,
    center                = c(0, 25),
    zoom                  = 2,
    filter                = list(),
    show_occurrence_layer = FALSE,
    width                 = NULL,
    height                = NULL,
    elementId             = NULL
) {
    if (!is.data.frame(data)) stop("`data` must be a data frame.")
    if (!h3_column %in% names(data))
        stop(sprintf("Column '%s' not found in `data`.", h3_column))

    use_value <- !is.null(value_column) && value_column %in% names(data)

    h3_data <- lapply(seq_len(nrow(data)), function(i) {
        row <- list(hex = data[[h3_column]][i])
        if (use_value) row$value <- data[[value_column]][i]
        row
    })

    if (is.null(color_range)) {
        color_range <- list(
            c(35,  23,  92),
            c(30,  100, 200),
            c(80,  200, 220),
            c(180, 230, 100),
            c(255, 170,  30),
            c(210,  30,  20)
        )
    }

    x <- list(
        h3Data              = h3_data,
        h3Column            = h3_column,
        valueColumn         = if (use_value) value_column else NULL,
        colorRange          = color_range,
        extruded            = extruded,
        elevationScale      = elevation_scale,
        pitch               = if (is.null(pitch)) if (extruded) 45 else 0 else pitch,
        opacity             = opacity,
        center              = center,
        zoom                = zoom,
        filter              = filter,
        showOccurrenceLayer = show_occurrence_layer
    )

    htmlwidgets::createWidget(
        name         = "maplibre_h3",
        x            = x,
        width        = width,
        height       = height,
        package      = "obisrecipes",
        elementId    = elementId,
        sizingPolicy = htmlwidgets::sizingPolicy(
            defaultWidth        = "100%",
            defaultHeight       = 500,
            viewer.fill         = TRUE,
            browser.fill        = TRUE,
            knitr.figure        = FALSE,
            knitr.defaultWidth  = "100%",
            knitr.defaultHeight = "500px"
        )
    )
}


#' Shiny output function for \code{maplibre_h3}
#'
#' @param outputId Output variable to read from.
#' @param width,height Widget dimensions (CSS string or pixels).
#'
#' @return A Shiny output object.
#'
#' @export
maplibre_h3Output <- function(outputId, width = "100%", height = "400px") {
    htmlwidgets::shinyWidgetOutput(outputId, "maplibre_h3", width, height,
                                   package = "obisrecipes")
}


#' Shiny render function for \code{maplibre_h3}
#'
#' @param expr An expression that returns a \code{maplibre_h3} widget.
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Logical. Is \code{expr} already quoted? Default: \code{FALSE}.
#'
#' @return A Shiny render function.
#'
#' @export
renderMaplibre_h3 <- function(expr, env = parent.frame(), quoted = FALSE) {
    if (!quoted) expr <- substitute(expr)
    htmlwidgets::shinyRenderWidget(expr, maplibre_h3Output, env, quoted = TRUE)
}


#' Create a standalone \code{maplibre_h3} widget without a package install
#'
#' A lightweight wrapper around \code{htmlwidgets::createWidget()} that wires
#' up all CDN and local JS/CSS dependencies manually. Intended for development
#' and local testing when the package is not installed.
#'
#' @param data A data frame with H3 cell index and value columns.
#' @param h3_column Character. Column name for H3 indices. Default: \code{"h3"}.
#' @param value_column Character. Column name for the numeric value.
#'   Default: \code{"value"}.
#' @param center Numeric vector \code{c(longitude, latitude)}. Initial map
#'   centre. Default: \code{c(0, 25)}.
#' @param zoom Numeric. Initial zoom level. Default: \code{2}.
#' @param ... Ignored (reserved for future use).
#'
#' @return An \code{htmlwidget} object.
#'
#' @examples
#' \dontrun{
#' df <- data.frame(
#'   h3    = c("8429a1fffffffff", "8429a3fffffffff"),
#'   value = c(100, 500)
#' )
#' w <- maplibre_h3_local(df, center = c(3.5, 55), zoom = 4)
#' w
#' htmlwidgets::saveWidget(w, "map.html", selfcontained = TRUE)
#' }
#'
#' @export
maplibre_h3_local <- function(data, h3_column = "h3", value_column = "value",
                               center = c(0, 25), zoom = 2, ...) {
    widget_dep <- htmltools::htmlDependency(
        name       = "maplibre_h3-binding",
        version    = "0.1.0",
        src        = c(file = normalizePath("R/widgets")),
        script     = "maplibre_h3.js",
        stylesheet = "maplibre_h3.css"
    )
    h3_dep <- htmltools::htmlDependency(
        name    = "h3-js",
        version = "4.1.0",
        src     = c(href = "https://unpkg.com/h3-js@4.1.0/dist"),
        script  = "h3-js.umd.js"
    )
    maplibre_dep <- htmltools::htmlDependency(
        name       = "maplibre-gl",
        version    = "4.7.1",
        src        = c(href = "https://unpkg.com/maplibre-gl@4.7.1/dist"),
        script     = "maplibre-gl.js",
        stylesheet = "maplibre-gl.css"
    )
    deck_dep <- htmltools::htmlDependency(
        name    = "deck-gl",
        version = "9.0.7",
        src     = c(href = "https://unpkg.com/deck.gl@9.0.7"),
        script  = "dist.min.js"
    )

    x <- list(
        h3Data      = lapply(seq_len(nrow(data)), function(i)
            list(hex = data[[h3_column]][i], value = data[[value_column]][i])),
        valueColumn = value_column,
        colorRange  = list(c(35, 23, 92), c(30, 100, 200), c(80, 200, 220),
                           c(180, 230, 100), c(255, 170, 30), c(210, 30, 20)),
        extruded       = FALSE,
        elevationScale = 1,
        opacity        = 0.8,
        center         = center,
        zoom           = zoom,
        filter         = list(),
        showOccurrenceLayer = FALSE
    )

    htmlwidgets::createWidget(
        name         = "maplibre_h3",
        x            = x,
        dependencies = list(h3_dep, maplibre_dep, deck_dep, widget_dep),
        sizingPolicy = htmlwidgets::sizingPolicy(
            defaultWidth  = "100%",
            defaultHeight = 500,
            viewer.fill   = TRUE,
            browser.fill  = TRUE
        )
    )
}
