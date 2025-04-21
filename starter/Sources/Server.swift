import Foundation
import Hummingbird
import SotoCore

@main
struct Server {
    static func main() async throws {
        let router = Router()

        #if DEBUG
        let awsClient = AWSClient(credentialProvider: .static(
            accessKeyId: "ko7fe8",
            secretAccessKey: "tbg3ls"
        ))
        #else
        let awsClient = AWSClient()
        #endif

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
