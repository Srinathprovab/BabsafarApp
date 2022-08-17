

import Foundation
struct ADT : Codable {
    
	let value : String?
	let unit : String?
	let key : String?
	let dep_date : String?
	let pas_cod : String?
	let origin : String?
	let destination : String?

	enum CodingKeys: String, CodingKey {

		case value = "value"
		case unit = "unit"
		case key = "key"
		case dep_date = "dep_date"
		case pas_cod = "pas_cod"
		case origin = "origin"
		case destination = "destination"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		value = try values.decodeIfPresent(String.self, forKey: .value)
		unit = try values.decodeIfPresent(String.self, forKey: .unit)
		key = try values.decodeIfPresent(String.self, forKey: .key)
		dep_date = try values.decodeIfPresent(String.self, forKey: .dep_date)
		pas_cod = try values.decodeIfPresent(String.self, forKey: .pas_cod)
		origin = try values.decodeIfPresent(String.self, forKey: .origin)
		destination = try values.decodeIfPresent(String.self, forKey: .destination)
	}

}
