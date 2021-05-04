// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CodeGeneration",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "CodeGeneration",
            targets: ["CodeGeneration"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "CodeGeneration",
            dependencies: [],
            exclude: [
                "Sourcery.sh",
                "Templates/AutoInitiable.swifttemplate",
                "Templates/AutoEquatable.stencil"
            ]
        ),
        .testTarget(
            name: "CodeGenerationTests",
            dependencies: ["CodeGeneration"]),
    ]
)
