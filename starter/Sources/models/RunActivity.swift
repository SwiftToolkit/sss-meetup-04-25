import Foundation
import Hummingbird
import ULID

struct RunActivity: Codable, ResponseCodable {
    let pk: String
    let sk: String
    let id: ULID
    let startDate: Date
    let duration: TimeInterval
    let distanceInMeters: Int

    init(
        userId: UUID,
        id: ULID = ULID(),
        startDate: Date,
        duration: TimeInterval,
        distanceInMeters: Int
    ) {
        self.pk = "USER#\(userId)"
        self.sk = "RUN#\(id)"
        self.id = id
        self.startDate = startDate
        self.duration = duration
        self.distanceInMeters = distanceInMeters
    }
}

