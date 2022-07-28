

import Foundation
struct BookingCountModel : Codable {
	let booking_counts : Booking_counts?
	let country_code : [Country_code]?
	let postal_code : String?
	let latest_transaction : [String]?
	let reward_booking_report : [String]?
	let reward_booking_report_data : [String]?
	let reward_total_report : [Reward_total_report]?

	enum CodingKeys: String, CodingKey {

		case booking_counts = "booking_counts"
		case country_code = "country_code"
		case postal_code = "postal_code"
		case latest_transaction = "latest_transaction"
		case reward_booking_report = "reward_booking_report"
		case reward_booking_report_data = "reward_booking_report_data"
		case reward_total_report = "reward_total_report"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		booking_counts = try values.decodeIfPresent(Booking_counts.self, forKey: .booking_counts)
		country_code = try values.decodeIfPresent([Country_code].self, forKey: .country_code)
		postal_code = try values.decodeIfPresent(String.self, forKey: .postal_code)
		latest_transaction = try values.decodeIfPresent([String].self, forKey: .latest_transaction)
		reward_booking_report = try values.decodeIfPresent([String].self, forKey: .reward_booking_report)
		reward_booking_report_data = try values.decodeIfPresent([String].self, forKey: .reward_booking_report_data)
		reward_total_report = try values.decodeIfPresent([Reward_total_report].self, forKey: .reward_total_report)
	}

}
