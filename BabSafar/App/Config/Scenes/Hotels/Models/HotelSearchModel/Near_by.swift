

import Foundation
struct Near_by : Codable {
	let c : String?
	let v : String?

	enum CodingKeys: String, CodingKey {

		case c = "c"
		case v = "v"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		c = try values.decodeIfPresent(String.self, forKey: .c)
		v = try values.decodeIfPresent(String.self, forKey: .v)
	}

}
