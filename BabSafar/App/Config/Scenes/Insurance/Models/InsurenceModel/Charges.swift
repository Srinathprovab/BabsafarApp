
import Foundation
struct Charges : Codable {
	let charge : [Charge]?

	enum CodingKeys: String, CodingKey {

		case charge = "Charge"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		charge = try values.decodeIfPresent([Charge].self, forKey: .charge)
	}

}
