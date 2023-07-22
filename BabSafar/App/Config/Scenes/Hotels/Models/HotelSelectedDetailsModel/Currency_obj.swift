
import Foundation
struct Currency_obj : Codable {
    let to_currency : String?
    let conversion_rate : String?

    enum CodingKeys: String, CodingKey {

        case to_currency = "to_currency"
        case conversion_rate = "conversion_rate"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        to_currency = try values.decodeIfPresent(String.self, forKey: .to_currency)
        conversion_rate = try values.decodeIfPresent(String.self, forKey: .conversion_rate)
    }

}
