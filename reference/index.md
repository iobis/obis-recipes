# Package index

## ggplot2 styles

Themes, color scales, palette helpers, and export utilities.

- [`theme_obis()`](https://iobis.github.io/obis-recipes/reference/theme_obis.md)
  : Light OBIS ggplot2 theme
- [`theme_obis_dark()`](https://iobis.github.io/obis-recipes/reference/theme_obis_dark.md)
  : Dark marine ggplot2 theme
- [`theme_obis_pub()`](https://iobis.github.io/obis-recipes/reference/theme_obis_pub.md)
  : Publication-quality ggplot2 theme for OBIS
- [`scale_color_obis_cat()`](https://iobis.github.io/obis-recipes/reference/scale_color_obis_cat.md)
  [`scale_fill_obis_cat()`](https://iobis.github.io/obis-recipes/reference/scale_color_obis_cat.md)
  : Colorblind-safe categorical color scale
- [`scale_color_obis_cont()`](https://iobis.github.io/obis-recipes/reference/scale_color_obis_cont.md)
  [`scale_fill_obis_cont()`](https://iobis.github.io/obis-recipes/reference/scale_color_obis_cont.md)
  : Colorblind-safe continuous color scale
- [`guide_colourbar_h()`](https://iobis.github.io/obis-recipes/reference/guide_colourbar_h.md)
  : Horizontal colourbar guide
- [`obis_pal()`](https://iobis.github.io/obis-recipes/reference/obis_pal.md)
  : Generate a colour vector from a named OBIS palette
- [`obis_add_logo()`](https://iobis.github.io/obis-recipes/reference/obis_add_logo.md)
  : Add OBIS and IOC logos to a ggplot
- [`obis_ggsave()`](https://iobis.github.io/obis-recipes/reference/obis_ggsave.md)
  : Save a ggplot with proportionally scaled text
- [`obis_load_fonts()`](https://iobis.github.io/obis-recipes/reference/obis_load_fonts.md)
  : Load Roboto from Google Fonts

## Static maps

ggplot2-based basemaps, grid converters, and occurrence layers.

- [`blank_map_s()`](https://iobis.github.io/obis-recipes/reference/blank_map_s.md)
  : Create a blank white world basemap
- [`grey_map_s()`](https://iobis.github.io/obis-recipes/reference/grey_map_s.md)
  : Create a grey world basemap with optional bathymetry
- [`occ_to_geohashgrid()`](https://iobis.github.io/obis-recipes/reference/occ_to_geohashgrid.md)
  : Convert occurrence records to a geohash grid
- [`occ_to_h3grid()`](https://iobis.github.io/obis-recipes/reference/occ_to_h3grid.md)
  : Convert occurrence records to an H3 hexagonal grid
- [`occ_to_a5grid()`](https://iobis.github.io/obis-recipes/reference/occ_to_a5grid.md)
  : Convert occurrence records to an A5 pentagonal grid
- [`get_occ_gridded()`](https://iobis.github.io/obis-recipes/reference/get_occ_gridded.md)
  : Fetch OBIS occurrences and convert to a spatial grid
- [`get_occ_tiles()`](https://iobis.github.io/obis-recipes/reference/get_occ_tiles.md)
  : Fetch pre-gridded occurrence tiles from the OBIS API
- [`prepare_grid_data()`](https://iobis.github.io/obis-recipes/reference/prepare_grid_data.md)
  : Bin a numeric grid column into labelled factor levels for plotting
- [`obis_scale()`](https://iobis.github.io/obis-recipes/reference/obis_scale.md)
  : OBIS-style binned color scale for ggplot2
- [`add_species_data_s()`](https://iobis.github.io/obis-recipes/reference/add_species_data_s.md)
  : Add a gridded species occurrence layer to a basemap

## Dynamic maps

Interactive WebGL maps via mapgl and the DeckGL H3 widget.

- [`blank_map()`](https://iobis.github.io/obis-recipes/reference/blank_map.md)
  : Create a blank OBIS-style basemap

- [`grey_map()`](https://iobis.github.io/obis-recipes/reference/grey_map.md)
  : Create a grey OBIS-style basemap

- [`carto_map()`](https://iobis.github.io/obis-recipes/reference/carto_map.md)
  : Create a Carto basemap

- [`add_species_data()`](https://iobis.github.io/obis-recipes/reference/add_species_data.md)
  : Add OBIS species occurrence data to a map

- [`get_species_extent()`](https://iobis.github.io/obis-recipes/reference/get_species_extent.md)
  : Get the geographic extent of a species from OBIS

- [`add_map_controls()`](https://iobis.github.io/obis-recipes/reference/add_map_controls.md)
  : Add UI controls to a map

- [`add_h3j_source_inline()`](https://iobis.github.io/obis-recipes/reference/add_h3j_source_inline.md)
  : Add an inline H3J source to a MapLibre map

- [`maplibre_h3()`](https://iobis.github.io/obis-recipes/reference/maplibre_h3.md)
  : MapLibre GL + DeckGL H3 hexagon layer widget

- [`maplibre_h3Output()`](https://iobis.github.io/obis-recipes/reference/maplibre_h3Output.md)
  :

  Shiny output function for `maplibre_h3`

- [`renderMaplibre_h3()`](https://iobis.github.io/obis-recipes/reference/renderMaplibre_h3.md)
  :

  Shiny render function for `maplibre_h3`
