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
        .executable(
            name: "prettyprint",
            targets: ["ASTPrinter"]
        ),
    ],
    dependencies: [
        .package(path: "../Tokenizer")
    ],
    targets: [
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
        .executableTarget(
            name: "ASTPrinter",
            dependencies: ["AST", "Tokenizer"],
        ),
    ]
)
