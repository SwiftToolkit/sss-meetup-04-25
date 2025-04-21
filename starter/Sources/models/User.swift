import Foundation
import Hummingbird

struct User: Codable, ResponseCodable {
    let pk: String
    let sk: String
    let id: UUID
    let username: String

    init(id: UUID = UUID(), username: String) {
        self.pk = "USER#\(id)"
        self.sk = "PROFILE"
        self.id = id
        self.username = username
    }
}
