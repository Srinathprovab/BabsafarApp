
import Foundation
struct JourneySummary : Codable {
    let from_city : String?
    let from_loc : String?
    let to_city : String?
    let to_loc : String?
    let weight_Allowance : String?
    let cabin_baggage : String?

    enum CodingKeys: String, CodingKey {

        case from_city = "from_city"
        case from_loc = "from_loc"
        case to_city = "to_city"
        case to_loc = "to_loc"
        case weight_Allowance = "Weight_Allowance"
        case cabin_baggage = "cabin_baggage"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        from_city = try values.decodeIfPresent(String.self, forKey: .from_city)
        from_loc = try values.decodeIfPresent(String.self, forKey: .from_loc)
        to_city = try values.decodeIfPresent(String.self, forKey: .to_city)
        to_loc = try values.decodeIfPresent(String.self, forKey: .to_loc)
        weight_Allowance = try values.decodeIfPresent(String.self, forKey: .weight_Allowance)
        cabin_baggage = try values.decodeIfPresent(String.self, forKey: .cabin_baggage)
    }

}
