// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "TIFeedParser",
    platforms: [.iOS(.v17),
                .watchOS(.v10)],
    products: [
        .library(name: "TIFeedParser", targets: ["TIFeedParser"])
    ],
    dependencies: [
        .package(url: "https://github.com/tadija/AEXML.git", from: "4.7.3"),
        .package(url: "https://github.com/malcommac/SwiftDate.git", from: "7.0.0"),
    ],
    targets: [
        .target(name: "TIFeedParser", dependencies: ["AEXML", "SwiftDate"], path: "Sources"),
        
    ],
    swiftLanguageVersions: [.v5]
)
