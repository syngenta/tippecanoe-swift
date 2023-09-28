//
//  tippecanoe.hpp
//  tippecanoe-swift
//
//  Created by Evegeny Kalashnikov on 7/12/19.
//

#include <stdbool.h>

#ifndef _tippecanoe_hpp_
#define _tippecanoe_hpp_

#ifdef __cplusplus
extern "C" {
#endif

/// -r rate or --drop-rate=rate:
/// Rate at which dots are dropped at zoom levels below basezoom (default 2.5)
typedef enum {
    drop_rate_default,
    drop_rate_g,
    drop_rate_f,
    drop_rate_1
} drop_rate;

/// -B zoom or --base-zoom=zoom:
/// Base zoom, the level at and above which all points are included in the tiles (default maxzoom)
typedef enum {
    base_zoom_default,
    base_zoom_g,
    base_zoom_f,
    base_zoom_1,
    base_zoom_2,
    base_zoom_3,
    base_zoom_4,
    base_zoom_5,
    base_zoom_6
} base_zoom;

typedef struct RenderOptions {
    bool rewrite;
    char *output;
    char *input;
    char *tmpdir;
    int minzoom;
    int maxzoom;
    int full_detail;
    int low_detail;
    int minimum_detail;
    char *layer;
    drop_rate drop_rate;
    base_zoom base_zoom;
    bool no_stat;
    bool no_tile_compression;
    bool drop_densest_as_needed;
    bool drop_fraction_as_needed;
    bool parallel;

    bool quiet;
} RenderOptions;

int render_tiles(RenderOptions options,  double *persent);

#ifdef __cplusplus
}
#endif

#endif /* _tippecanoe_hpp_ */
