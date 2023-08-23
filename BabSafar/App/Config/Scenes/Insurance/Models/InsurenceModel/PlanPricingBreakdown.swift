

import Foundation
struct PlanPricingBreakdown : Codable {
	let pricingBreakdown : [PricingBreakdown]?

	enum CodingKeys: String, CodingKey {

		case pricingBreakdown = "PricingBreakdown"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		pricingBreakdown = try values.decodeIfPresent([PricingBreakdown].self, forKey: .pricingBreakdown)
	}

}
