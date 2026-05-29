/* maplibre_h3.js — htmlwidgets binding
 *
 * Dependencies (loaded via maplibre_h3.yaml):
 *   h3-js          → window.h3
 *   maplibre-gl    → window.maplibregl
 *   deck.gl        → window.deck  (includes H3HexagonLayer via @deck.gl/geo-layers)
 */

HTMLWidgets.widget({
  name: "maplibre_h3",
  type: "output",

  factory: function (el, width, height) {
    /* ── State ──────────────────────────────────────────────────────────── */
    let map = null;
    let deckOverlay = null;
    const uniqueId = el.id || ("mh3_" + Math.random().toString(36).slice(2, 8));

    /* ── Build container markup ─────────────────────────────────────────── */
    el.style.position = "relative";
    el.innerHTML = `
      <div class="maplibre-h3-container" style="width:100%;height:100%;">
        <div id="${uniqueId}_map" style="width:100%;height:100%;"></div>
        <div class="maplibre-h3-click-message" id="${uniqueId}_click-message">
          Click map to enable scroll &amp; pan
        </div>
        <div class="maplibre-h3-legend" id="${uniqueId}_legend" style="display:none"></div>
      </div>`;

    /* ── Colour helpers ─────────────────────────────────────────────────── */
    function buildColorScale(colorRange, minVal, maxVal) {
      return function (val) {
        const t = Math.max(0, Math.min(1, (val - minVal) / (maxVal - minVal || 1)));
        const n = colorRange.length - 1;
        const lo = Math.floor(t * n);
        const hi = Math.min(lo + 1, n);
        const f = t * n - lo;
        const c0 = colorRange[lo];
        const c1 = colorRange[hi];
        return [
          Math.round(c0[0] + (c1[0] - c0[0]) * f),
          Math.round(c0[1] + (c1[1] - c0[1]) * f),
          Math.round(c0[2] + (c1[2] - c0[2]) * f),
          255
        ];
      };
    }

    function cssFromRgb(rgb) {
      return `rgb(${rgb[0]},${rgb[1]},${rgb[2]})`;
    }

    /* ── Legend ─────────────────────────────────────────────────────────── */
    function buildLegend(legendEl, colorRange, minVal, maxVal) {
      const stops = colorRange
        .map(c => cssFromRgb(c))
        .join(", ");
      legendEl.style.display = "block";
      legendEl.innerHTML = `
        <div class="legend-title">Value</div>
        <div class="legend-bar" style="background:linear-gradient(to right,${stops})"></div>
        <div class="legend-labels">
          <span>${minVal.toFixed(1)}</span>
          <span>${maxVal.toFixed(1)}</span>
        </div>`;
    }

    /* ── MapLibre basemap style ─────────────────────────────────────────── */
    function buildMapStyle(params) {
      const occurrenceSources = {};
      const occurrenceLayers = [];

      if (params.showOccurrenceLayer) {
        const qs = new URLSearchParams(params.filter || {}).toString();
        occurrenceSources["occurrence"] = {
          type: "vector",
          tiles: [`https://api.obis.org/occurrence/tile/{x}/{y}/{z}.mvt${qs ? "?" + qs : ""}`],
          scheme: "xyz"
        };
        occurrenceLayers.push(
          {
            id: "obis-occurrence-fill",
            type: "fill",
            source: "occurrence",
            "source-layer": "grid",
            paint: {
              "fill-color": [
                "interpolate", ["linear"], ["get", "doc_count"],
                0, "#2c7bb6", 10, "#abd9e9", 100, "#ffffbf",
                1000, "#fdae61", 10000, "#d7191c"
              ],
              "fill-opacity": 0.6
            }
          },
          {
            id: "obis-occurrence-labels",
            type: "symbol",
            source: "occurrence",
            "source-layer": "grid",
            layout: {
              "text-field": ["to-string", ["get", "doc_count"]],
              "text-size": 10,
              "text-anchor": "center"
            },
            paint: {
              "text-color": "#000000",
              "text-halo-color": "rgba(255,255,255,1)",
              "text-halo-width": 1,
              "text-halo-blur": 0
            }
          }
        );
      }

      return {
        version: 8,
        glyphs: "https://demotiles.maplibre.org/font/{fontstack}/{range}.pbf",
        sources: {
          land_polygons: {
            type: "vector",
            tiles: ["https://tiles.obis.org/land_tiles/{z}/{x}/{y}.pbf"],
            minzoom: 0,
            maxzoom: 14
          },
          gebco_filtered: {
            type: "vector",
            tiles: ["https://tiles.obis.org/gebco_filtered_tiles/{z}/{x}/{y}.pbf"],
            minzoom: 0,
            maxzoom: 14
          },
          ...occurrenceSources
        },
        layers: [
          {
            id: "background",
            type: "background",
            paint: { "background-color": "#dbdbdc" }
          },
          {
            id: "land_polygons",
            type: "fill",
            source: "land_polygons",
            "source-layer": "land",
            paint: { "fill-color": "#fcfcfd", "fill-opacity": 1.0 }
          },
          {
            id: "contours",
            type: "line",
            source: "gebco_filtered",
            "source-layer": "gebco_filtered",
            paint: {
              "line-color": "#044062",
              "line-width": 0.2,
              "line-opacity": 0.33
            }
          },
          {
            id: "contour-labels",
            type: "symbol",
            source: "gebco_filtered",
            "source-layer": "gebco_filtered",
            minzoom: 6,
            layout: {
              "text-field": ["to-string", ["abs", ["get", "DEPTH"]]],
              "text-font": ["Open Sans Regular", "Arial Unicode MS Regular"],
              "text-size": 10,
              "symbol-placement": "line",
              "symbol-spacing": 100,
              "text-rotation-alignment": "map",
              "text-pitch-alignment": "viewport",
              "text-allow-overlap": false,
              "text-ignore-placement": false,
              "text-optional": false
            },
            paint: {
              "text-color": "#044062",
              "text-halo-color": "#ffffff",
              "text-halo-width": 1.5,
              "text-halo-blur": 1
            }
          },
          ...occurrenceLayers
        ]
      };
    }

    /* ── Main render ────────────────────────────────────────────────────── */
    function renderWidget(x) {
      const mapEl = document.getElementById(`${uniqueId}_map`);
      const clickMsg = document.getElementById(`${uniqueId}_click-message`);
      const legendEl = document.getElementById(`${uniqueId}_legend`);

      /* Destroy previous instances */
      if (deckOverlay) { deckOverlay.finalize(); deckOverlay = null; }
      if (map) { map.remove(); map = null; }

      /* ── Compute value stats ──────────────────────────────────────────── */
      const hasValue = x.valueColumn !== null &&
                       x.h3Data.length > 0 &&
                       "value" in x.h3Data[0];
      let minVal = 0, maxVal = 1;
      if (hasValue) {
        const vals = x.h3Data.map(d => d.value);
        minVal = Math.min(...vals);
        maxVal = Math.max(...vals);
      }

      const colorScale = buildColorScale(x.colorRange, minVal, maxVal);
      if (hasValue) buildLegend(legendEl, x.colorRange, minVal, maxVal);

      /* ── MapLibre instance ────────────────────────────────────────────── */
      map = new maplibregl.Map({
        container: mapEl,
        center: x.center,
        zoom: x.zoom,
        pitch: x.pitch,
        style: buildMapStyle(x),
        projection: "mercator",
        attributionControl: false,
        scrollZoom: false,
        dragPan: false
      });

      map.addControl(new maplibregl.ScaleControl({ maxWidth: 100, unit: "metric" }), "bottom-left");
      map.addControl(new maplibregl.FullscreenControl(), "bottom-left");
      map.addControl(new maplibregl.NavigationControl(), "top-right");
      map.addControl(new maplibregl.AttributionControl({ compact: true }), "bottom-right");

      /* Enable pan/zoom on first click */
      map.once("click", function () {
        map.scrollZoom.enable();
        map.dragPan.enable();
        if (clickMsg) clickMsg.style.display = "none";
      });

      /* ── DeckGL H3HexagonLayer ────────────────────────────────────────── */
      map.on("load", function () {

        const h3Layer = new deck.H3HexagonLayer({
          id: "h3-hexagon-layer-" + uniqueId,
          data: x.h3Data,
          pickable: true,
          extruded: x.extruded,
          elevationScale: x.elevationScale,
          opacity: x.opacity,
          highPrecision: "auto",
          getHexagon: d => d.hex,
          getFillColor: d => hasValue ? colorScale(d.value) : [44, 123, 182, 200],
          getElevation: d => hasValue ? d.value : 0,
          updateTriggers: {
            getFillColor: [x.colorRange, minVal, maxVal],
            getElevation: [x.elevationScale]
          }
        });

        /* Use MapboxOverlay so DeckGL shares the same WebGL context as MapLibre */
        deckOverlay = new deck.MapboxOverlay({
          interleaved: false,
          layers: [h3Layer],
          getTooltip: ({ object }) => {
            if (!object) return null;
            let html = `<div><b>H3:</b> ${object.hex}</div>`;
            if (hasValue) html += `<div><b>Value:</b> ${object.value.toFixed(3)}</div>`;
            return { html, className: "deck-tooltip" };
          }
        });

        map.addControl(deckOverlay);
      });
    }

    /* ── htmlwidgets interface ──────────────────────────────────────────── */
    return {
      renderValue: function (x) {
        renderWidget(x);
      },
      resize: function (width, height) {
        if (map) map.resize();
      }
    };
  }
});
