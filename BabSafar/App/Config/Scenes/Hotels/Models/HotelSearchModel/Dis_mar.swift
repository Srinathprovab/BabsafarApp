

import Foundation
struct Dis_mar : Codable {
	let discount : [Discount]?

	enum CodingKeys: String, CodingKey {

		case discount = "discount"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		discount = try values.decodeIfPresent([Discount].self, forKey: .discount)
	}

}
