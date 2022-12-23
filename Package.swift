// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Github-Client-TCA",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(name: "Domain", targets: ["Domain"]),
        .library(name: "Presentation", targets: ["Presentation"]),
        .library(name: "Infrastructure", targets: ["Infrastructure"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.47.2")
    ],
    targets: [
        .target(
            name: "Domain"
        ),
        .target(
            name: "Presentation",
            dependencies: [
                "Domain",
                "Infrastructure",
                .product(name: "Dependencies", package: "swift-composable-architecture"),
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .target(
            name: "Infrastructure",
            dependencies: [
                "Domain",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
    ]
)
