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

        .package(url: "https://github.com/hummingbird-project/hummingbird-lambda.git", from: "2.0.0-rc.4"),
        .package(url: "https://github.com/swift-server/swift-aws-lambda-events", from: "1.0.0"),
        .package(url: "https://github.com/swift-server/swift-aws-lambda-runtime", exact: "1.0.0-alpha.3"),

        .package(url: "https://github.com/swift-cloud/swift-cloud.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "App",
            dependencies: [
                .product(name: "Hummingbird", package: "hummingbird"),
                .product(name: "ULID", package: "ULID.swift"),
                .product(name: "SotoDynamoDB", package: "soto"),
            ]
        ),
        .executableTarget(
            name: "LocalServer",
            dependencies: [
                .product(name: "Hummingbird", package: "hummingbird"),
                .product(name: "SotoCore", package: "soto-core"),
                .target(name: "App")
            ]
        ),
        .executableTarget(
            name: "Lambda",
            dependencies: [
                .product(name: "HummingbirdLambda", package: "hummingbird-lambda"),
                .product(name: "CloudSDK", package: "swift-cloud"),
                .product(name: "AWSLambdaEvents", package: "swift-aws-lambda-events"),
                .target(name: "App")
            ]
        ),
        .executableTarget(
            name: "Infra",
            dependencies: [
                .product(name: "CloudAWS", package: "swift-cloud"),
            ]
        ),
    ]
)
