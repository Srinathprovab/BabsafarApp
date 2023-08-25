

import Foundation
struct Hotel_desc : Codable {
	let meals : String?
	let rooms : String?
	let payment : String?
	let location : String?
	let facilities : String?
	let sportsEntertainment : String?

	enum CodingKeys: String, CodingKey {

		case meals = "Meals"
		case rooms = "Rooms"
		case payment = "Payment"
		case location = "Location"
		case facilities = "Facilities"
		case sportsEntertainment = "Sports/Entertainment"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		meals = try values.decodeIfPresent(String.self, forKey: .meals)
		rooms = try values.decodeIfPresent(String.self, forKey: .rooms)
		payment = try values.decodeIfPresent(String.self, forKey: .payment)
		location = try values.decodeIfPresent(String.self, forKey: .location)
		facilities = try values.decodeIfPresent(String.self, forKey: .facilities)
		sportsEntertainment = try values.decodeIfPresent(String.self, forKey: .sportsEntertainment)
	}

}
