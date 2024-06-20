// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "tippecanoe-swift",
    products: [
        .library(
            name: "tippecanoe-swift",
            type: .dynamic,
            targets: ["tippecanoe-swift"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "tippecanoe-swift",
            dependencies: ["tippecanoe"],
            path: "Sources/tippecanoe-swift",
            cxxSettings: [
                .define("TARGET_OS_IPHONE", to: "1")
            ]
        ),
        .target(
            name: "tippecanoe",
            dependencies: ["tippecanoe-origin"],
            path: "Sources/CBindings",
            cxxSettings: [
                .headerSearchPath("../"),
                .headerSearchPath("../tippecanoe"),
                .define("TARGET_OS_IPHONE", to: "1")
            ]
        ),
        .target(
            name: "tippecanoe-origin",
            dependencies: [],
            path: "Sources/tippecanoe",
            exclude: [
                "tests",
                "Dockerfile",
                "Dockerfile.centos7",
                "Makefile",
                "vector_tile.proto",
                "milo/LICENSE.txt",
                "mapbox/LICENSE-variant",
                "mapbox/LICENSE-wagyu",
                "man/tippecanoe.1",
                "filters/limit-tiles-to-bbox",
                "codecov.yml",
                "catch/LICENSE_1_0.txt",
                "README.md",
                "MADE_WITH.md",
                "LICENSE.md",
                "CHANGELOG.md",
                "main.cpp"
            ],
            sources: [
                "geocsv.cpp",
                "geojson.cpp",
                "geometry.cpp",
                "geobuf.cpp",
                "text.cpp",
                "csv.cpp",
                "write_json.cpp",
                "projection.cpp",
                "memfile.cpp",
                "mvt.cpp",
                "evaluator.cpp",
                "plugin.cpp",
                "serial.cpp",
                "mbtiles.cpp",
                "dirtiles.cpp",
                "unit.cpp",
                "read_json.cpp",
                "geojson-loop.cpp",
                "decode.cpp",
                "pool.cpp",
                "tile.cpp",
                "enumerate.cpp",
                "main_copy.cpp",
                "tile-join.cpp",
                "jsontool.cpp",
                "jsonpull/jsonpull.c"
            ],
            publicHeadersPath: ".",
            cxxSettings: [
                .headerSearchPath("."),
                .define("TARGET_OS_IPHONE", to: "1")
            ],
            linkerSettings: [
                .linkedLibrary("sqlite3"),
                .linkedLibrary("z")
            ]
        )
    ],
    swiftLanguageVersions: [.v5],
    cxxLanguageStandard: .cxx17
)
