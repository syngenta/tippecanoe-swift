//
//  tile-join.cpp
//  tippecanoe-swift
//
//  Created by Evegeny Kalashnikov on 24.09.2020.
//

#include "tile-join-binding.hpp"
#include "tile-join.hpp"

int join_tiles(JoinOptions options) {
    int argc = 3; // 3 - means 3 records in array on init
    char *argv[17] = { // 17 - array size (max records count)
        (char*)"tile-join",
        (char*)"-o",
        options.output
    };

    for (int i = 0; i < 10; i++) { // input paths max 10
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

    if (options.filter) {
        argv[argc] = (char*)"-j";
        argc++;

        argv[argc] = options.filter;
        argc++;
    }

    return tile_join_main(argc, argv);
}
