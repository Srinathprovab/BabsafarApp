
import Foundation
struct Condition : Codable {
	let origin : String?
	let mode : String?
	let name : String?
	let value : String?
	let value_type : String?
	let from_location : String?
	let to_location : String?
	let from_loc : String?
	let to_loc : String?
	let from_country : String?
	let to_country : String?
	let from_coun : String?
	let to_coun : String?
	let agent_id : String?
	let sales_chanel : String?
	let user_type : String?
	let min_value : String?
	let max_value : String?
	let unit : String?
	let paxt : String?
	let pos : String?
	let created_by_id : String?
	let status : String?
	let status_updated_at : String?
	let insert_ip : String?
	let updated_ip : String?
	let update_status_ip : String?

	enum CodingKeys: String, CodingKey {

		case origin = "origin"
		case mode = "mode"
		case name = "name"
		case value = "value"
		case value_type = "value_type"
		case from_location = "from_location"
		case to_location = "to_location"
		case from_loc = "from_loc"
		case to_loc = "to_loc"
		case from_country = "from_country"
		case to_country = "to_country"
		case from_coun = "from_coun"
		case to_coun = "to_coun"
		case agent_id = "agent_id"
		case sales_chanel = "sales_chanel"
		case user_type = "user_type"
		case min_value = "min_value"
		case max_value = "max_value"
		case unit = "unit"
		case paxt = "paxt"
		case pos = "pos"
		case created_by_id = "created_by_id"
		case status = "status"
		case status_updated_at = "status_updated_at"
		case insert_ip = "insert_ip"
		case updated_ip = "updated_ip"
		case update_status_ip = "update_status_ip"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		origin = try values.decodeIfPresent(String.self, forKey: .origin)
		mode = try values.decodeIfPresent(String.self, forKey: .mode)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		value = try values.decodeIfPresent(String.self, forKey: .value)
		value_type = try values.decodeIfPresent(String.self, forKey: .value_type)
		from_location = try values.decodeIfPresent(String.self, forKey: .from_location)
		to_location = try values.decodeIfPresent(String.self, forKey: .to_location)
		from_loc = try values.decodeIfPresent(String.self, forKey: .from_loc)
		to_loc = try values.decodeIfPresent(String.self, forKey: .to_loc)
		from_country = try values.decodeIfPresent(String.self, forKey: .from_country)
		to_country = try values.decodeIfPresent(String.self, forKey: .to_country)
		from_coun = try values.decodeIfPresent(String.self, forKey: .from_coun)
		to_coun = try values.decodeIfPresent(String.self, forKey: .to_coun)
		agent_id = try values.decodeIfPresent(String.self, forKey: .agent_id)
		sales_chanel = try values.decodeIfPresent(String.self, forKey: .sales_chanel)
		user_type = try values.decodeIfPresent(String.self, forKey: .user_type)
		min_value = try values.decodeIfPresent(String.self, forKey: .min_value)
		max_value = try values.decodeIfPresent(String.self, forKey: .max_value)
		unit = try values.decodeIfPresent(String.self, forKey: .unit)
		paxt = try values.decodeIfPresent(String.self, forKey: .paxt)
		pos = try values.decodeIfPresent(String.self, forKey: .pos)
		created_by_id = try values.decodeIfPresent(String.self, forKey: .created_by_id)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		status_updated_at = try values.decodeIfPresent(String.self, forKey: .status_updated_at)
		insert_ip = try values.decodeIfPresent(String.self, forKey: .insert_ip)
		updated_ip = try values.decodeIfPresent(String.self, forKey: .updated_ip)
		update_status_ip = try values.decodeIfPresent(String.self, forKey: .update_status_ip)
	}

}
