// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DesignSystem",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "DesignSystem",
            targets: ["DesignSystem"]
        ),
    ],
    dependencies: [
        .package(
            name: "SnapshotTesting",
            url: "https://github.com/pointfreeco/swift-snapshot-testing",
            from: "1.9.0"
        ),
        .package(
            name: "SDWebImage",
            url: "https://github.com/SDWebImage/SDWebImage.git",
            from: "5.1.0"
        ),
        .package(path: "Common"),
        .package(path: "CodeGeneration")
    ],
    targets: [
        .target(
            name: "DesignSystem",
            dependencies: [
                "Common",
                "SDWebImage"
                //"CodeGeneration" TODO: Figure out how to make it work
            ]
        ),
        .testTarget(
            name: "DesignSystemTests",
            dependencies: [
                "DesignSystem",
                "SnapshotTesting"
            ]
        ),
    ]
)
