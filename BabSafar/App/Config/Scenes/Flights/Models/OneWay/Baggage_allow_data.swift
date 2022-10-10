

import Foundation
struct Baggage_allow_data : Codable {
	let lHR_MAD : LHR_MAD?

	enum CodingKeys: String, CodingKey {

		case lHR_MAD = "LHR_MAD"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		lHR_MAD = try values.decodeIfPresent(LHR_MAD.self, forKey: .lHR_MAD)
	}

}
