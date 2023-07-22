

import Foundation
struct Room_paxes_details : Codable {
	let room_name : String?
	let boardName : String?
	let rateKey : String?
	let no_of_rooms : Int?
	let no_of_adults : Int?
	let no_of_children : Int?
	let childrenAges : String?
	let childrenAges_with_year : String?
	let xml_currency : String?
	let xml_net : String?
	let currency : String?
	let net : String?

	enum CodingKeys: String, CodingKey {

		case room_name = "room_name"
		case boardName = "boardName"
		case rateKey = "rateKey"
		case no_of_rooms = "no_of_rooms"
		case no_of_adults = "no_of_adults"
		case no_of_children = "no_of_children"
		case childrenAges = "childrenAges"
		case childrenAges_with_year = "childrenAges_with_year"
		case xml_currency = "xml_currency"
		case xml_net = "xml_net"
		case currency = "currency"
		case net = "net"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		room_name = try values.decodeIfPresent(String.self, forKey: .room_name)
		boardName = try values.decodeIfPresent(String.self, forKey: .boardName)
		rateKey = try values.decodeIfPresent(String.self, forKey: .rateKey)
		no_of_rooms = try values.decodeIfPresent(Int.self, forKey: .no_of_rooms)
		no_of_adults = try values.decodeIfPresent(Int.self, forKey: .no_of_adults)
		no_of_children = try values.decodeIfPresent(Int.self, forKey: .no_of_children)
		childrenAges = try values.decodeIfPresent(String.self, forKey: .childrenAges)
		childrenAges_with_year = try values.decodeIfPresent(String.self, forKey: .childrenAges_with_year)
		xml_currency = try values.decodeIfPresent(String.self, forKey: .xml_currency)
		xml_net = try values.decodeIfPresent(String.self, forKey: .xml_net)
		currency = try values.decodeIfPresent(String.self, forKey: .currency)
		net = try values.decodeIfPresent(String.self, forKey: .net)
	}

}
