
import Foundation
struct PriceDetails : Codable {
	let api_currency : String?
	let api_total_fare : String?
	let api_total_tax : String?
	let sub_total : String?
	let grand_total : String?

	enum CodingKeys: String, CodingKey {

		case api_currency = "api_currency"
		case api_total_fare = "api_total_fare"
		case api_total_tax = "api_total_tax"
		case sub_total = "sub_total"
		case grand_total = "grand_total"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		api_currency = try values.decodeIfPresent(String.self, forKey: .api_currency)
		api_total_fare = try values.decodeIfPresent(String.self, forKey: .api_total_fare)
		api_total_tax = try values.decodeIfPresent(String.self, forKey: .api_total_tax)
		sub_total = try values.decodeIfPresent(String.self, forKey: .sub_total)
		grand_total = try values.decodeIfPresent(String.self, forKey: .grand_total)
	}

}
