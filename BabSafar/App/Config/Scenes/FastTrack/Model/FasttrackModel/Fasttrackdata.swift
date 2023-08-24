

import Foundation
struct Fasttrackdata : Codable {
	let col_x : FCol_x?

	enum CodingKeys: String, CodingKey {

		case col_x = "col_x"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		col_x = try values.decodeIfPresent(FCol_x.self, forKey: .col_x)
	}

}
