// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SchedulexFirebase",
    platforms: [.iOS(.v16)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "SchedulexFirebase",
            targets: ["SchedulexFirebase"]
        )
    ],
    dependencies: [
        .package(name: "Domain", path: "../Domain"),
        .package(name: "Firebase", url: "https://github.com/firebase/firebase-ios-sdk", from: Version(10, 0, 0))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "SchedulexFirebase",
            dependencies: [
                "Domain",
                .product(name: "FirebaseFirestore", package: "Firebase"),
                .product(name: "FirebaseFirestoreSwift", package: "Firebase")
            ]
        ),
        .testTarget(
            name: "SchedulexFirebaseTests",
            dependencies: ["SchedulexFirebase"]
        )
    ]
)
