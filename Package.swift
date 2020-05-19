// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CocoaProgress",
    platforms: [ .iOS(.v11)],
    products: [
        .library(
            name: "CocoaProgress",
            targets: ["CocoaProgress"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "CocoaProgress",
            dependencies: [],
            path: "Sources"),
        .testTarget(
            name: "CocoaProgressTests",
            dependencies: ["CocoaProgress"],
            path: "CocoaProgressTests"),
    ]
)
