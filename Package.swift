// swift-tools-version:5.6

import PackageDescription

let package = Package(
  name: "swift-informator",
  platforms: [
    .macOS(.v10_15),
    .iOS(.v13),
    .tvOS(.v13),
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
