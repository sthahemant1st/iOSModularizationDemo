// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MyLibrary",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Infrastructure",
            targets: ["Network", "Log", "Extension", "Design", "Coordinator"]
        ),
        .library(
            name: "Core",
            targets: ["Model", "Repository", "UseCase"]
        ),
        .library(
            name: "Login",
            targets: ["Login"]
        )
    ],
    targets: [
        // MARK: Feature
        .target(
            name: "Login",
            dependencies: ["UseCase", "Coordinator", "Design", "Extension"],
            path: "Sources/Feature/Login"
        ),
        // MARK: Core
        .target(
            name: "Model",
            path: "Sources/Core/Model"
        ),
        .target(
            name: "Repository",
            dependencies: ["Model"],
            path: "Sources/Core/Repository"
        ),
        .target(
            name: "UseCase",
            dependencies: ["Repository"],
            path: "Sources/Core/UseCase"
        ),
        // MARK: Infrastructure
        .target(
            name: "Network",
            path: "Sources/Infrastructure/Network"
        ),
        .target(
            name: "Log",
            path: "Sources/Infrastructure/Log"
        ),
        .target(
            name: "Extension",
            path: "Sources/Infrastructure/Extension"
        ),
        .target(
            name: "Design",
            path: "Sources/Infrastructure/Design"
        ),
        .target(
            name: "Coordinator",
            path: "Sources/Infrastructure/Coordinator"
        ),
        .testTarget(
            name: "MyLibraryTests",
            dependencies: ["Model"]
        ),
    ]
)
