
import Foundation

struct More_results : Codable {
	let searchId : String?
	let flight_details : Flight_details?
	let price : Price?
	let fare : MoreResultFare?
	let access_key : String?

	enum CodingKeys: String, CodingKey {

		case searchId = "SearchId"
		case flight_details = "flight_details"
		case price = "price"
		case fare = "fare"
		case access_key = "access_key"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		searchId = try values.decodeIfPresent(String.self, forKey: .searchId)
		flight_details = try values.decodeIfPresent(Flight_details.self, forKey: .flight_details)
		price = try values.decodeIfPresent(Price.self, forKey: .price)
		fare = try values.decodeIfPresent(MoreResultFare.self, forKey: .fare)
		access_key = try values.decodeIfPresent(String.self, forKey: .access_key)
	}

}
