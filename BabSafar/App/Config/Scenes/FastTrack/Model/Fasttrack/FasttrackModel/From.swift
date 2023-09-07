

import Foundation
struct From : Codable {
    let sku : String?
    let position : Int?
    let category_id : String?
    let price : Int?
    let api_price : Double?
    let discount : Int?
    let discount_type : String?
    let discount_amount : Int?
    let discounted_price : Int?

    enum CodingKeys: String, CodingKey {

        case sku = "sku"
        case position = "position"
        case category_id = "category_id"
        case price = "price"
        case api_price = "api_price"
        case discount = "discount"
        case discount_type = "discount_type"
        case discount_amount = "discount_amount"
        case discounted_price = "discounted_price"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        sku = try values.decodeIfPresent(String.self, forKey: .sku)
        position = try values.decodeIfPresent(Int.self, forKey: .position)
        category_id = try values.decodeIfPresent(String.self, forKey: .category_id)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        api_price = try values.decodeIfPresent(Double.self, forKey: .api_price)
        discount = try values.decodeIfPresent(Int.self, forKey: .discount)
        discount_type = try values.decodeIfPresent(String.self, forKey: .discount_type)
        discount_amount = try values.decodeIfPresent(Int.self, forKey: .discount_amount)
        discounted_price = try values.decodeIfPresent(Int.self, forKey: .discounted_price)
    }

}
