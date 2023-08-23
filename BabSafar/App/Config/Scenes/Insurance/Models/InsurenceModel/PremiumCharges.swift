
import Foundation
struct PremiumCharges : Codable {
	let charges : Charges?

	enum CodingKeys: String, CodingKey {

		case charges = "Charges"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		charges = try values.decodeIfPresent(Charges.self, forKey: .charges)
	}

}
