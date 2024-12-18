// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MyLibrary",
    platforms: [.iOS(.v15), .macOS(.v12)],
    products: [
        .library(
            name: "Infrastructure",
            targets: ["APIClient", "CommonInfrastructure", "UserDefaultsService"]
        ),
        .library(
            name: "Core",
            targets: ["Model", "Repository", "UseCase", "PersistanceManager"]
        ),
        .library(
            name: "Feature",
            targets: ["Login", "Register", "Dashboard"]
        ),
    ],
    targets: [
        // MARK: Feature
        .target(
            name: "Login",
            dependencies: ["UseCase", "CommonInfrastructure"],
            path: "Sources/Feature/Login"
        ),
        .target(
            name: "Register",
            dependencies: ["UseCase", "CommonInfrastructure"],
            path: "Sources/Feature/Register"
        ),
        .target(
            name: "Dashboard",
            dependencies: ["UseCase", "CommonInfrastructure"],
            path: "Sources/Feature/Dashboard"
        ),
        // MARK: Core
        .target(
            name: "Model",
            path: "Sources/Core/Model"
        ),
        .target(
            name: "Repository",
            dependencies: ["Model", "APIClient"],
            path: "Sources/Core/Repository"
        ),
        .target(
            name: "UseCase",
            dependencies: ["Repository"],
            path: "Sources/Core/UseCase"
        ),
        .target(
            name: "PersistanceManager",
            dependencies: ["Model", "UserDefaultsService"],
            path: "Sources/Core/PersistanceManager"
        ),
        // MARK: Infrastructure
        .target(
            name: "APIClient",
            path: "Sources/Infrastructure/APIClient"
        ),
        .target(
            name: "CommonInfrastructure",
            path: "Sources/Infrastructure/Common"
        ),
        .target(
            name: "UserDefaultsService",
            path: "Sources/Infrastructure/UserDefaultsService"
        ),
//        .target(
//            name: "Infrastructure"
//        ),
        // MARK: - Test
        .testTarget(
            name: "APIClientTests",
            dependencies: ["APIClient"]
        ),
    ]
)
