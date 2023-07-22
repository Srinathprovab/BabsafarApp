

import Foundation
struct AirFareRule : Codable {
	let airFareRuleLong : [AirFareRuleLong]?
	let attributes : Attributes?

	enum CodingKeys: String, CodingKey {

		case airFareRuleLong = "air:FareRuleLong"
		case attributes = "@attributes"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		airFareRuleLong = try values.decodeIfPresent([AirFareRuleLong].self, forKey: .airFareRuleLong)
		attributes = try values.decodeIfPresent(Attributes.self, forKey: .attributes)
	}

}
