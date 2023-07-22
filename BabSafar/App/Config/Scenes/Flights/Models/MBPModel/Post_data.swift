

import Foundation
struct Post_data : Codable {
    let search_id : String?
    let app_reference : String?
    let promocode_val : String?
    let url : String?

    enum CodingKeys: String, CodingKey {

        case search_id = "search_id"
        case app_reference = "app_reference"
        case promocode_val = "promocode_val"
        case url = "url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
        app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
        promocode_val = try values.decodeIfPresent(String.self, forKey: .promocode_val)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }

}
