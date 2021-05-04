// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "Modules",
            targets: [
                "Modules"
            ]
        ),
    ],
    dependencies: [
        .package(
            name: "KeychainSwift",
            url: "https://github.com/evgenyneu/keychain-swift",
            from: "19.0.0"
        ),
        .package(
            name: "SnapshotTesting",
            url: "https://github.com/pointfreeco/swift-snapshot-testing",
            from: "1.9.0"
        )
    ],
    targets: [
        
        .target(
            name: "Modules",
            dependencies: [
                "Scenes"
            ]),
        .testTarget(
            name: "ModulesTests",
            dependencies: ["Modules"]
        ),
        
        .target(
            name: "Network",
            dependencies: ["Common"]
        ),
        
        .target(
            name: "DesignSystem",
            dependencies: ["Common"]
        ),
        .testTarget(
            name: "DesignSystemTests",
            dependencies: ["SnapshotTesting"]
        ),
        
        .target(
            name: "Persistence",
            dependencies: ["KeychainSwift", "Common"]
        ),
        
        .target(
            name: "Common",
            dependencies: []
        ),
        
        .target(
            name: "Scenes",
            dependencies: ["Common", "Persistence", "Network", "DesignSystem"]
        ),
        
    ]
)
