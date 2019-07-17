//
//  tippecanoe.h
//  Pods
//
//  Created by Evegeny Kalashnikov on 7/12/19.
//

#include <stdbool.h>

#ifndef _tippecanoe_h_
#define _tippecanoe_h_

#ifdef __cplusplus
extern "C" {
#endif

    typedef struct RenderOptions {
        bool rewrite;
        bool rg;
        char *output;
        char *input;
        char *tmpdir;
        int maxzoom;
        bool quiet;
    } RenderOptions;

    int render_tiles(RenderOptions options,  double *persent);
#ifdef __cplusplus
}
#endif

#endif /* _tippecanoe_h_ */
