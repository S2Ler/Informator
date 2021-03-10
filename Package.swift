// swift-tools-version:5.3

import PackageDescription

let package = Package(
  name: "Informator",
  platforms: [
    .macOS(.v10_12),
    .iOS(.v10),
    .tvOS(.v10)
  ],
  products: [
    .library(
      name: "Informator",
      targets: ["Informator"]
    ),
  ],
  targets: [
    .target(
      name: "Informator",
      dependencies: []
    ),
    .testTarget(
      name: "InformatorTests",
      dependencies: ["Informator"]
    ),
  ],
  swiftLanguageVersions: [.v5]
)
