// swift-tools-version:6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SpearDates",
    platforms: [
        .iOS(.v26),
        .macOS(.v26),
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "SpearDates",
            targets: ["SpearDates"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/kraigspear/Spearfoundation.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "SpearDates",
            dependencies: [
                .product(name: "SpearFoundation", package: "Spearfoundation"),
            ]
        ),
        .testTarget(
            name: "SpearDatesTests",
            dependencies: ["SpearDates"]
        ),
    ]
)
