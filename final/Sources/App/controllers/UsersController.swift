import Hummingbird
import SotoDynamoDB

struct UsersController<Context: RequestContext>: Sendable {
    let tableName: String
    let dynamo: DynamoDB

    func addRoutes(to router: Router<Context>) {
        router
            .group("users")
            .post(use: create)
            .get(":id", use: getUser)
            .get(":id/runs", use: listRuns)
    }

    private func create(
        request: Request,
        context: Context
    ) async throws -> User {
        let createUserRequest = try await request.decode(
            as: CreateUserRequest.self,
            context: context
        )

        let username = createUserRequest.username
        let user = User(username: username)

        // In a real application, enforce uniqueness on username
        // One (bad) approach is to look for the username in the table
        // A better approach is to use another entity whose sk is the
        // username, and link writing both in a single transaction, with
        // a condition to check if it exists.

        let putItemInput = DynamoDB.PutItemCodableInput(
            item: user,
            tableName: tableName
        )

        _ = try await dynamo.putItem(putItemInput)

        return user
    }

    private func getUser(
        request: Request,
        context: Context
    ) async throws -> User {
        let id = try context.parameters.require("id", as: String.self)

        let userQuery = DynamoDB.QueryInput(
            expressionAttributeValues: [":pk": .s("USER#\(id)")],
            keyConditionExpression: "pk = :pk",
            limit: 1,
            tableName: tableName
        )

        let response = try await dynamo.query(userQuery, type: User.self)

        guard let user = response.items?.first else {
            throw HTTPError(.notFound, message: "User \(id) not found")
        }
        
        return user
    }

    private func listRuns(
        request: Request,
        context: Context
    ) async throws -> ListRunsResponse {
        let userId = try context.parameters.require("id", as: String.self)

        // In a real world scenario, perform authorization here

        let queryInput = DynamoDB.QueryInput(
            expressionAttributeValues: [
                ":pk": .s("USER#\(userId)"),
                ":skPrefix": .s("RUN#")
            ],
            keyConditionExpression: "pk = :pk and begins_with(sk, :skPrefix)",
            tableName: tableName
        )

        let response = try await dynamo.query(
            queryInput,
            type: RunActivity.self
        )

        return ListRunsResponse(runs: response.items ?? [])
    }
}

private struct CreateUserRequest: Decodable {
    let username: String
}

private struct ListRunsResponse: ResponseEncodable {
    let runs: [RunActivity]
}
