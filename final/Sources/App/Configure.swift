import Hummingbird
import SotoCore
import SotoDynamoDB

public func configure<Context: RequestContext>(
    router: Router<Context>,
    awsClient: AWSClient,
    dynamoTable: String,
    dynamoEndpoint: String? = nil
) {
    router.get("/hello") { _, _ in "Hello World!" }

    let dynamo = DynamoDB(
        client: awsClient,
        endpoint: dynamoEndpoint
    )

    RunsController(
        tableName: dynamoTable,
        dynamo: dynamo
    )
    .addRoutes(to: router)

    UsersController(
        tableName: dynamoTable,
        dynamo: dynamo
    )
    .addRoutes(to: router)
}
