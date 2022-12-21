// swift-tools-version:5.4
import PackageDescription

let package = Package(
    name: "TIFeedParser",
    platforms: [.iOS(.v14),
                .watchOS(.v5)],
    products: [
        .library(name: "TIFeedParser", targets: ["TIFeedParser"])
    ],
    dependencies: [
        .package(url: "https://github.com/tadija/AEXML.git", from: "4.6.1"),
        .package(url: "https://github.com/malcommac/SwiftDate.git", from: "7.0.0"),
    ],
    targets: [
        .target(name: "TIFeedParser", dependencies: ["AEXML", "SwiftDate"], path: "Sources"),
        
    ],
    swiftLanguageVersions: [.v5]
)
