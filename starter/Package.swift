// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "running-tracker",
    platforms: [
        .macOS(.v14)
    ],
    dependencies: [
        .package(url: "https://github.com/hummingbird-project/hummingbird.git", from: "2.10.0"),
        .package(url: "https://github.com/soto-project/soto.git", from: "7.0.0"),
        .package(url: "https://github.com/soto-project/soto-core.git", from: "7.0.0"),
        .package(url: "https://github.com/yaslab/ULID.swift", from: "1.3.1"),
    ],
    targets: [
        .executableTarget(
            name: "server",
            dependencies: [
                .product(name: "Hummingbird", package: "hummingbird"),
                .product(name: "ULID", package: "ULID.swift"),
                .product(name: "SotoDynamoDB", package: "soto"),
            ]
        ),
    ]
)
