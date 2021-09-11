// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Scenes",
    platforms: [.iOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Scenes",
            targets: ["Scenes"]),
    ],
    dependencies: [
        .package(path: "Common"),
        .package(path: "Persistence"),
        .package(path: "DesignSystem"),
        .package(path: "NetworkLayer")
        
    ],
    targets: [
        .target(
            name: "Scenes",
            dependencies: [
                "DesignSystem",
                "Persistence",
            ]
        ),
        .testTarget(
            name: "ScenesTests",
            dependencies: [
                "Scenes",
                "Common",
                "Persistence",
                "DesignSystem",
                "NetworkLayer"
            ]
        ),
    ]
)
