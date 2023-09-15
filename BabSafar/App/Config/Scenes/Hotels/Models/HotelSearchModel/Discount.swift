

import Foundation
struct Discount : Codable {
    let start_price : String?
    let value : String?
    let end_price : String?
    let value_type : String?
    let origin : String?
    let unit : String?

    enum CodingKeys: String, CodingKey {

        case start_price = "start_price"
        case value = "value"
        case end_price = "end_price"
        case value_type = "value_type"
        case origin = "origin"
        case unit = "unit"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        start_price = try values.decodeIfPresent(String.self, forKey: .start_price)
        value = try values.decodeIfPresent(String.self, forKey: .value)
        end_price = try values.decodeIfPresent(String.self, forKey: .end_price)
        value_type = try values.decodeIfPresent(String.self, forKey: .value_type)
        origin = try values.decodeIfPresent(String.self, forKey: .origin)
        unit = try values.decodeIfPresent(String.self, forKey: .unit)
    }

}
