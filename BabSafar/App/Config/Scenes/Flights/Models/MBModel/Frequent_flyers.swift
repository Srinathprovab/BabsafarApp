

import Foundation
struct Frequent_flyers : Codable {
    let airline_name : String?
    let search_id : String?
    let origin : String?
    let airline_code : String?

    enum CodingKeys: String, CodingKey {

        case airline_name = "Airline_name"
        case search_id = "search_id"
        case origin = "origin"
        case airline_code = "airline_code"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        airline_name = try values.decodeIfPresent(String.self, forKey: .airline_name)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
        origin = try values.decodeIfPresent(String.self, forKey: .origin)
        airline_code = try values.decodeIfPresent(String.self, forKey: .airline_code)
    }

}
