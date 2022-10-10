
import Foundation
struct Price_breakup : Codable {
    
//	let app_user_buying_price : Double?
	let admin_markup : String?
	let applied_custom_markup : [String]?
	let markup_on_fare : String?

	enum CodingKeys: String, CodingKey {

//		case app_user_buying_price = "app_user_buying_price"
		case admin_markup = "admin_markup"
		case applied_custom_markup = "applied_custom_markup"
		case markup_on_fare = "markup_on_fare"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
	//	app_user_buying_price = try values.decodeIfPresent(Double.self, forKey: .app_user_buying_price)
		admin_markup = try values.decodeIfPresent(String.self, forKey: .admin_markup)
		applied_custom_markup = try values.decodeIfPresent([String].self, forKey: .applied_custom_markup)
		markup_on_fare = try values.decodeIfPresent(String.self, forKey: .markup_on_fare)
	}

}
