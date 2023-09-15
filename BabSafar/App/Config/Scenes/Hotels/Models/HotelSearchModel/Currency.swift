

import Foundation
struct HCurrency : Codable {
	let type : String?

	enum CodingKeys: String, CodingKey {

		case type = "type"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		type = try values.decodeIfPresent(String.self, forKey: .type)
	}

}
