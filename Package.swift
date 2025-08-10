// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription



let package_dependencies: [Package.Dependency] = [
    .package(url: "https://github.com/kv-swift/PySwiftKit", from: .init(311, 0, 0)),
    .package(url: "https://github.com/py-swift/PyFileGenerator", from: .init(0, 0, 1)),
    // add other packages
    .package(url: "https://github.com/googleads/swift-package-manager-google-mobile-ads", exact: .init(11, 5, 0))
]



let package_targets: [Target] = [
    .target(
        name: "a4k_pyswift",
        dependencies: [
            .product(name: "SwiftonizeModules", package: "PySwiftKit"),
            // add other package products or internal targets
            .product(name: "GoogleMobileAds", package: "swift-package-manager-google-mobile-ads"),
        ],
        resources: [

        ]
    )
]



let package = Package(
    name: "a4k_pyswift",
    platforms: [
        .iOS(.v13),
        .macOS(.v11)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "a4k_pyswift",
            targets: ["a4k_pyswift"]),
    ],
    dependencies: package_dependencies,
    targets: package_targets
)
