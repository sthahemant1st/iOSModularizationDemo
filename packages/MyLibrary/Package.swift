// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MyLibrary",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Infrastructure",
            targets: ["Network", "Log", "Extension", "Design", "Coordinator"]
        ),
        .library(
            name: "Core",
            targets: ["Model", "Repository"]
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
            path: "Sources/Feature/Login"
        ),
        // MARK: Core
        .target(
            name: "Model",
            path: "Sources/Core/Model"
        ),
        .target(
            name: "Repository",
            path: "Sources/Core/Repository"
            // dependes on model
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
