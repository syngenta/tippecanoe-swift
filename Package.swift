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
            dependencies: ["tippecanoe"],
            path: "Sources/Swift"
        ),
        .target(
            name: "tippecanoe",
            dependencies: [],
            path: "Sources",
            sources: [
                "tippecanoe",
                "Bindings"
            ],
            cxxSettings: [
                .headerSearchPath("Sources/tippecanoe"),
                .headerSearchPath("Sources/tippecanoe/catch"),
                .headerSearchPath("Sources/tippecanoe/jsonpull"),
                .headerSearchPath("Sources/tippecanoe/milo"),
                .headerSearchPath("Sources/tippecanoe/protozero"),
                .headerSearchPath("Sources/tippecanoe/mapbox"),
                .headerSearchPath("Sources/Bindings"),
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
