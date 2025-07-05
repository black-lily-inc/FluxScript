// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FluxScript",
    platforms: [
        .macOS(.v10_13)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "FluxScript",
            targets: ["FluxScript"]
        ),
        .executable(
            name: "fluxscript",
            targets: ["FluxScriptCLI"]
        ),
        .executable(
            name: "GenerateAST",
            targets: ["GenerateAST"]
        ),
    ],
    dependencies: [
        .package(path: "../Tokenizer"),
        .package(path: "../AST")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "FluxScript",
            dependencies: [
                .product(name: "Tokenizer", package: "Tokenizer"),
                .product(name: "AST", package: "AST")
            ]
        ),
        .executableTarget(
            name: "FluxScriptCLI",
            dependencies: ["FluxScript"]
        ),
        .executableTarget(
            name: "GenerateAST",
            dependencies: []
        ),
        .testTarget(
            name: "FluxScriptTests",
            dependencies: ["FluxScript"]
        ),
    ]
)
