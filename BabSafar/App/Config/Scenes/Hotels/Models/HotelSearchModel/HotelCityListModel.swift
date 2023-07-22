//
//  HotelCityListModel.swift
//  BabSafar
//
//  Created by FCI on 28/12/22.
//

import Foundation


struct HotelCityListModel : Codable {
    
    let label : String?
    let value : String?
    let id : String?
    let category : String?
    let type : String?
    let count : Int?

    enum CodingKeys: String, CodingKey {

        case label = "label"
        case value = "value"
        case id = "id"
        case category = "category"
        case type = "type"
        case count = "count"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        label = try values.decodeIfPresent(String.self, forKey: .label)
        value = try values.decodeIfPresent(String.self, forKey: .value)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        category = try values.decodeIfPresent(String.self, forKey: .category)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
    }

}
