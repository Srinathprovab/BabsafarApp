
import Foundation
struct Safe_search_data : Codable {
	let child_config : String?
	let v_class : String?
	let is_domestic : Bool?
	let search_id : Int?
	let infant_config : String?
	let ret_jrn : String?
	let to_loc : String?
	let total_pax : Int?
	let trip_type : String?
	let depature : String?
	let to : String?
	let carrier : String?
	let deal_type : String?
	let from : String?
	let to_loc_id : String?
	let from_loc_country : String?
	let from_loc_id : String?
	let to_loc_country : String?
	let out_jrn : String?
	let adult_config : String?
	let trip_type_label : String?
	let from_loc : String?

	enum CodingKeys: String, CodingKey {

		case child_config = "child_config"
		case v_class = "v_class"
		case is_domestic = "is_domestic"
		case search_id = "search_id"
		case infant_config = "infant_config"
		case ret_jrn = "ret_jrn"
		case to_loc = "to_loc"
		case total_pax = "total_pax"
		case trip_type = "trip_type"
		case depature = "depature"
		case to = "to"
		case carrier = "carrier"
		case deal_type = "deal_type"
		case from = "from"
		case to_loc_id = "to_loc_id"
		case from_loc_country = "from_loc_country"
		case from_loc_id = "from_loc_id"
		case to_loc_country = "to_loc_country"
		case out_jrn = "out_jrn"
		case adult_config = "adult_config"
		case trip_type_label = "trip_type_label"
		case from_loc = "from_loc"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		child_config = try values.decodeIfPresent(String.self, forKey: .child_config)
		v_class = try values.decodeIfPresent(String.self, forKey: .v_class)
		is_domestic = try values.decodeIfPresent(Bool.self, forKey: .is_domestic)
		search_id = try values.decodeIfPresent(Int.self, forKey: .search_id)
		infant_config = try values.decodeIfPresent(String.self, forKey: .infant_config)
		ret_jrn = try values.decodeIfPresent(String.self, forKey: .ret_jrn)
		to_loc = try values.decodeIfPresent(String.self, forKey: .to_loc)
		total_pax = try values.decodeIfPresent(Int.self, forKey: .total_pax)
		trip_type = try values.decodeIfPresent(String.self, forKey: .trip_type)
		depature = try values.decodeIfPresent(String.self, forKey: .depature)
		to = try values.decodeIfPresent(String.self, forKey: .to)
		carrier = try values.decodeIfPresent(String.self, forKey: .carrier)
		deal_type = try values.decodeIfPresent(String.self, forKey: .deal_type)
		from = try values.decodeIfPresent(String.self, forKey: .from)
		to_loc_id = try values.decodeIfPresent(String.self, forKey: .to_loc_id)
		from_loc_country = try values.decodeIfPresent(String.self, forKey: .from_loc_country)
		from_loc_id = try values.decodeIfPresent(String.self, forKey: .from_loc_id)
		to_loc_country = try values.decodeIfPresent(String.self, forKey: .to_loc_country)
		out_jrn = try values.decodeIfPresent(String.self, forKey: .out_jrn)
		adult_config = try values.decodeIfPresent(String.self, forKey: .adult_config)
		trip_type_label = try values.decodeIfPresent(String.self, forKey: .trip_type_label)
		from_loc = try values.decodeIfPresent(String.self, forKey: .from_loc)
	}

}
