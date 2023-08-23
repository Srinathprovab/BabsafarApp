
import Foundation
struct List : Codable {
	let availablePlans : [[AvailablePlans]]?
	let booking_source : String?

	enum CodingKeys: String, CodingKey {

		case availablePlans = "availablePlans"
		case booking_source = "booking_source"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		availablePlans = try values.decodeIfPresent([[AvailablePlans]].self, forKey: .availablePlans)
		booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
	}

}
