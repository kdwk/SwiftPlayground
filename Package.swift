// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftPlayground",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .executable(name: "SwiftPlayground", targets: ["SwiftPlayground"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-collections.git", .upToNextMajor(from: "1.1.3")),
    ],
    
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(name: "SwiftPlayground", dependencies: [.product(name: "Collections", package: "swift-collections")], swiftSettings: [.enableUpcomingFeature("StrictConcurrency")], linkerSettings: [.linkedLibrary("m", .when(platforms: [.linux, .android]))]),
        .testTarget(
            name: "SwiftPlaygroundTests",
            dependencies: ["SwiftPlayground"]),
    ]
)
