// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ragnarok-remote-client",
    platforms: [
       .macOS(.v13),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.115.0"),
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.65.0"),
        .package(url: "https://github.com/arkadeleon/ragnarok-grf", branch: "master"),
    ],
    targets: [
        .executableTarget(
            name: "RagnarokRemoteClient",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "NIOCore", package: "swift-nio"),
                .product(name: "NIOPosix", package: "swift-nio"),
                .product(name: "RagnarokGRF", package: "ragnarok-grf"),
            ],
            swiftSettings: [
                .enableUpcomingFeature("ExistentialAny"),
            ]
        ),
        .testTarget(
            name: "RagnarokRemoteClientTests",
            dependencies: [
                .target(name: "RagnarokRemoteClient"),
                .product(name: "VaporTesting", package: "vapor"),
            ],
            swiftSettings: [
                .enableUpcomingFeature("ExistentialAny"),
            ]
        )
    ]
)
