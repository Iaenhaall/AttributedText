// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "AttributedText",
    platforms: [.iOS(.v13), .macOS(.v11), .tvOS(.v14), .watchOS(.v7)],
    products: [
        .library(
            name: "AttributedText",
            targets: ["AttributedText"]),
    ],
    targets: [
        .target(
            name: "AttributedText",
            dependencies: []),
        .testTarget(
            name: "AttributedTextTests",
            dependencies: ["AttributedText"]),
    ]
)
