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
    dependencies: [
        .package(url: "https://github.com/tadija/AEXML.git", from: "4.6.1"),
        .package(url: "https://github.com/malcommac/SwiftDate", from: "7.0.0"),
    ],
    targets: [
        .target(name: "TIFeedParser", dependencies: ["AEXML", "SwiftDate"], path: "Sources"),
        
    ],
    swiftLanguageVersions: [.v5]
)
