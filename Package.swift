// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LibNFCSwift",
    platforms: [.macCatalyst(.v17), .macOS(.v10_15)],
    products: [
        .library(
            name: "LibNFCSwift",
            targets: ["LibNFCSwift"]),
    ],
    targets: [
        .target(
            name: "LibNFCSwift",
            dependencies: ["libnfc", "nfc-swift"],
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency")
              ]
            ),
        .testTarget(
            name: "LibNFCSwiftTests",
            dependencies: ["LibNFCSwift"]),
        .target(
            name: "nfc-swift",
            dependencies: ["libnfc"]
            ),
        .systemLibrary(
            name: "libnfc",
            pkgConfig: "libnfc",
            providers: [
                .brew(["libnfc"])
            ]
        ),
    ]
)
