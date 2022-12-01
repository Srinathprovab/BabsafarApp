




import Foundation
struct SelectCityModel : Codable {
    let label : String?
    let value : String?
    let city : String?
    let country : String?
    let code : String?
    let name : String?
    let id : String?
    let category : String?
    let type : String?

    enum CodingKeys: String, CodingKey {

        case label = "label"
        case value = "value"
        case city = "city"
        case country = "country"
        case code = "code"
        case name = "name"
        case id = "id"
        case category = "category"
        case type = "type"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        label = try values.decodeIfPresent(String.self, forKey: .label)
        value = try values.decodeIfPresent(String.self, forKey: .value)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        category = try values.decodeIfPresent(String.self, forKey: .category)
        type = try values.decodeIfPresent(String.self, forKey: .type)
    }

}
