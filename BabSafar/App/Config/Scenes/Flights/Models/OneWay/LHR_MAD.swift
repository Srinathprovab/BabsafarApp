

import Foundation
struct LHR_MAD : Codable {
	let aDT : ADT?
	let departure_date : String?

	enum CodingKeys: String, CodingKey {

		case aDT = "ADT"
		case departure_date = "departure_date"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		aDT = try values.decodeIfPresent(ADT.self, forKey: .aDT)
		departure_date = try values.decodeIfPresent(String.self, forKey: .departure_date)
	}

}
