// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NetworkLayer",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "NetworkLayer",
            targets: ["NetworkLayer"]),
    ],
    dependencies: [
        .package(path: "Common")
    ],
    targets: [
        .target(
            name: "NetworkLayer",
            dependencies: []),
        .testTarget(
            name: "NetworkLayerTests",
            dependencies: [
                "NetworkLayer",
                "Common"
            ]
        ),
    ]
)
