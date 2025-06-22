// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AST",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "AST",
            targets: ["AST"]
        ),
    ],
    dependencies: [
        .package(path: "../Tokenizer")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "AST",
            dependencies: [
                .product(name: "Tokenizer", package: "Tokenizer")
            ]
        ),
        .testTarget(
            name: "ASTTests",
            dependencies: ["AST"]
        ),
    ]
)
