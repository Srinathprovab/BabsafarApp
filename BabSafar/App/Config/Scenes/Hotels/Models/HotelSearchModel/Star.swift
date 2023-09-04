

import Foundation
struct Star : Codable {
	let c : Int?
	let v : Int?

	enum CodingKeys: String, CodingKey {

		case c = "c"
		case v = "v"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		c = try values.decodeIfPresent(Int.self, forKey: .c)
		v = try values.decodeIfPresent(Int.self, forKey: .v)
	}

}
