

import Foundation
struct Details : Codable {
	let flight_number : String?
	let display_operator_code : String?
	let no_of_stops : Int?
	let cabin_class : String?
	let duration_seconds : Int?
	let operator_code : String?
	let origin : Origin?
	let destination : Destination?
	let operator_name : String?
	let duration : String?
	let dclass : Class?
	let weight_Allowance : String?

	enum CodingKeys: String, CodingKey {

		case flight_number = "flight_number"
		case display_operator_code = "display_operator_code"
		case no_of_stops = "no_of_stops"
		case cabin_class = "cabin_class"
		case duration_seconds = "duration_seconds"
		case operator_code = "operator_code"
		case origin = "origin"
		case destination = "destination"
		case operator_name = "operator_name"
		case duration = "duration"
		case dclass = "class"
		case weight_Allowance = "Weight_Allowance"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		flight_number = try values.decodeIfPresent(String.self, forKey: .flight_number)
		display_operator_code = try values.decodeIfPresent(String.self, forKey: .display_operator_code)
		no_of_stops = try values.decodeIfPresent(Int.self, forKey: .no_of_stops)
		cabin_class = try values.decodeIfPresent(String.self, forKey: .cabin_class)
		duration_seconds = try values.decodeIfPresent(Int.self, forKey: .duration_seconds)
		operator_code = try values.decodeIfPresent(String.self, forKey: .operator_code)
		origin = try values.decodeIfPresent(Origin.self, forKey: .origin)
		destination = try values.decodeIfPresent(Destination.self, forKey: .destination)
		operator_name = try values.decodeIfPresent(String.self, forKey: .operator_name)
		duration = try values.decodeIfPresent(String.self, forKey: .duration)
		dclass = try values.decodeIfPresent(Class.self, forKey: .dclass)
		weight_Allowance = try values.decodeIfPresent(String.self, forKey: .weight_Allowance)
	}

}
