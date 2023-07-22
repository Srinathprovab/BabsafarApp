

import Foundation
struct Attributes : Codable {
	let transactionId : String?
	let responseTime : String?

	enum CodingKeys: String, CodingKey {

		case transactionId = "TransactionId"
		case responseTime = "ResponseTime"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		transactionId = try values.decodeIfPresent(String.self, forKey: .transactionId)
		responseTime = try values.decodeIfPresent(String.self, forKey: .responseTime)
	}

}
