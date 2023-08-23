//
//  AirlineListModel.swift
//  BabSafar
//
//  Created by FCI on 23/08/23.
//

import Foundation


struct AirlineListModel : Codable {
    let label : String?
    let value : String?
    let id : String?
    let code : String?
    let category : String?
    let type : String?

    enum CodingKeys: String, CodingKey {

        case label = "label"
        case value = "value"
        case id = "id"
        case code = "code"
        case category = "category"
        case type = "type"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        label = try values.decodeIfPresent(String.self, forKey: .label)
        value = try values.decodeIfPresent(String.self, forKey: .value)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        category = try values.decodeIfPresent(String.self, forKey: .category)
        type = try values.decodeIfPresent(String.self, forKey: .type)
    }

}
