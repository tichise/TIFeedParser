// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "TIFeedParser",
    platforms: [.iOS(.v10),
                .watchOS(.v3)],
    products: [
        .library(name: "TIFeedParser", targets: ["TIFeedParser"])
    ],
    dependencies: [],
    targets: [
        .target(name: "TIFeedParser", path: "Sources"),
    ],
    swiftLanguageVersions: [.v5]
)
