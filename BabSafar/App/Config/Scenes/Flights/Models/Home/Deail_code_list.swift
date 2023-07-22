

import Foundation
struct Deail_code_list : Codable {
    let origin : String?
    let module : String?
    let promo_code : String?
    let description : String?
    let ar_description : String?
    let amt_min : String?
    let value : String?
    let value_type : String?
    let use_type : String?
    let limitation : String?
    let start_date : String?
    let expiry_date : String?
    let status : String?
    let created_by_id : String?
    let created_datetime : String?
    let image_path : String?
    let topDealImg : String?

    enum CodingKeys: String, CodingKey {

        case origin = "origin"
        case module = "module"
        case promo_code = "promo_code"
        case description = "description"
        case ar_description = "ar_description"
        case amt_min = "amt_min"
        case value = "value"
        case value_type = "value_type"
        case use_type = "use_type"
        case limitation = "limitation"
        case start_date = "start_date"
        case expiry_date = "expiry_date"
        case status = "status"
        case created_by_id = "created_by_id"
        case created_datetime = "created_datetime"
        case image_path = "image_path"
        case topDealImg = "topDealImg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        origin = try values.decodeIfPresent(String.self, forKey: .origin)
        module = try values.decodeIfPresent(String.self, forKey: .module)
        promo_code = try values.decodeIfPresent(String.self, forKey: .promo_code)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        ar_description = try values.decodeIfPresent(String.self, forKey: .ar_description)
        amt_min = try values.decodeIfPresent(String.self, forKey: .amt_min)
        value = try values.decodeIfPresent(String.self, forKey: .value)
        value_type = try values.decodeIfPresent(String.self, forKey: .value_type)
        use_type = try values.decodeIfPresent(String.self, forKey: .use_type)
        limitation = try values.decodeIfPresent(String.self, forKey: .limitation)
        start_date = try values.decodeIfPresent(String.self, forKey: .start_date)
        expiry_date = try values.decodeIfPresent(String.self, forKey: .expiry_date)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        created_by_id = try values.decodeIfPresent(String.self, forKey: .created_by_id)
        created_datetime = try values.decodeIfPresent(String.self, forKey: .created_datetime)
        image_path = try values.decodeIfPresent(String.self, forKey: .image_path)
        topDealImg = try values.decodeIfPresent(String.self, forKey: .topDealImg)
    }

}
