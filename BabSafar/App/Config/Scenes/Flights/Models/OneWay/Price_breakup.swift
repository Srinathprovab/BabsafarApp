
import Foundation
struct Price_breakup : Codable {
    let app_user_buying_price : Double?
    let admin_markup : Int?
    let private_admin_markup : Int?

    enum CodingKeys: String, CodingKey {

        case app_user_buying_price = "app_user_buying_price"
        case admin_markup = "admin_markup"
        case private_admin_markup = "private_admin_markup"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        app_user_buying_price = try values.decodeIfPresent(Double.self, forKey: .app_user_buying_price)
        admin_markup = try values.decodeIfPresent(Int.self, forKey: .admin_markup)
        private_admin_markup = try values.decodeIfPresent(Int.self, forKey: .private_admin_markup)
    }

}
