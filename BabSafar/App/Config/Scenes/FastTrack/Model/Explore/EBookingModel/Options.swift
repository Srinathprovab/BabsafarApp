

import Foundation
struct Options : Codable {
    let value : String?
    let title : String?
    let api_price : String?
    let price : Int?
    let price_type : String?
    let formatted_title : String?

    enum CodingKeys: String, CodingKey {

        case value = "value"
        case title = "title"
        case api_price = "api_price"
        case price = "price"
        case price_type = "price_type"
        case formatted_title = "formatted_title"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        value = try values.decodeIfPresent(String.self, forKey: .value)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        api_price = try values.decodeIfPresent(String.self, forKey: .api_price)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        price_type = try values.decodeIfPresent(String.self, forKey: .price_type)
        formatted_title = try values.decodeIfPresent(String.self, forKey: .formatted_title)
    }

}
