

import Foundation
struct PlanMarketingPointer : Codable {
	let pointID : String?

	enum CodingKeys: String, CodingKey {

		case pointID = "PointID"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		pointID = try values.decodeIfPresent(String.self, forKey: .pointID)
	}

}
