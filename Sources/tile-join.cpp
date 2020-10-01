//
//  tile-join.cpp
//  tippecanoe-swift
//
//  Created by Evegeny Kalashnikov on 24.09.2020.
//

#include "tile-join.hpp"
#include "tippecanoe/tile-join.hpp"

int join_tiles(JoinOptions options) {
    int argc = 3;
    char *argv[15] = {
        (char*)"tile-join",
        (char*)"-o",
        options.output
    };

    for (int i = 0; i < 10; i++) {
        char *input = options.input[i];
        if (input) {
            argv[argc] = input;
            argc++;
        }
    }

    if (options.force) {
        argv[argc] = (char*)"--force";
        argc++;
    }

    if (options.quiet) {
        argv[argc] = (char*)"--quiet";
        argc++;
    }

    return tile_join_main(argc, argv);
}
