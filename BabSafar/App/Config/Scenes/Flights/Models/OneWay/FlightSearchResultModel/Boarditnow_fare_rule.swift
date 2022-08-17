

import Foundation
struct Boarditnow_fare_rule : Codable {
	let page_description : String?
	let page_status : String?

	enum CodingKeys: String, CodingKey {

		case page_description = "page_description"
		case page_status = "page_status"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		page_description = try values.decodeIfPresent(String.self, forKey: .page_description)
		page_status = try values.decodeIfPresent(String.self, forKey: .page_status)
	}

}
