

import Foundation
struct Discount : Codable {
	let origin : String?
	let value : String?
	let value_type : String?
	let unit : String?
	let start_price : String?
	let end_price : String?

	enum CodingKeys: String, CodingKey {

		case origin = "origin"
		case value = "value"
		case value_type = "value_type"
		case unit = "unit"
		case start_price = "start_price"
		case end_price = "end_price"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		origin = try values.decodeIfPresent(String.self, forKey: .origin)
		value = try values.decodeIfPresent(String.self, forKey: .value)
		value_type = try values.decodeIfPresent(String.self, forKey: .value_type)
		unit = try values.decodeIfPresent(String.self, forKey: .unit)
		start_price = try values.decodeIfPresent(String.self, forKey: .start_price)
		end_price = try values.decodeIfPresent(String.self, forKey: .end_price)
	}

}
