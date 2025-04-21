import Foundation
import Noora
import Rainbow

@MainActor func sleepTask(_ seconds: TimeInterval) -> @Sendable ((String) -> Void) async throws -> Void {
    { _ in
        try await Task.sleep(for: .milliseconds(seconds * 1000))
    }
}

@main
struct Agenda {
    static let sections: [(String, TimeInterval)] = [
        ("Hummingbird 2".bold, 4),
        ("Why Serverless?".bold, 4),
        ("DynamoDB".bold + ": basic concepts and running locally", 5),
        ("Sample Project".bold + ": Running tracker app", 5),
        ("Adding a Lambda executable target", 5),
        ("Deploying with SwiftCloud", 4),
    ]

    static func main() async throws {
        print("--- AGENDA ---\n".bold)

        let theme = Theme(
            primary: "FFA500",
            secondary: "FF4081",
            muted: "505050",
            accent: "AC6115",
            danger: "FF2929",
            success: "56822B"
        )

        let noora = Noora(theme: theme)

        for (index, section) in sections.enumerated() {
            try await noora.progressStep(message: "\(index + 1). \(section.0)", task: sleepTask(section.1))
            print("")
        }
    }
}
