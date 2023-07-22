

import Foundation
struct AirFareRuleLong : Codable {
	let value : String?
	let attributes : Attributes?

	enum CodingKeys: String, CodingKey {

		case value = "@value"
		case attributes = "@attributes"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		value = try values.decodeIfPresent(String.self, forKey: .value)
		attributes = try values.decodeIfPresent(Attributes.self, forKey: .attributes)
	}

}
