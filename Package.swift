// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "random-swift",
    products: [
        .library(
            name: "Random",
            targets: ["Random"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-nio", from: "2.0.0"),
        .package(url: "https://github.com/apple/swift-nio-ssl", from: "2.0.0"),
    ],
    targets: [
        .target(
            name: "Random",
            dependencies: [
                .product(name: "NIO", package: "swift-nio"),
                .product(name: "NIOSSL", package: "swift-nio-ssl"),
            ]),
        .testTarget(
            name: "RandomTests",
            dependencies: [
                .target(name:"Random"),
                .product(name: "NIO", package: "swift-nio"),
            ]
        ),
    ]
)
