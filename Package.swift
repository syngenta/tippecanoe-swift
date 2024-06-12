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
                "tippecanoe/catch",
                "tippecanoe/jsonpull",
                "tippecanoe/milo",
                "tippecanoe/protozero",
                "tippecanoe/mapbox"
            ],
            publicHeadersPath: "tippecanoe",
            cSettings: [
                .headerSearchPath("tippecanoe"),
                .define("TARGET_OS_IPHONE", to: "1"),
                .unsafeFlags(["-O3", "-w"])
            ],
            cxxSettings: [
                .headerSearchPath("tippecanoe"),
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
    swiftLanguageVersions: [.v5]
)
