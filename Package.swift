// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CIDAFIF",
    platforms: [.iOS(.v13),
                .macOS(.v10_15)],
    products: [.library(name: "CIDAFIF", targets: ["CIDAFIF"])],
    dependencies: [.package(url: "https://github.com/Cenith-Innovations/Zip", .upToNextMajor(from: "1.0.0"))],
    targets: [.target(name: "CIDAFIF", dependencies: ["Zip"], resources: [.process("DAFIF_CoreData.xcdatamodeld")]),
              .testTarget(name: "CIDAFIFTests",dependencies: ["CIDAFIF"])]
)
