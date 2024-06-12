//
//  tippecanoe.cpp
//  tippecanoe-swift
//
//  Created by Evegeny Kalashnikov on 7/15/19.
//

#include <stdio.h>
#include "tippecanoe.hpp"
#include "../tippecanoe/main.hpp"

int render_tiles(RenderOptions options, double *persent) {

    char minzoom[18]; // 18 - size of char array
    sprintf(minzoom, "--minimum-zoom=%d", options.minzoom);

    char maxzoom[18]; // 18 - size of char array
    sprintf(maxzoom, "--maximum-zoom=%d", options.maxzoom);

    char full_detail[17]; // 17 - size of char array
    sprintf(full_detail, "--full-detail=%d", options.full_detail);

    char low_detail[16]; // 16 - size of char array
    sprintf(low_detail, "--low-detail=%d", options.low_detail);

    char minimum_detail[20]; // 20 - size of char array
    sprintf(minimum_detail, "--minimum-detail=%d", options.minimum_detail);

    int argc = 13; // 13 - means 13 records in array on init
    char *argv[22] = { // 22 - array size (max records count)
        (char*)"tippecanoe",
        (char*)"-o",
        options.output,
        options.input,
        (char*)"-t",
        options.tmpdir,
        minzoom,
        maxzoom,
        full_detail,
        low_detail,
        minimum_detail,
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

    if (options.drop_densest_as_needed) {
        argv[argc] = (char*)"--drop-densest-as-needed";
        argc++;
    }

    if (options.drop_fraction_as_needed) {
        argv[argc] = (char*)"--drop-fraction-as-needed";
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
