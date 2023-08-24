

import Foundation
struct To : Codable {
	let sku : String?
	let position : Int?
	let category_id : String?

	enum CodingKeys: String, CodingKey {

		case sku = "sku"
		case position = "position"
		case category_id = "category_id"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		sku = try values.decodeIfPresent(String.self, forKey: .sku)
		position = try values.decodeIfPresent(Int.self, forKey: .position)
		category_id = try values.decodeIfPresent(String.self, forKey: .category_id)
	}

}
