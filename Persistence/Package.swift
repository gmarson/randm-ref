// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Persistence",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "Persistence",
            targets: ["Persistence"]),
    ],
    dependencies: [
        .package(
            name: "KeychainSwift",
            url: "https://github.com/evgenyneu/keychain-swift",
            from: "19.0.0"
        ),
        .package(path: "Common")
    ],
    targets: [
        .target(
            name: "Persistence",
            dependencies: [
                "KeychainSwift",
                "Common"
            ]
        ),
        .testTarget(
            name: "PersistenceTests",
            dependencies: ["Persistence"]),
    ]
)
