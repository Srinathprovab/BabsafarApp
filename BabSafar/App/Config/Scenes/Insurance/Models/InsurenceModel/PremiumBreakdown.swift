

import Foundation
struct PremiumBreakdown : Codable {
	let premiumCharges : PremiumCharges?

	enum CodingKeys: String, CodingKey {

		case premiumCharges = "PremiumCharges"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		premiumCharges = try values.decodeIfPresent(PremiumCharges.self, forKey: .premiumCharges)
	}

}
