

import Foundation
struct Frequent_flyers : Codable {
	let origin : String?
	let search_id : String?
	let airline_code : String?
	let airline_name : String?

	enum CodingKeys: String, CodingKey {

		case origin = "origin"
		case search_id = "search_id"
		case airline_code = "airline_code"
		case airline_name = "Airline_name"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		origin = try values.decodeIfPresent(String.self, forKey: .origin)
		search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
		airline_code = try values.decodeIfPresent(String.self, forKey: .airline_code)
		airline_name = try values.decodeIfPresent(String.self, forKey: .airline_name)
	}

}
