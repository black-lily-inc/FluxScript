// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FluxScript",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "FluxScript",
            targets: ["FluxScript"]),
        .executable(
            name: "fluxscript",
            targets: ["FluxScriptCLI"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "FluxScript"),
        .executableTarget(
            name: "FluxScriptCLI",
            dependencies: ["FluxScript"]),
        .testTarget(
            name: "FluxScriptTests",
            dependencies: ["FluxScript"]
        ),
    ]
)
