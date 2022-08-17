

import Foundation
struct Segments : Codable {
	let flightDetailsRef_Key : String?

	enum CodingKeys: String, CodingKey {

		case flightDetailsRef_Key = "FlightDetailsRef_Key"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		flightDetailsRef_Key = try values.decodeIfPresent(String.self, forKey: .flightDetailsRef_Key)
	}

}
