//
//  tile-join.cpp
//  tippecanoe-swift
//
//  Created by Evegeny Kalashnikov on 24.09.2020.
//

#include "tile-join.hpp"
#include "tippecanoe/tile-join.hpp"

int join_tiles(JoinOptions options) {
    int argc = 5;
    char *argv[6] = {
        (char*)"tile-join",
        (char*)"-o",
        options.output,
        options.input1,
        options.input2
    };

    if (options.quiet) {
        argv[argc] = (char*)"--quiet";
        argc++;
    }

    return tile_join_main(argc, argv);
}
