

import Foundation
struct Pre_booking_cancellation_policy : Codable {
	let from_time : String?
	let from : String?
	let amount : String?
	let currency : String?

	enum CodingKeys: String, CodingKey {

		case from_time = "from_time"
		case from = "from"
		case amount = "amount"
		case currency = "currency"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		from_time = try values.decodeIfPresent(String.self, forKey: .from_time)
		from = try values.decodeIfPresent(String.self, forKey: .from)
		amount = try values.decodeIfPresent(String.self, forKey: .amount)
		currency = try values.decodeIfPresent(String.self, forKey: .currency)
	}

}
