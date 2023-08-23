

import Foundation
struct PlanContent : Codable {
	let title : String?
	let image : String?

	enum CodingKeys: String, CodingKey {

		case title = "title"
		case image = "image"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		image = try values.decodeIfPresent(String.self, forKey: .image)
	}

}
