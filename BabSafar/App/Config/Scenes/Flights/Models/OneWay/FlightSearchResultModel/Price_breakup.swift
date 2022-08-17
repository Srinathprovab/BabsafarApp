
import Foundation
struct Price_breakup : Codable {
	let app_user_buying_price : Int?
	let admin_markup : String?

	enum CodingKeys: String, CodingKey {

		case app_user_buying_price = "app_user_buying_price"
		case admin_markup = "admin_markup"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		app_user_buying_price = try values.decodeIfPresent(Int.self, forKey: .app_user_buying_price)
		admin_markup = try values.decodeIfPresent(String.self, forKey: .admin_markup)
	}

}
