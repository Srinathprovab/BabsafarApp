

import Foundation
struct Form_fields : Codable {
	let option_id : Int?
	let type : String?
	let title : String?
	let required : Bool?
	let max_characters : Int?
	let image_size_x : Int?
	let image_size_y : Int?
	let options : [Options]?

	enum CodingKeys: String, CodingKey {

		case option_id = "option_id"
		case type = "type"
		case title = "title"
		case required = "required"
		case max_characters = "max_characters"
		case image_size_x = "image_size_x"
		case image_size_y = "image_size_y"
		case options = "options"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		option_id = try values.decodeIfPresent(Int.self, forKey: .option_id)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		required = try values.decodeIfPresent(Bool.self, forKey: .required)
		max_characters = try values.decodeIfPresent(Int.self, forKey: .max_characters)
		image_size_x = try values.decodeIfPresent(Int.self, forKey: .image_size_x)
		image_size_y = try values.decodeIfPresent(Int.self, forKey: .image_size_y)
		options = try values.decodeIfPresent([Options].self, forKey: .options)
	}

}
