# Serverless Swift with Hummingbird and DynamoDB

This repo contains the source code for the sample project and links of the talk, given at the [4th Swift Server Meetup](https://www.youtube.com/live/Kis9rrtsnwM).

## Sample Code

The **starter** directory contains the local Hummingbird server, with the missing `/users/:id/runs` implementation.

The **final** directory contains the code for both local server and lambda executables, the shared app logic target, and the SwiftCloud Infra target.

In the **agenda** directory you can find the CLI built to represent the agenda of the talk.

## Resources & Links

### Hummingbird

* [Website](https://hummingbird.codes)
* [Docs](https://docs.hummingbird.codes)
* [Examples](https://github.com/hummingbird-project/hummingbird-examples)
* [Hummingbird Lambda](https://github.com/hummingbird-project/hummingbird-lambda)

### DynamoDB

* [DynamoDB Guide](https://www.dynamodbguide.com)
* Talk at AWS re:Invent 2023 - [Data modeling core concepts for Amazon DynamoDB (DAT329)](https://www.youtube.com/watch?v=l-Urbf4BaWg)
* Talk at AWS re:Invent 2018 - [Amazon DynamoDB Deep Dive: Advanced Design Patterns for DynamoDB (DAT401)](https://www.youtube.com/watch?v=HaEPXoXVf2k)
* [NoSQL Workbench](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/workbench.html) and [Download](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/workbench.settingup.html)

### SwiftCloud

* [GitHub Repo](https://github.com/swift-cloud/swift-cloud)