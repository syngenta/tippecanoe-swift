// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "tippecanoe-swift",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(
            name: "tippecanoe-swift",
            targets: ["tippecanoe-swift"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "tippecanoe-swift",
            dependencies: ["tippecanoe"],
            path: "Sources/tippecanoe-swift"
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
                "CHANGELOG.md"
            ],
            publicHeadersPath: ".",
            cxxSettings: [
                .headerSearchPath("."),
                .define("TARGET_OS_IPHONE", to: "1"),
                .unsafeFlags(["-O3", "-w"])
            ],
            linkerSettings: [
                .linkedLibrary("sqlite3"),
                .linkedLibrary("z")
            ]
        ),
        .target(
            name: "tippecanoe",
            dependencies: ["tippecanoe-origin"],
            path: "Sources/CBindings",
            cSettings: [
                .headerSearchPath("../"),
                .define("TARGET_OS_IPHONE", to: "1")
            ]
        )
    ],
    swiftLanguageVersions: [.v5],
    cxxLanguageStandard: .cxx14
)
