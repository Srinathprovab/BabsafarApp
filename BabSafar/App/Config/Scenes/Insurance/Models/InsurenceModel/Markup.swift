

import Foundation
struct Markup : Codable {
	let value : Int?
	let condition : Condition?

	enum CodingKeys: String, CodingKey {

		case value = "value"
		case condition = "condition"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		value = try values.decodeIfPresent(Int.self, forKey: .value)
		condition = try values.decodeIfPresent(Condition.self, forKey: .condition)
	}

}
