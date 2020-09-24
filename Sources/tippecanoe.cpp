//
//  tippecanoe.cpp
//  tippecanoe-swift
//
//  Created by Evegeny Kalashnikov on 7/15/19.
//

#include <stdio.h>
#include "tippecanoe.hpp"
#include "tippecanoe/main.hpp"

int render_tiles(RenderOptions options, double *persent) {

    char minzoom[18];
    sprintf(minzoom, "--minimum-zoom=%d", options.minzoom);

    char maxzoom[18];
    sprintf(maxzoom, "--maximum-zoom=%d", options.maxzoom);

    int argc = 10;
    char *argv[17] = {
        (char*)"tippecanoe",
        (char*)"-o",
        options.output,
        options.input,
        (char*)"-t",
        options.tmpdir,
        minzoom,
        maxzoom,
        (char*)"-l",
        options.layer
    };

    if (options.rewrite) {
        argv[argc] = (char*)"-f";
        argc++;
    }

    switch (options.drop_rate) {
        case drop_rate_default:
            break;
        case drop_rate_g:
            argv[argc] = (char*)"-rg";
            argc++;
            break;
        case drop_rate_f:
            argv[argc] = (char*)"-rf";
            argc++;
            break;
        case drop_rate_1:
            argv[argc] = (char*)"-r1";
            argc++;
            break;
    }

    switch (options.base_zoom) {
        case base_zoom_default:
            break;
        case base_zoom_g:
            argv[argc] = (char*)"-Bg";
            argc++;
            break;
        case base_zoom_f:
            argv[argc] = (char*)"-Bf";
            argc++;
            break;
        case base_zoom_1:
            argv[argc] = (char*)"-B1";
            argc++;
            break;
        case base_zoom_2:
            argv[argc] = (char*)"-B2";
            argc++;
            break;
        case base_zoom_3:
            argv[argc] = (char*)"-B3";
            argc++;
            break;
        case base_zoom_4:
            argv[argc] = (char*)"-B4";
            argc++;
            break;
        case base_zoom_5:
            argv[argc] = (char*)"-B5";
            argc++;
            break;
        case base_zoom_6:
            argv[argc] = (char*)"-B6";
            argc++;
            break;
    }

    if (options.no_stat) {
        argv[argc] = (char*)"--no-tile-stats";
        argc++;
    }

    if (options.no_tile_compression) {
        argv[argc] = (char*)"--no-tile-compression";
        argc++;
    }

    if (options.parallel) {
        argv[argc] = (char*)"--read-parallel";
        argc++;
    }

    if (options.quiet) {
        argv[argc] = (char*)"--quiet";
        argc++;
    }

    return tippecanoe_main(argc, argv, persent);
}
