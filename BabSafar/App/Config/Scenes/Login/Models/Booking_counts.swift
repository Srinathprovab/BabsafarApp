

import Foundation
struct Booking_counts : Codable {
	let hotel_booking_count : String?
	let flight_booking_count : String?

	enum CodingKeys: String, CodingKey {

		case hotel_booking_count = "hotel_booking_count"
		case flight_booking_count = "flight_booking_count"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		hotel_booking_count = try values.decodeIfPresent(String.self, forKey: .hotel_booking_count)
		flight_booking_count = try values.decodeIfPresent(String.self, forKey: .flight_booking_count)
	}

}
