

import Foundation
struct PlanMarketingPointers : Codable {
	let planMarketingPointer : PlanMarketingPointer?

	enum CodingKeys: String, CodingKey {

		case planMarketingPointer = "PlanMarketingPointer"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		planMarketingPointer = try values.decodeIfPresent(PlanMarketingPointer.self, forKey: .planMarketingPointer)
	}

}
