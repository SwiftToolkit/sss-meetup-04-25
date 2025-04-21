// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "agenda",
    platforms: [
        .macOS(.v13)
    ],
    dependencies: [
        .package(url: "https://github.com/onevcat/Rainbow", from: "4.1.0"),
        .package(url: "https://github.com/natanrolnik/noora", branch: "inverted-colors-progress-step")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "talk-agenda",
            dependencies: [
                .product(name: "Rainbow", package: "Rainbow"),
                .product(name: "Noora", package: "noora"),
            ],
        ),
    ]
)
