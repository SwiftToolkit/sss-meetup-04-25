import Foundation
import Hummingbird
import SotoCore
import App

@main
struct Server {
    static let awsClient = {
        #if DEBUG
        return AWSClient(credentialProvider: .static(
            accessKeyId: "ko7fe8",
            secretAccessKey: "tbg3ls"
        ))
        #else
        return AWSClient()
        #endif
    }()

    static func main() async throws {
        let router = Router()

        configure(
            router: router,
            awsClient: awsClient,
            dynamoTable: "running-tracker",
            dynamoEndpoint: "http://localhost:8000"
        )

        try await Application(
            router: router,
            configuration: .init(
                address: .hostname("127.0.0.1", port: 8080),
                serverName: "RunningTracker-server"
            )
        )
        .runService()

        try await awsClient.shutdown()
    }
}
