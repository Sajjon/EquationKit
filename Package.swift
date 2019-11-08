// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "EquationKit",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "EquationKit",
            targets: ["EquationKit"]),

        .library(
            name: "EquationKitBigIntSupport",
            targets: ["EquationKitBigIntSupport"]),


        .library(
            name: "EquationKitBigIntOperators",
            targets: ["EquationKitBigIntOperators"]),


        .library(
            name: "EquationKitDoubleSupport",
            targets: ["EquationKitDoubleSupport"]),

        
        .library(
            name: "EquationKitDoubleOperators",
            targets: ["EquationKitDoubleOperators"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/attaswift/BigInt", from: "5.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "EquationKit",
            dependencies: ["BigInt"]),

        .target(
            name: "EquationKitBigIntOperators",
            dependencies: ["EquationKit"],
            path: "Sources/EquationKitSupportBigInt/Operators"),

        .target(
            name: "EquationKitBigIntVariables",
            dependencies: ["EquationKitBigIntOperators"],
            path: "Sources/EquationKitSupportBigInt/Variables"),

        .target(
            name: "EquationKitBigIntSupport",
            dependencies: ["EquationKitBigIntOperators", "EquationKitBigIntVariables"],
            path: "Sources/EquationKitSupportBigInt",
            exclude: ["Operators", "Variables"]
        ),
        
        .target(
            name: "EquationKitDoubleOperators",
            dependencies: ["EquationKit"],
            path: "Sources/EquationKitSupportDouble/Operators"),

        .target(
            name: "EquationKitDoubleVariables",
            dependencies: ["EquationKit"],
            path: "Sources/EquationKitSupportDouble/Variables"),

        .target(
            name: "EquationKitDoubleSupport",
            dependencies: ["EquationKitDoubleOperators", "EquationKitDoubleVariables"],
            path: "Sources/EquationKitSupportDouble",
            exclude: ["Operators", "Variables"]
        ),

        .testTarget(
            name: "EquationKitSupportBigIntTests",
            dependencies: ["EquationKitBigIntSupport"]),

          .testTarget(
            name: "EquationKitSupportDoubleTests",
            dependencies: ["EquationKitDoubleSupport"]),
    ]
)
