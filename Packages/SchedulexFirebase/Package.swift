// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SchedulexFirebase",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "SchedulexFirebase",
            targets: ["SchedulexFirebase"]),
    ],
    dependencies: [
        .package(name: "Domain", path: "../Domain"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "SchedulexFirebase",
            dependencies: ["Domain"]),
        .testTarget(
            name: "SchedulexFirebaseTests",
            dependencies: ["SchedulexFirebase"]),
    ]
)
