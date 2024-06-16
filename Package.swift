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
        .library(
            name: "LibNFCSwiftAsync",
            targets: ["LibNFCSwiftAsync"]),
    ],
    targets: [
        .target(
            name: "LibNFCSwift",
            dependencies: ["libnfc", "nfc-swift"]
            ),
        .testTarget(
            name: "LibNFCSwiftTests",
            dependencies: ["LibNFCSwift"]),
        .target(
            name: "LibNFCSwiftAsync",
            dependencies: ["LibNFCSwift"]
            ),
        .testTarget(
            name: "LibNFCSwiftAsyncTests",
            dependencies: ["LibNFCSwiftAsync"]),
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
