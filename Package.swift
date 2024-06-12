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
        ),
    ],
    dependencies: [
        // Додайте залежності, якщо потрібно
    ],
    targets: [
        .target(
            name: "tippecanoe-swift",
            dependencies: [],
            path: "Sources",
            exclude: ["../install.sh"],
            sources: [
                "tippecanoe/csv.cpp",
                "tippecanoe/decode.cpp",
                "tippecanoe/dirtiles.cpp",
                "tippecanoe/catch",
                "tippecanoe/jsonpull/jsonpull.c",
                "tippecanoe/milo",
                "tippecanoe/protozero",
                "tippecanoe/mapbox"
            ],
            publicHeadersPath: "tippecanoe",
            cxxSettings: [
                .headerSearchPath("tippecanoe"),
                .headerSearchPath("tippecanoe/catch"),
                .headerSearchPath("tippecanoe/jsonpull"),
                .headerSearchPath("tippecanoe/milo"),
                .headerSearchPath("tippecanoe/protozero"),
                .headerSearchPath("tippecanoe/mapbox"),
                .define("TARGET_OS_IPHONE", to: "1"),
                .unsafeFlags(["-O3", "-w"])
            ],
            linkerSettings: [
                .linkedLibrary("sqlite3"),
                .linkedLibrary("z"),
                .linkedLibrary("c++")
            ]
        )
    ],
    swiftLanguageVersions: [.v5],
    cxxLanguageStandard: .cxx11
)
