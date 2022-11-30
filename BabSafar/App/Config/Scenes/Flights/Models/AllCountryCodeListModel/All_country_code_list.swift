

import Foundation
struct All_country_code_list : Codable {
	let origin : String?
	let api_continent_list_fk : String?
	let name : String?
	let country_code : String?
	let iso_country_code : String?

	enum CodingKeys: String, CodingKey {

		case origin = "origin"
		case api_continent_list_fk = "api_continent_list_fk"
		case name = "name"
		case country_code = "country_code"
		case iso_country_code = "iso_country_code"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		origin = try values.decodeIfPresent(String.self, forKey: .origin)
		api_continent_list_fk = try values.decodeIfPresent(String.self, forKey: .api_continent_list_fk)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		country_code = try values.decodeIfPresent(String.self, forKey: .country_code)
		iso_country_code = try values.decodeIfPresent(String.self, forKey: .iso_country_code)
	}

}
