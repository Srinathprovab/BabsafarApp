

import Foundation
struct Api_fares : Codable {
	let currency : String?
	let premiumAmount : String?
	let base_fare : Double?
	let tax : Int?
	let markup : Markup?
	let total_fare : Double?

	enum CodingKeys: String, CodingKey {

		case currency = "currency"
		case premiumAmount = "premiumAmount"
		case base_fare = "base_fare"
		case tax = "tax"
		case markup = "markup"
		case total_fare = "total_fare"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		currency = try values.decodeIfPresent(String.self, forKey: .currency)
		premiumAmount = try values.decodeIfPresent(String.self, forKey: .premiumAmount)
		base_fare = try values.decodeIfPresent(Double.self, forKey: .base_fare)
		tax = try values.decodeIfPresent(Int.self, forKey: .tax)
		markup = try values.decodeIfPresent(Markup.self, forKey: .markup)
		total_fare = try values.decodeIfPresent(Double.self, forKey: .total_fare)
	}

}
