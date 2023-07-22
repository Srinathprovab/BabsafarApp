

import Foundation
struct Baggage_details : Codable {
	let origin_loc : String?
	let origin_city : String?
	let destination_loc : String?
	let destination_city : String?
	let weight_Allowance : String?
	let cabin_baggage : String?

	enum CodingKeys: String, CodingKey {

		case origin_loc = "origin_loc"
		case origin_city = "origin_city"
		case destination_loc = "destination_loc"
		case destination_city = "destination_city"
		case weight_Allowance = "Weight_Allowance"
		case cabin_baggage = "cabin_baggage"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		origin_loc = try values.decodeIfPresent(String.self, forKey: .origin_loc)
		origin_city = try values.decodeIfPresent(String.self, forKey: .origin_city)
		destination_loc = try values.decodeIfPresent(String.self, forKey: .destination_loc)
		destination_city = try values.decodeIfPresent(String.self, forKey: .destination_city)
		weight_Allowance = try values.decodeIfPresent(String.self, forKey: .weight_Allowance)
		cabin_baggage = try values.decodeIfPresent(String.self, forKey: .cabin_baggage)
	}

}
