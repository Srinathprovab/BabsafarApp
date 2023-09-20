

import Foundation
struct Params : Codable {
    let search_id : String?
    let hotel_id : String?
    let booking_source : String?

    enum CodingKeys: String, CodingKey {

        case search_id = "search_id"
        case hotel_id = "hotel_id"
        case booking_source = "booking_source"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
        hotel_id = try values.decodeIfPresent(String.self, forKey: .hotel_id)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
    }

}
