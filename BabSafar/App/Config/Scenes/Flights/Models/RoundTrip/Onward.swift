

import Foundation
struct Onward : Codable {
	let segments : [Segments]?

	enum CodingKeys: String, CodingKey {

		case segments = "segments"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		segments = try values.decodeIfPresent([Segments].self, forKey: .segments)
	}

}
