import CloudAWS

@main
struct Infra: AWSProject {
    func build() async throws -> Outputs {
        // Configure name and primary index
        // If you have secondary indexes, configure
        let dynamo = AWS.DynamoDB(
            "RunTrackerTable",
            primaryIndex: .init(
                partitionKey: ("pk", .string),
                sortKey: ("sk", .string)
            )
        )

        // Configure name, target name & memory
        // Also, enable URL.
        let lambda = AWS.Function(
            "RunTrackerLambda",
            targetName: "Lambda",
            url: .enabled(),
            memory: 1024
        )

        lambda.link(dynamo)

        return [
            "Lambda URL": lambda.url,
            "DynamoDB Table": dynamo.name,
        ]
    }
}
