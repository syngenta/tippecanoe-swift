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
    char *input1;
    char *input2;
    char *tmpdir;
    bool quiet;
} JoinOptions;

int join_tiles(JoinOptions options);

#ifdef __cplusplus
}
#endif

#endif /* _tile_join_hpp_ */
