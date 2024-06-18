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
            dependencies: ["tippecanoe-origin", "tippecanoe"],
            path: "Sources/tippecanoe-swift"
        ),
        .target(
            name: "tippecanoe-origin",
            dependencies: [],
            path: "Sources",
            exclude: [
                "tippecanoe-swift",
                "CBindings",
                "tippecanoe/tests",
                "tippecanoe/Dockerfile",
                "tippecanoe/Dockerfile.centos7",
                "tippecanoe/Makefile",
                "tippecanoe/vector_tile.proto",
                "tippecanoe/milo/LICENSE.txt",
                "tippecanoe/mapbox/LICENSE-variant",
                "tippecanoe/mapbox/LICENSE-wagyu",
                "tippecanoe/man/tippecanoe.1",
                "tippecanoe/filters/limit-tiles-to-bbox",
                "tippecanoe/codecov.yml",
                "tippecanoe/catch/LICENSE_1_0.txt",
                "tippecanoe/README.md",
                "tippecanoe/MADE_WITH.md",
                "tippecanoe/LICENSE.md",
                "tippecanoe/CHANGELOG.md"
            ],
            sources: ["tippecanoe"],
            publicHeadersPath: "tippecanoe",
            cxxSettings: [
                .headerSearchPath("tippecanoe"),
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
    cxxLanguageStandard: .cxx11
)
