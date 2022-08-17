

import Foundation
struct Baggage_allow_data : Codable {
	let lGW_MAD : LGW_MAD?

	enum CodingKeys: String, CodingKey {

		case lGW_MAD = "LGW_MAD"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		lGW_MAD = try values.decodeIfPresent(LGW_MAD.self, forKey: .lGW_MAD)
	}

}
