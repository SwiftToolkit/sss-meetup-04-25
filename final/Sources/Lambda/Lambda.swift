import AWSLambdaRuntime
import AWSLambdaEvents
import CloudSDK
import HummingbirdLambda
import App
import SotoCore

@main
struct Lambda: APIGatewayV2LambdaFunction {
    typealias Context = BasicLambdaRequestContext<APIGatewayV2Request>
    private let tableName: String
    private let awsClient: AWSClient

    init(context: LambdaInitializationContext) async throws {
        tableName = Cloud.Resource.RunTrackerTable.name
        awsClient = AWSClient()
    }

    func buildResponder() -> some HTTPResponder<Context> {
        let router = Router(context: Context.self)
        configure(router: router, awsClient: awsClient, dynamoTable: tableName)
        return router.buildResponder()
    }
}
