
import Foundation
struct Flight_details : Codable {
	let summary : [Summary]?

	enum CodingKeys: String, CodingKey {

		case summary = "summary"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		summary = try values.decodeIfPresent([Summary].self, forKey: .summary)
	}

}
