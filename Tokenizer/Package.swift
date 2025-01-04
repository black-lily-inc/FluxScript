// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Tokenizer",
    platforms: [
        .macOS(.v15),
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "Tokenizer",
            targets: ["Tokenizer"]),
        .executable(
            name: "TokenizerApp",
            targets: ["TokenizerApp"]),
    ],
    targets: [
        .target(
            name: "Tokenizer"),
        .executableTarget(
            name: "TokenizerApp",
            dependencies: ["Tokenizer"]),
        .testTarget(
            name: "TokenizerTests",
            dependencies: ["Tokenizer"]
        ),
    ]
)
