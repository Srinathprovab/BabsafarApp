
import Foundation
struct Loc : Codable {
	let c : Int?
	let v : String?

	enum CodingKeys: String, CodingKey {

		case c = "c"
		case v = "v"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		c = try values.decodeIfPresent(Int.self, forKey: .c)
		v = try values.decodeIfPresent(String.self, forKey: .v)
	}

}
