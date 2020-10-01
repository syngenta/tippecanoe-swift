//
//  tile-join.hpp
//  tippecanoe-swift
//
//  Created by Evegeny Kalashnikov on 24.09.2020.
//

#include <stdbool.h>

#ifndef _tile_join_hpp_
#define _tile_join_hpp_

#ifdef __cplusplus
extern "C" {
#endif

typedef struct JoinOptions {
    char *output;
    char *input[10]; // max 10 paths
    char *tmpdir;
    bool force;
    bool quiet;
} JoinOptions;

int join_tiles(JoinOptions options);

#ifdef __cplusplus
}
#endif

#endif /* _tile_join_hpp_ */
