// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftlySearch",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "SwiftlySearch",
            targets: ["SwiftlySearch"]
        ),
    ],
    targets: [
        .target(
            name: "SwiftlySearch",
            dependencies: []
        ),
    ]
)
