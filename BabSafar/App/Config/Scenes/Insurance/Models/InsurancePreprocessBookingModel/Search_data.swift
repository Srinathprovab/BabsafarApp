
import Foundation
struct Search_data : Codable {
	let depature : String?
	let from : String?
	let from_loc_id : String?
	let to : String?
	let to_loc_id : String?
	let to_loc : String?
	let from_loc : String?
	let from_loc_country : String?
	let to_loc_country : String?
	let total_pax : Int?
	let trip_type : String?
	let adult_config : String?
	let child_config : String?
	let infant_config : String?
	let search_id : Int?

	enum CodingKeys: String, CodingKey {

		case depature = "depature"
		case from = "from"
		case from_loc_id = "from_loc_id"
		case to = "to"
		case to_loc_id = "to_loc_id"
		case to_loc = "to_loc"
		case from_loc = "from_loc"
		case from_loc_country = "from_loc_country"
		case to_loc_country = "to_loc_country"
		case total_pax = "total_pax"
		case trip_type = "trip_type"
		case adult_config = "adult_config"
		case child_config = "child_config"
		case infant_config = "infant_config"
		case search_id = "search_id"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		depature = try values.decodeIfPresent(String.self, forKey: .depature)
		from = try values.decodeIfPresent(String.self, forKey: .from)
		from_loc_id = try values.decodeIfPresent(String.self, forKey: .from_loc_id)
		to = try values.decodeIfPresent(String.self, forKey: .to)
		to_loc_id = try values.decodeIfPresent(String.self, forKey: .to_loc_id)
		to_loc = try values.decodeIfPresent(String.self, forKey: .to_loc)
		from_loc = try values.decodeIfPresent(String.self, forKey: .from_loc)
		from_loc_country = try values.decodeIfPresent(String.self, forKey: .from_loc_country)
		to_loc_country = try values.decodeIfPresent(String.self, forKey: .to_loc_country)
		total_pax = try values.decodeIfPresent(Int.self, forKey: .total_pax)
		trip_type = try values.decodeIfPresent(String.self, forKey: .trip_type)
		adult_config = try values.decodeIfPresent(String.self, forKey: .adult_config)
		child_config = try values.decodeIfPresent(String.self, forKey: .child_config)
		infant_config = try values.decodeIfPresent(String.self, forKey: .infant_config)
		search_id = try values.decodeIfPresent(Int.self, forKey: .search_id)
	}

}
