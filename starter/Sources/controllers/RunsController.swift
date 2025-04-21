import Foundation
import Hummingbird
import SotoDynamoDB
import ULID

struct RunsController<Context: RequestContext>: Sendable {
    let tableName: String
    let dynamo: DynamoDB

    func addRoutes(to router: Router<Context>) {
        router
            .group("runs")
            .post(use: create)
    }

    private func create(
        request: Request,
        context: Context
    ) async throws -> RunActivity {
        let createRunRequest = try await request.decode(
            as: CreateRunRequest.self,
            context: context
        )

        // In a real world application, the user id should be
        // derived from the authentication token used to perform
        // the request

        let runActivity = RunActivity(
            userId: createRunRequest.userId,
            startDate: createRunRequest.startDate,
            duration: createRunRequest.duration,
            distanceInMeters: createRunRequest.distanceInMeters
        )

        let putItemInput = DynamoDB.PutItemCodableInput(
            item: runActivity,
            tableName: tableName
        )

        _ = try await dynamo.putItem(putItemInput)

        return runActivity
    }
}

private struct CreateRunRequest: Decodable {
    // In a real world application, the user id should be
    // derived from the authentication token used to perform
    // the request
    let userId: UUID

    let startDate: Date
    let duration: TimeInterval
    let distanceInMeters: Int
}
