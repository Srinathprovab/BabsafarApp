

import Foundation
struct Col_x : Codable {
	let search_params : iSearch_params?
	let attr : Attr?
	let list : List?
	let search_id : Int?
	let booking_source_key : String?
	let booking_source : String?

	enum CodingKeys: String, CodingKey {

		case search_params = "search_params"
		case attr = "attr"
		case list = "list"
		case search_id = "search_id"
		case booking_source_key = "booking_source_key"
		case booking_source = "booking_source"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		search_params = try values.decodeIfPresent(iSearch_params.self, forKey: .search_params)
		attr = try values.decodeIfPresent(Attr.self, forKey: .attr)
		list = try values.decodeIfPresent(List.self, forKey: .list)
		search_id = try values.decodeIfPresent(Int.self, forKey: .search_id)
		booking_source_key = try values.decodeIfPresent(String.self, forKey: .booking_source_key)
		booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
	}

}
