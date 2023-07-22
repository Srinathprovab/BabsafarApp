
import Foundation
struct Flight_data : Codable {
    let summary : [Summary]?
    let transaction : Transaction?

    enum CodingKeys: String, CodingKey {

        case summary = "summary"
        case transaction = "transaction"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        summary = try values.decodeIfPresent([Summary].self, forKey: .summary)
        transaction = try values.decodeIfPresent(Transaction.self, forKey: .transaction)
    }

}
